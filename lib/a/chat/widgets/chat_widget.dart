import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/providers/auth_provider.dart';
import '../../../core/widgets/constants.dart';
import '../models/chat_message.dart';
import '../models/chat_user.dart';
import '../models/conversation.dart';
import '../services/chat_api_service.dart';
import '../services/chat_socket_service.dart';
import '../data/chat_fallback_managers.dart';
import '../data/mock_data.dart';
import 'chat_input.dart';
import 'conversation_tile.dart';
import 'message_bubble.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key, required this.userType, this.onClose});

  final UserType userType;
  final VoidCallback? onClose;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  static const _referenceWidth = 1200.0;
  static const _referenceHeight = 760.0;
  static const _layoutScreenWidth = 1920.0;

  List<Conversation> _conversations = [];
  List<ChatUser> _discoveredUsers = [];
  Conversation? _selectedConversation;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ChatApiService? _chatApiService;
  ChatSocketService? _chatSocketService;
  bool _isLoading = true;
  bool _isLoadingMessages = false;
  bool _isSending = false;
  bool _isCreatingConversation = false;
  String _currentUserId = '';
  String _currentSocketUserId = '';
  String _currentUserRole = '';
  String? _joinedRoomId;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadConversations());
  }

  @override
  void dispose() {
    _leaveJoinedRoom();
    _chatSocketService?.disconnect();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadConversations() async {
    final authProvider = context.read<AuthProvider>();
    final authInfo = UserAuthInfo(
      id: authProvider.id ?? '',
      role: authProvider.role ?? '',
      accessToken: authProvider.accessToken ?? '',
      refreshToken: authProvider.refreshToken ?? '',
    );
    final socketUserId = _userIdFromToken(authInfo.accessToken) ?? authInfo.id;

    if (_isBlockedRole(authInfo.role)) {
      setState(() {
        _currentUserId = authInfo.id;
        _currentSocketUserId = socketUserId;
        _currentUserRole = authInfo.role;
        _isLoading = false;
        _errorMessage = 'Chat is not available for this account';
        _conversations = [];
        _selectedConversation = null;
      });
      return;
    }

    if (authInfo.accessToken.isEmpty || authInfo.id.isEmpty) {
      setState(() {
        _currentUserId = authInfo.id;
        _currentSocketUserId = socketUserId;
        _currentUserRole = authInfo.role;
        _isLoading = false;
        _errorMessage = 'Login data is missing';
        _conversations = [];
        _selectedConversation = null;
      });
      return;
    }

    setState(() {
      _currentUserId = authInfo.id;
      _currentSocketUserId = socketUserId;
      _currentUserRole = authInfo.role;
      _chatApiService = ChatApiService(userAuthInfo: authInfo);
      _chatSocketService?.disconnect();
      _chatSocketService =
          ChatSocketService(
              token: authInfo.accessToken,
              currentUserId: socketUserId,
            )
            ..onMessageCreated = _handleSocketMessageCreated
            ..onMessageEdited = _handleSocketMessageEdited
            ..onMessageDeleted = _handleSocketMessageDeleted
            ..onMessageRead = _handleSocketMessageRead
            ..connect();
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final conversations = await _chatApiService!.getAllChats();
      final discoveredUsers = _isManagerRole(authInfo.role)
          ? await _loadEmployeesForManager()
          : await _loadManagersForEmployee(authInfo, conversations);
      final hydratedConversations = await _hydrateSparseConversations(
        conversations,
        discoveredUsers,
      );
      final visibleConversations = _withDiscoveredUserPlaceholders(
        hydratedConversations,
        discoveredUsers,
      );
      if (!mounted) return;

      setState(() {
        _discoveredUsers = discoveredUsers;
        _conversations = visibleConversations;
        _selectedConversation = visibleConversations.isNotEmpty
            ? visibleConversations.first
            : null;
        _isLoading = false;
      });

      final selected = _selectedConversation;
      if (selected != null) {
        _joinConversationRoom(selected);
        await _loadMessages(selected);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading conversations';
        _conversations = [];
        _selectedConversation = null;
      });
    }
  }

  Future<void> _selectConversation(Conversation conversation) async {
    setState(() => _selectedConversation = conversation);
    if (conversation.isPlaceholder) return;
    _joinConversationRoom(conversation);
    await _loadMessages(conversation);
  }

  Future<void> _loadMessages(Conversation conversation) async {
    final service = _chatApiService;
    if (service == null || conversation.id.isEmpty) return;

    setState(() => _isLoadingMessages = true);

    try {
      final messages = await service.getChatMessages(conversation.id);
      if (!mounted) return;

      final sortedMessages = _sortedMessages(messages);
      final updatedConversation = conversation.copyWith(
        messages: sortedMessages,
        lastMessage: sortedMessages.isEmpty ? null : sortedMessages.last,
      );
      setState(() {
        _conversations = _conversations
            .map(
              (item) => item.id == updatedConversation.id
                  ? updatedConversation
                  : item,
            )
            .toList();
        _selectedConversation = updatedConversation;
        _isLoadingMessages = false;
      });
      _joinConversationRoom(updatedConversation);
      _markConversationAsRead(updatedConversation);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoadingMessages = false;
        _errorMessage = 'Error loading conversation';
      });
    }
  }

  Future<void> _sendMessage() async {
    final service = _chatApiService;
    var conversation = _selectedConversation;
    final text = _messageController.text.trim();
    if (text.isEmpty || service == null || conversation == null || _isSending) {
      return;
    }

    setState(() {
      _isSending = true;
      _errorMessage = null;
    });

    try {
      if (conversation.isPlaceholder) {
        conversation = await _createConversationFromPlaceholder(conversation);
        if (conversation == null) {
          if (mounted) {
            setState(() => _isSending = false);
          }
          return;
        }
      }
      final activeConversation = conversation;

      final sentMessage = await service.sendMessage(
        chatId: activeConversation.id,
        message: text,
      );
      if (!mounted) return;

      final updatedMessages = _sortedMessages([
        ...activeConversation.messages,
        sentMessage,
      ]);
      final updatedConversation = activeConversation.copyWith(
        lastMessage: updatedMessages.last,
        messages: updatedMessages,
      );

      setState(() {
        _messageController.clear();
        _conversations = _conversations
            .map(
              (item) =>
                  item.id == activeConversation.id ? updatedConversation : item,
            )
            .toList();
        _selectedConversation = updatedConversation;
        _isSending = false;
      });
      _scrollToBottom();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isSending = false;
        _errorMessage = 'Failed to send message';
      });
    }
  }

  Future<void> _showCreateConversationDialog() async {
    if (_isCreatingConversation || _chatApiService == null) return;

    final targets = _availableChatUsers;
    if (targets.isEmpty) {
      _showSnackBar('No available people from loaded chats');
      return;
    }

    final selectedIds = <String>{};
    final selectedUsers = targets.values.toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    final created = await showDialog<List<ChatUser>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Create conversation'),
              content: SizedBox(
                width: 360,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedUsers.length,
                  itemBuilder: (context, index) {
                    final user = selectedUsers[index];
                    final isSelected = selectedIds.contains(user.id);
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(user.name),
                      subtitle: user.role.isEmpty ? null : Text(user.role),
                      onChanged: (value) {
                        setDialogState(() {
                          if (value == true) {
                            selectedIds.add(user.id);
                          } else {
                            selectedIds.remove(user.id);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: selectedIds.isEmpty
                      ? null
                      : () {
                          Navigator.of(dialogContext).pop(
                            selectedUsers
                                .where((user) => selectedIds.contains(user.id))
                                .toList(),
                          );
                        },
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );

    if (created == null || created.isEmpty) return;
    await _createConversation(created);
  }

  Future<void> _createConversation(List<ChatUser> users) async {
    final service = _chatApiService;
    if (service == null || _currentUserId.isEmpty) return;
    final enrichedUsers = await _enrichUsersForCreate(users);

    final memberIds = _memberIdsForCreate(enrichedUsers);
    final fallbackMemberIds = _fallbackMemberIdsFor(enrichedUsers);
    if (memberIds.length < 2) {
      _showSnackBar('Conversation needs at least one other employee');
      return;
    }

    final existing = _findExistingConversationForUsers(
      enrichedUsers,
      memberIds,
    );
    if (existing != null) {
      await _selectConversation(existing);
      return;
    }

    setState(() {
      _isCreatingConversation = true;
      _errorMessage = null;
    });

    try {
      final conversation = await service.createChat(
        name: _conversationNameFor(enrichedUsers),
        description: 'Internal chat',
        type: 'INTERNAL_GROUP',
        members: memberIds,
        fallbackMembers: fallbackMemberIds,
      );
      if (!mounted) return;

      final displayUser = users.length == 1
          ? enrichedUsers.first
          : ChatUser(
              id: memberIds.join(','),
              name: _conversationNameFor(enrichedUsers),
              avatar: '',
            );
      final completedConversation = conversation.copyWith(
        user: _needsDisplayUserFallback(conversation.user) ? displayUser : null,
        members: conversation.members.isEmpty
            ? [
                ChatUser(
                  id: _currentUserId,
                  name: 'Me',
                  avatar: '',
                  role: _currentUserRole,
                ),
                ...enrichedUsers,
              ]
            : null,
        messages: conversation.messages,
      );

      setState(() {
        _conversations = [
          completedConversation,
          ..._conversations.where(
            (item) =>
                !item.isPlaceholder ||
                !enrichedUsers.any((user) => item.user.id == user.id),
          ),
        ];
        _selectedConversation = completedConversation;
        _isCreatingConversation = false;
      });
      await _saveConversationContact(completedConversation.id, displayUser);
      _joinConversationRoom(completedConversation);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isCreatingConversation = false;
        _errorMessage = _errorText(error, 'Failed to create conversation');
      });
      _showSnackBar(_errorText(error, 'Failed to create conversation'));
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    // Mirrors Deal Card's fixed design dimensions scaled from the 1920px layout.
    final preferredWidth = media.width * (_referenceWidth / _layoutScreenWidth);
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = math.min(preferredWidth, constraints.maxWidth);
        if (constraints.maxHeight.isFinite) {
          width = math.min(
            width,
            constraints.maxHeight * _referenceWidth / _referenceHeight,
          );
        }
        final scale = width / _referenceWidth;
        return SizedBox(
          width: width,
          height: _referenceHeight * scale,
          child: _buildCanvas(context, scale),
        );
      },
    );
  }

  Widget _buildCanvas(BuildContext context, double scale) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final railColor = isDark ? darkThirdColorSecondary : primaryColor;
    final conversationColor = isDark ? darkSecondaryColor : secondaryColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20 * scale),
      child: ColoredBox(
        color: isDark ? darkBackGroundColor : backGroundColor,
        child: Stack(
          children: [
            // the contacts container :
            Positioned(
              left: 40 * scale,
              top: 40 * scale,
              // The rail intentionally ends at x=280. The 23px gutter from
              // x=280 to x=303 is the canvas background; only an active tile
              // bridges it to the conversation panel.
              width: 240 * scale,
              bottom: 35 * scale,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: railColor,
                  borderRadius: BorderRadius.circular(20 * scale),
                ),
              ),
            ),
            // the chat center widget :
            Positioned(
              left: 323 * scale,
              // The header and chat body are separate surfaces.
              top: 160 * scale,
              right: 17 * scale,
              bottom: 140 * scale,
              child: DecoratedBox(
                decoration: BoxDecoration(color: conversationColor),
              ),
            ),
            //  the primary header :
            Positioned(
              left: 303 * scale,
              top: 20 * scale,
              right: 177 * scale,
              height: 120 * scale,
              child: _buildChatHeader(scale, isDark, railColor),
            ),
            //  the right side of the chat widget ( which contains the "X" buttton at its top) :
            Positioned(
              top: 40 * scale,
              right: 17 * scale,
              width: 140 * scale,
              bottom: 140 * scale,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: conversationColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20 * scale),
                  ),
                ),
              ),
            ),
            //  the contacts widget :
            Positioned(
              left: 0,
              top: 163 * scale,
              width: 323 * scale,
              height: 486 * scale, // three 162px contact rows
              child: _buildConversationList(scale),
            ),
            Positioned(
              left: 58 * scale,
              top: 56 * scale,
              child: Text(
                'Messages',
                style: TextStyle(
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.bold,
                  color: lightCardColor,
                ),
              ),
            ),
            Positioned(
              left: 214 * scale,
              top: 48 * scale,
              width: 36 * scale,
              height: 36 * scale,
              child: Tooltip(
                message: 'Create conversation',
                child: Material(
                  color: secondaryColor,
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: _canCreateConversation
                        ? _showCreateConversationDialog
                        : null,
                    padding: EdgeInsets.zero,
                    icon: _isCreatingConversation
                        ? SizedBox(
                            width: 16 * scale,
                            height: 16 * scale,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.add,
                            color: primaryColor,
                            size: 20 * scale,
                          ),
                  ),
                ),
              ),
            ),
            if (_selectedConversation != null)
              Positioned(
                left: 323 * scale,
                top: 160 * scale,
                right: 17 * scale,
                bottom: 140 * scale,
                child: _buildMessageArea(scale),
              ),
            if (_selectedConversation == null)
              Positioned(
                left: 323 * scale,
                top: 160 * scale,
                right: 17 * scale,
                bottom: 140 * scale,
                child: Center(
                  child: Text(
                    _centerMessage,
                    style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 16 * scale,
                      color: getSecondaryTextColor(isDark),
                    ),
                  ),
                ),
              ),
            Positioned(
              left: 323 * scale,
              right: 38 * scale,
              bottom: 15 * scale,
              height: 100 * scale,
              child: ChatInput(
                controller: _messageController,
                onSend: _isSending ? null : _sendMessage,
                scale: scale,
              ),
            ),
            if (widget.onClose != null)
              Positioned(
                // Inside the small light-blue panel, rather than the canvas.
                top: 58 * scale,
                right: 35 * scale,
                width: 36 * scale,
                height: 36 * scale,
                child: Material(
                  color: darkSixthColorPrimaryRed,
                  shape: const CircleBorder(),
                  child: IconButton(
                    onPressed: widget.onClose,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.close,
                      color: lightCardColor,
                      size: 20 * scale,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversationList(double scale) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_conversations.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24 * scale),
          child: Text(
            _errorMessage ?? 'No conversations',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 13 * scale,
              color: lightCardColor,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      primary: false,
      // A fixed three-row viewport keeps this scroll independent of messages.
      itemExtent: 162 * scale,
      itemCount: _conversations.length,
      itemBuilder: (context, index) {
        final conversation = _conversations[index];
        return ConversationTile(
          conversation: conversation,
          isSelected: _selectedConversation?.id == conversation.id,
          onTap: () => _selectConversation(conversation),
          scale: scale,
          rowExtent: 162,
        );
      },
    );
  }

  Widget _buildChatHeader(double scale, bool isDark, Color railColor) {
    final conversation = _selectedConversation;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24 * scale),
      decoration: BoxDecoration(
        color: railColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20 * scale),
          topRight: Radius.circular(20 * scale),
        ),
      ),
      child: conversation == null
          ? const SizedBox()
          : Row(
              children: [
                Container(
                  width: 54 * scale,
                  height: 54 * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getCardColor(isDark),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      conversation.user.avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        color: getSecondaryTextColor(isDark),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14 * scale),
                Expanded(
                  child: Text(
                    conversation.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.bold,
                      color: lightCardColor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildMessageArea(double scale) {
    if (_isLoadingMessages) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_selectedConversation!.messages.isEmpty) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Center(
        child: Text(
          'No messages yet',
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: 15 * scale,
            color: getSecondaryTextColor(isDark),
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(top: 16 * scale, bottom: 16 * scale),
      itemCount: _selectedConversation!.messages.length,
      itemBuilder: (context, index) => MessageBubble(
        message: _selectedConversation!.messages[index],
        scale: scale,
      ),
    );
  }

  String get _centerMessage {
    if (_isLoading) return 'Loading conversations...';
    if (_errorMessage != null) return _errorMessage!;
    return 'Select a conversation';
  }

  bool _isBlockedRole(String role) {
    final normalized = role.trim().toUpperCase();
    return normalized == 'SUPPORT' || normalized == 'CONSULTANT';
  }

  bool _isManagerRole(String role) {
    return role.trim().toUpperCase().contains('MANAGER');
  }

  bool get _canCreateConversation {
    return !_isLoading &&
        !_isCreatingConversation &&
        _chatApiService != null &&
        !_isBlockedRole(_currentUserRole) &&
        _availableChatUsers.isNotEmpty;
  }

  Map<String, ChatUser> get _availableChatUsers {
    final users = <String, ChatUser>{};
    for (final user in _discoveredUsers) {
      if (user.id == _currentUserId || user.id.isEmpty) continue;
      if (!_canChatWithRole(user.role)) continue;
      users[user.id] = user;
    }
    for (final conversation in _conversations) {
      for (final member in conversation.members) {
        if (member.id == _currentUserId || member.id.isEmpty) continue;
        if (!_canChatWithRole(member.role)) continue;
        users[member.id] = member;
      }
      final displayUser = conversation.user;
      if (displayUser.id != _currentUserId &&
          displayUser.id.isNotEmpty &&
          _canChatWithRole(displayUser.role)) {
        users[displayUser.id] = displayUser;
      }
    }
    return users;
  }

  bool _canChatWithRole(String targetRole) {
    final currentRole = _currentUserRole.trim().toUpperCase();
    final normalizedTargetRole = targetRole.trim().toUpperCase();
    if (_isBlockedRole(currentRole) || _isBlockedRole(normalizedTargetRole)) {
      return false;
    }
    if (currentRole.contains('MANAGER')) {
      return normalizedTargetRole.isNotEmpty &&
          !normalizedTargetRole.contains('MANAGER');
    }
    return normalizedTargetRole.contains('MANAGER');
  }

  Conversation? _findExistingConversation(List<String> memberIds) {
    final wantedIds = memberIds.toSet();
    for (final conversation in _conversations) {
      final existingIds = _conversationIdentityIds(conversation);
      if (wantedIds.any(existingIds.contains)) {
        return conversation;
      }
    }
    return null;
  }

  Conversation? _findExistingConversationForUsers(
    List<ChatUser> users,
    List<String> memberIds,
  ) {
    final byIds = _findExistingConversation(memberIds);
    if (byIds != null) return byIds;

    final wantedNames = users.map((user) => _normalizeName(user.name)).toSet();
    for (final conversation in _conversations) {
      final conversationName = _normalizeName(conversation.displayName);
      final userName = _normalizeName(conversation.user.name);
      if (wantedNames.contains(conversationName) ||
          wantedNames.contains(userName)) {
        return conversation;
      }
    }
    return null;
  }

  String _conversationNameFor(List<ChatUser> users) {
    if (users.length == 1) return users.first.name;
    return users.map((user) => user.name).join(', ');
  }

  bool _needsDisplayUserFallback(ChatUser user) {
    final name = user.name.trim();
    return name.isEmpty || name == 'Unknown' || name == 'Internal chat';
  }

  List<ChatMessage> _sortedMessages(List<ChatMessage> messages) {
    return [...messages]..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  List<String>? _fallbackMemberIdsFor(List<ChatUser> users) {
    if (!_isManagerRole(_currentUserRole)) return null;
    if (_currentSocketUserId.isEmpty) return null;

    final ids = <String>{
      _currentSocketUserId,
      ...users.map((user) => user.userId).where((id) => id.isNotEmpty),
    }.toList();

    if (ids.length != users.length + 1) return null;
    return ids;
  }

  List<String> _memberIdsForCreate(List<ChatUser> users) {
    if (!_isManagerRole(_currentUserRole) && _currentSocketUserId.isNotEmpty) {
      final userIds = <String>{
        _currentSocketUserId,
        ...users.map((user) => user.userId).where((id) => id.isNotEmpty),
      }.toList();
      if (userIds.length == users.length + 1) return userIds;
    }

    return <String>{
      _currentUserId,
      ...users.map((user) => user.id),
    }.where((id) => id.isNotEmpty).toList();
  }

  Future<List<ChatUser>> _enrichUsersForCreate(List<ChatUser> users) async {
    final service = _chatApiService;
    if (service == null) return users;

    final enrichedUsers = <ChatUser>[];
    for (final user in users) {
      var enrichedUser = user;
      if (user.userId.isEmpty && user.id.isNotEmpty) {
        try {
          final detailedUser = await service.getEmployeeForChat(user.id);
          if (detailedUser.userId.isNotEmpty) {
            enrichedUser = detailedUser;
          }
        } catch (error) {
          enrichedUser = user;
        }
      }
      if (kDebugMode) {
        debugPrint(
          'Chat target ids: name=${enrichedUser.name}, '
          'id=${enrichedUser.id}, '
          'employeeId=${enrichedUser.employeeId}, '
          'userId=${enrichedUser.userId}',
        );
      }
      enrichedUsers.add(enrichedUser);
    }

    if (kDebugMode) {
      debugPrint(
        'Current chat ids: employeeId=$_currentUserId, '
        'userId=$_currentSocketUserId',
      );
      debugPrint(
        'Fallback chat members: ${_fallbackMemberIdsFor(enrichedUsers)}',
      );
    }
    return enrichedUsers;
  }

  Future<List<Conversation>> _hydrateSparseConversations(
    List<Conversation> conversations,
    List<ChatUser> discoveredUsers,
  ) async {
    final hydrated = <Conversation>[];
    for (final conversation in conversations) {
      hydrated.add(
        await _hydrateSparseConversation(conversation, discoveredUsers),
      );
    }
    return hydrated;
  }

  Future<Conversation> _hydrateSparseConversation(
    Conversation conversation,
    List<ChatUser> discoveredUsers,
  ) async {
    final savedContact = await _savedConversationContact(conversation.id);
    if (savedContact != null) {
      return conversation.copyWith(
        user: savedContact,
        members: conversation.members.isEmpty
            ? [_currentChatUser(), savedContact]
            : null,
      );
    }

    if (!_needsDisplayUserFallback(conversation.user) &&
        conversation.displayName != 'Internal chat' &&
        conversation.displayName != 'INTERNAL GROUP') {
      return conversation;
    }

    try {
      final messages = await _chatApiService!.getChatMessages(conversation.id);
      final senderIds = messages
          .map((message) => message.senderId)
          .where(
            (id) =>
                id.isNotEmpty &&
                id != _currentUserId &&
                id != _currentSocketUserId,
          )
          .toSet();
      ChatUser? matchedUser;
      for (final user in discoveredUsers) {
        if (_userIdentityIds(user).any(senderIds.contains)) {
          matchedUser = user;
          break;
        }
      }
      if (matchedUser == null) {
        final sortedMessages = _sortedMessages(messages);
        return conversation.copyWith(
          messages: sortedMessages,
          lastMessage: sortedMessages.isEmpty
              ? conversation.lastMessage
              : sortedMessages.last,
        );
      }

      final sortedMessages = _sortedMessages(messages);
      return conversation.copyWith(
        user: matchedUser,
        members: conversation.members.isEmpty
            ? [_currentChatUser(), matchedUser]
            : null,
        messages: sortedMessages,
        lastMessage: sortedMessages.isEmpty
            ? conversation.lastMessage
            : sortedMessages.last,
      );
    } catch (error) {
      return conversation;
    }
  }

  Future<void> _saveConversationContact(String roomId, ChatUser user) async {
    if (roomId.isEmpty || user.name.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _contactStorageKey(roomId),
      jsonEncode(user.toJson()),
    );
  }

  Future<ChatUser?> _savedConversationContact(String roomId) async {
    if (roomId.isEmpty) return null;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_contactStorageKey(roomId));
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final user = ChatUser.fromJson(Map<String, dynamic>.from(decoded));
      return user.id.isEmpty ? null : user;
    } catch (error) {
      return null;
    }
  }

  String _contactStorageKey(String roomId) => 'internal_chat_contact_$roomId';

  ChatUser _currentChatUser() {
    return ChatUser(
      id: _currentUserId,
      name: 'Me',
      avatar: '',
      role: _currentUserRole,
      userId: _currentSocketUserId,
      employeeId: _currentUserId,
    );
  }

  Future<List<ChatUser>> _loadEmployeesForManager() async {
    try {
      final users = await _chatApiService!.getEmployeesForChat();
      final allowedUsers = users
          .where(
            (user) =>
                user.id != _currentUserId &&
                user.id.isNotEmpty &&
                _canChatWithRole(user.role),
          )
          .toList();
      return _enrichUsersForDisplay(allowedUsers);
    } catch (error) {
      return const [];
    }
  }

  Future<List<ChatUser>> _enrichUsersForDisplay(List<ChatUser> users) async {
    final service = _chatApiService;
    if (service == null) return users;

    final enrichedUsers = <ChatUser>[];
    for (final user in users) {
      if ((user.name != 'Unknown' && user.userId.isNotEmpty) ||
          user.id.isEmpty) {
        enrichedUsers.add(user);
        continue;
      }

      try {
        final detailedUser = await service.getEmployeeForChat(user.id);
        enrichedUsers.add(detailedUser.id.isEmpty ? user : detailedUser);
      } catch (error) {
        enrichedUsers.add(user);
      }
    }
    return enrichedUsers;
  }

  Future<List<ChatUser>> _loadManagersForEmployee(
    UserAuthInfo authInfo,
    List<Conversation> conversations,
  ) async {
    final managers = <String, ChatUser>{};

    for (final manager in _managerUsersFromToken(authInfo.accessToken)) {
      if (_canDiscoveredUserChat(manager)) managers[manager.id] = manager;
    }

    for (final conversation in conversations) {
      for (final member in conversation.members) {
        if (_canDiscoveredUserChat(member)) managers[member.id] = member;
      }
      if (_canDiscoveredUserChat(conversation.user)) {
        managers[conversation.user.id] = conversation.user;
      }
    }

    if (managers.isNotEmpty) return managers.values.toList();

    try {
      final getMe = await _chatApiService!.getMe();
      for (final manager in _managerUsersFromPayload(getMe)) {
        if (_canDiscoveredUserChat(manager)) managers[manager.id] = manager;
      }
    } catch (error) {
      if (kDebugMode) {
        debugPrint('Manager discovery from getMe failed: $error');
      }
    }

    if (managers.isEmpty) {
      for (final manager in fallbackManagerUsers) {
        if (_canDiscoveredUserChat(manager)) managers[manager.id] = manager;
      }
    }

    return managers.values.toList();
  }

  List<Conversation> _withDiscoveredUserPlaceholders(
    List<Conversation> conversations,
    List<ChatUser> discoveredUsers,
  ) {
    final decoratedConversations = conversations
        .map(
          (conversation) =>
              _decorateExistingConversation(conversation, discoveredUsers),
        )
        .toList();
    final existingDirectUserIds = <String>{};
    final existingNames = <String>{};
    for (final conversation in decoratedConversations) {
      existingDirectUserIds.addAll(_conversationIdentityIds(conversation));
      existingNames.add(_normalizeName(conversation.displayName));
    }

    final placeholders = discoveredUsers
        .where(
          (user) =>
              !_userIdentityIds(user).any(existingDirectUserIds.contains) &&
              !existingNames.contains(_normalizeName(user.name)),
        )
        .map(
          (user) => Conversation(
            id: 'new_${user.id}',
            user: user,
            messages: const [],
            members: [
              ChatUser(
                id: _currentUserId,
                name: 'Me',
                avatar: '',
                role: _currentUserRole,
              ),
              user,
            ],
            type: 'INTERNAL_GROUP',
            isPlaceholder: true,
          ),
        )
        .toList();

    return [...decoratedConversations, ...placeholders];
  }

  Conversation _decorateExistingConversation(
    Conversation conversation,
    List<ChatUser> discoveredUsers,
  ) {
    if (!_needsDisplayUserFallback(conversation.user) &&
        conversation.displayName != 'Internal chat' &&
        conversation.displayName != 'INTERNAL GROUP') {
      return conversation;
    }

    final conversationIds = _conversationIdentityIds(conversation);
    ChatUser? matchedUser;
    for (final user in discoveredUsers) {
      final userIds = _userIdentityIds(user);
      if (userIds.any(conversationIds.contains) ||
          _normalizeName(user.name) ==
              _normalizeName(conversation.displayName) ||
          _normalizeName(user.name) == _normalizeName(conversation.user.name)) {
        matchedUser = user;
        break;
      }
    }

    if (matchedUser == null) return conversation;
    return conversation.copyWith(user: matchedUser);
  }

  Set<String> _conversationIdentityIds(Conversation conversation) {
    final ids = <String>{};
    for (final member in conversation.members) {
      ids.addAll(_userIdentityIds(member));
    }
    ids.addAll(_userIdentityIds(conversation.user));
    ids.removeWhere(
      (id) => id.isEmpty || id == _currentUserId || id == _currentSocketUserId,
    );
    return ids;
  }

  Set<String> _userIdentityIds(ChatUser user) {
    return {user.id, user.employeeId, user.userId}
      ..removeWhere((id) => id.isEmpty);
  }

  String _normalizeName(String name) {
    return name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  Future<Conversation?> _createConversationFromPlaceholder(
    Conversation placeholder,
  ) async {
    final user = (await _enrichUsersForCreate([placeholder.user])).first;
    if (user.id.isEmpty) return null;
    final service = _chatApiService;
    if (service == null) return null;

    try {
      final created = await service.createChat(
        name: user.name,
        description: 'Internal chat',
        type: 'INTERNAL_GROUP',
        members: _memberIdsForCreate([user]),
        fallbackMembers: _fallbackMemberIdsFor([user]),
      );
      final completedConversation = created.copyWith(
        user: _needsDisplayUserFallback(created.user) ? user : null,
        members: created.members.isEmpty
            ? [
                ChatUser(
                  id: _currentUserId,
                  name: 'Me',
                  avatar: '',
                  role: _currentUserRole,
                ),
                user,
              ]
            : null,
      );
      if (!mounted) return completedConversation;

      setState(() {
        _conversations = _conversations
            .map(
              (item) =>
                  item.id == placeholder.id ? completedConversation : item,
            )
            .toList();
        _selectedConversation = completedConversation;
      });
      await _saveConversationContact(completedConversation.id, user);
      _joinConversationRoom(completedConversation);
      return completedConversation;
    } catch (error) {
      if (!mounted) return null;
      setState(() {
        _isSending = false;
        _errorMessage = _errorText(error, 'Failed to create conversation');
      });
      _showSnackBar(_errorText(error, 'Failed to create conversation'));
      return null;
    }
  }

  bool _canDiscoveredUserChat(ChatUser user) {
    return user.id.isNotEmpty &&
        user.id != _currentUserId &&
        _canChatWithRole(user.role);
  }

  List<ChatUser> _managerUsersFromToken(String token) {
    final parts = token.split('.');
    if (parts.length < 2) return const [];

    try {
      final normalized = base64Url.normalize(parts[1]);
      final payload = utf8.decode(base64Url.decode(normalized));
      final decoded = jsonDecode(payload);
      if (decoded is Map) {
        return _managerUsersFromPayload(Map<String, dynamic>.from(decoded));
      }
    } catch (error) {
      return const [];
    }

    return const [];
  }

  String? _userIdFromToken(String token) {
    final parts = token.split('.');
    if (parts.length < 2) return null;

    try {
      final normalized = base64Url.normalize(parts[1]);
      final payload = utf8.decode(base64Url.decode(normalized));
      final decoded = jsonDecode(payload);
      if (decoded is! Map) return null;

      final id = decoded['id'] ?? decoded['userId'] ?? decoded['sub'];
      final text = id?.toString().trim();
      if (text == null || text.isEmpty || text.toLowerCase() == 'null') {
        return null;
      }
      return text;
    } catch (error) {
      return null;
    }
  }

  List<ChatUser> _managerUsersFromPayload(Object? payload) {
    final managers = <String, ChatUser>{};
    _collectManagers(payload, managers);
    return managers.values.toList();
  }

  void _collectManagers(Object? value, Map<String, ChatUser> managers) {
    if (value is List) {
      for (final item in value) {
        _collectManagers(item, managers);
      }
      return;
    }

    if (value is! Map) return;

    final map = Map<String, dynamic>.from(value);
    final user = ChatUser.fromJson(map);
    if (user.id.isNotEmpty && user.role.toUpperCase().contains('MANAGER')) {
      managers[user.id] = user;
    }

    for (final entry in map.entries) {
      final key = entry.key.toString().toLowerCase();
      final entryValue = entry.value;

      if (key.contains('manager')) {
        if (entryValue is Map) {
          final manager = ChatUser.fromJson(
            Map<String, dynamic>.from(entryValue),
          );
          if (manager.id.isNotEmpty) {
            managers[manager.id] = _withManagerFallbackRole(manager);
          }
        } else if (entryValue is List) {
          for (final item in entryValue) {
            if (item is Map) {
              final manager = ChatUser.fromJson(
                Map<String, dynamic>.from(item),
              );
              if (manager.id.isNotEmpty) {
                managers[manager.id] = _withManagerFallbackRole(manager);
              }
            }
          }
        } else {
          final id = entryValue?.toString().trim() ?? '';
          if (_looksLikeId(id)) {
            managers[id] = ChatUser(
              id: id,
              name: 'Manager',
              avatar: '',
              role: 'MANAGER',
            );
          }
        }
      }

      _collectManagers(entryValue, managers);
    }
  }

  ChatUser _withManagerFallbackRole(ChatUser user) {
    if (user.role.trim().isNotEmpty) return user;
    return ChatUser(
      id: user.id,
      name: user.name,
      avatar: user.avatar,
      isActive: user.isActive,
      role: 'MANAGER',
    );
  }

  bool _looksLikeId(String value) {
    if (value.isEmpty || value.toLowerCase() == 'null') return false;
    return value.length >= 8 || RegExp(r'^[0-9]+$').hasMatch(value);
  }

  String _errorText(Object error, String fallback) {
    final text = error.toString().replaceFirst('Exception: ', '').trim();
    if (text.isEmpty) return fallback;
    return text;
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _joinConversationRoom(Conversation conversation) {
    if (conversation.isPlaceholder || conversation.id.isEmpty) return;
    if (_joinedRoomId == conversation.id) return;

    _leaveJoinedRoom();
    _chatSocketService?.joinRoom(conversation.id);
    _joinedRoomId = conversation.id;
  }

  void _leaveJoinedRoom() {
    final roomId = _joinedRoomId;
    if (roomId == null || roomId.isEmpty) return;

    _chatSocketService?.leaveRoom(roomId);
    _joinedRoomId = null;
  }

  void _markConversationAsRead(Conversation conversation) {
    if (conversation.isPlaceholder || conversation.id.isEmpty) return;

    final lastMessageId = conversation.lastMessage?.id ?? '';
    _chatApiService?.markAsRead(conversation.id).catchError((_) {});
    _chatSocketService?.markAsRead(
      roomId: conversation.id,
      messageId: lastMessageId,
    );
  }

  void _handleSocketMessageCreated(ChatMessage message) {
    if (!mounted || message.id.isEmpty) return;
    final selected = _selectedConversation;
    if (selected == null || selected.isPlaceholder) return;

    final alreadyExists = selected.messages.any(
      (existing) => existing.id == message.id,
    );
    if (alreadyExists) return;

    final updatedConversation = selected.copyWith(
      lastMessage: message,
      messages: _sortedMessages([...selected.messages, message]),
    );

    setState(() {
      _conversations = _conversations
          .map((item) => item.id == selected.id ? updatedConversation : item)
          .toList();
      _selectedConversation = updatedConversation;
    });
    _markConversationAsRead(updatedConversation);
    _scrollToBottom();
  }

  void _handleSocketMessageEdited(ChatMessage message) {
    if (!mounted || message.id.isEmpty) return;
    final selected = _selectedConversation;
    if (selected == null || selected.isPlaceholder) return;

    final updatedMessages = _sortedMessages(
      selected.messages
          .map((existing) => existing.id == message.id ? message : existing)
          .toList(),
    );
    final updatedConversation = selected.copyWith(
      lastMessage: selected.lastMessage?.id == message.id
          ? message
          : selected.lastMessage,
      messages: updatedMessages,
    );

    setState(() {
      _conversations = _conversations
          .map((item) => item.id == selected.id ? updatedConversation : item)
          .toList();
      _selectedConversation = updatedConversation;
    });
  }

  void _handleSocketMessageDeleted(String messageId) {
    if (!mounted || messageId.isEmpty) return;
    final selected = _selectedConversation;
    if (selected == null || selected.isPlaceholder) return;

    final updatedMessages = selected.messages
        .where((message) => message.id != messageId)
        .toList();
    final updatedConversation = selected.copyWith(
      lastMessage: updatedMessages.isEmpty ? null : updatedMessages.last,
      messages: updatedMessages,
    );

    setState(() {
      _conversations = _conversations
          .map((item) => item.id == selected.id ? updatedConversation : item)
          .toList();
      _selectedConversation = updatedConversation;
    });
  }

  void _handleSocketMessageRead(String roomId, String messageId) {
    if (!mounted) return;
    final selected = _selectedConversation;
    if (selected == null || selected.isPlaceholder) return;
    if (roomId.isNotEmpty && roomId != selected.id) return;

    final updatedMessages = selected.messages.map((message) {
      if (!message.isMe) return message;
      if (messageId.isEmpty || message.id == messageId) {
        return message.copyWith(isRead: true);
      }
      return message;
    }).toList();

    final updatedLastMessage =
        selected.lastMessage?.isMe == true &&
            (messageId.isEmpty || selected.lastMessage?.id == messageId)
        ? selected.lastMessage!.copyWith(isRead: true)
        : selected.lastMessage;
    final updatedConversation = selected.copyWith(
      messages: updatedMessages,
      lastMessage: updatedLastMessage,
    );

    setState(() {
      _conversations = _conversations
          .map((item) => item.id == selected.id ? updatedConversation : item)
          .toList();
      _selectedConversation = updatedConversation;
    });
  }
}
