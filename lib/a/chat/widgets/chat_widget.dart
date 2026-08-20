import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../../core/widgets/constants.dart';
import '../data/mock_data.dart';
import '../models/chat_message.dart';
import '../models/conversation.dart';
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

  late List<Conversation> _conversations;
  Conversation? _selectedConversation;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _conversations = MockChatData.getConversations(widget.userType);
    if (_conversations.isNotEmpty) {
      _selectedConversation = _conversations.first;
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _selectConversation(Conversation conversation) {
    setState(() => _selectedConversation = conversation);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty ||
        _selectedConversation == null) {
      return;
    }
    final newMessage = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'me',
      text: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isMe: true,
    );
    setState(() {
      _selectedConversation!.messages.add(newMessage);
      _messageController.clear();
    });
    _scrollToBottom();
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
                    'Select a conversation',
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
                onSend: _sendMessage,
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
                    conversation.user.name,
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
}
