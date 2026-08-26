import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

typedef ClientChatSendMessage = FutureOr<void> Function(String message);

enum ClientChatMessageStatus { sending, sent, delivered, read, failed }

class ClientChatMessage {
  const ClientChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.createdAt,
    this.senderName,
    this.isMine,
    this.status = ClientChatMessageStatus.sent,
  });

  final String id;
  final String senderId;
  final String text;
  final DateTime createdAt;
  final String? senderName;
  final bool? isMine;
  final ClientChatMessageStatus status;

  bool sentBy(String currentUserId) => isMine ?? senderId == currentUserId;

  ClientChatMessage copyWith({
    String? id,
    String? senderId,
    String? text,
    DateTime? createdAt,
    String? senderName,
    bool? isMine,
    ClientChatMessageStatus? status,
  }) {
    return ClientChatMessage(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      senderName: senderName ?? this.senderName,
      isMine: isMine ?? this.isMine,
      status: status ?? this.status,
    );
  }
}

class ClientChatWidget extends StatefulWidget {
  const ClientChatWidget({
    super.key,
    this.clientName = 'Client',
    this.clientSubtitle,
    this.clientAvatarAsset = 'assets/images/profilePhoto-icon.png',
    this.clientAvatarUrl,
    this.isClientOnline = false,
    this.currentUserId = 'me',
    this.messages = const <ClientChatMessage>[],
    this.dealStatusTitle,
    this.dealStatusSubtitle,
    this.isTyping = false,
    this.isLoading = false,
    this.errorText,
    this.readOnly = false,
    this.hintText = 'Write a message...',
    this.emptyStateTitle = 'No messages yet',
    this.emptyStateSubtitle = 'Start the conversation with your client.',
    this.onSendMessage,
    this.onCallPressed,
    this.onMorePressed,
  });

  final String clientName;
  final String? clientSubtitle;
  final String? clientAvatarAsset;
  final String? clientAvatarUrl;
  final bool isClientOnline;
  final String currentUserId;
  final List<ClientChatMessage> messages;
  final String? dealStatusTitle;
  final String? dealStatusSubtitle;
  final bool isTyping;
  final bool isLoading;
  final String? errorText;
  final bool readOnly;
  final String hintText;
  final String emptyStateTitle;
  final String emptyStateSubtitle;
  final ClientChatSendMessage? onSendMessage;
  final VoidCallback? onCallPressed;
  final VoidCallback? onMorePressed;

  @override
  State<ClientChatWidget> createState() => _ClientChatWidgetState();
}

class _ClientChatWidgetState extends State<ClientChatWidget> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ClientChatMessage> _localMessages;
  bool _isSending = false;

  bool get _usesLocalMessages => widget.onSendMessage == null;

  List<ClientChatMessage> get _visibleMessages {
    return _usesLocalMessages ? _localMessages : widget.messages;
  }

  bool get _canSend {
    return !widget.readOnly &&
        !widget.isLoading &&
        !_isSending &&
        _messageController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _localMessages = List<ClientChatMessage>.of(widget.messages);
    _messageController.addListener(_refreshComposer);
    _scrollToBottom();
  }

  @override
  void didUpdateWidget(covariant ClientChatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_usesLocalMessages && widget.messages != oldWidget.messages) {
      _localMessages = List<ClientChatMessage>.of(widget.messages);
    }
    if (widget.messages.length != oldWidget.messages.length ||
        widget.isTyping != oldWidget.isTyping) {
      _scrollToBottom();
    }
  }

  @override
  void dispose() {
    _messageController.removeListener(_refreshComposer);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _refreshComposer() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _sendMessage() async {
    if (!_canSend) {
      return;
    }

    final message = _messageController.text.trim();

    if (_usesLocalMessages) {
      final now = DateTime.now();
      setState(() {
        _localMessages.add(
          ClientChatMessage(
            id: 'local_${now.microsecondsSinceEpoch}',
            senderId: widget.currentUserId,
            text: message,
            createdAt: now,
            isMine: true,
            status: ClientChatMessageStatus.sent,
          ),
        );
      });
      _messageController.clear();
      _scrollToBottom();
      return;
    }

    setState(() => _isSending = true);
    _messageController.clear();

    try {
      await widget.onSendMessage!(message);
      _scrollToBottom();
    } catch (_) {
      if (!mounted) {
        return;
      }
      _messageController.text = message;
      ScaffoldMessenger.maybeOf(
        context,
      )?.showSnackBar(const SnackBar(content: Text('Message failed to send')));
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final width = MediaQuery.of(context).size.width;
    final scale = width / 1920;
    final chatWidth = width * (509 / 1920);
    final radius = width * (50 / 1920);
    final primary = isDark ? darkPrimaryColor : primaryColor;
    final secondary = isDark ? darkSecondaryColor : secondaryColor;

    return Container(
      width: chatWidth,
      decoration: BoxDecoration(
        border: Border.all(width: width * (4 / 1920), color: primary),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - width * (4 / 1920)),
        child: Column(
          children: [
            _ChatHeader(
              width: chatWidth,
              height: width * (95 / 1920),
              scale: scale,
              isDark: isDark,
              color: primary,
              clientName: widget.clientName,
              clientSubtitle: widget.clientSubtitle ?? 'Client conversation',
              clientAvatarAsset: widget.clientAvatarAsset,
              clientAvatarUrl: widget.clientAvatarUrl,
              isClientOnline: widget.isClientOnline,
              onCallPressed: widget.onCallPressed,
              onMorePressed: widget.onMorePressed,
            ),
            _ChatBody(
              width: chatWidth,
              height: width * (770 / 1920),
              scale: scale,
              isDark: isDark,
              currentUserId: widget.currentUserId,
              messages: _visibleMessages,
              scrollController: _scrollController,
              dealStatusTitle: widget.dealStatusTitle,
              dealStatusSubtitle: widget.dealStatusSubtitle,
              isTyping: widget.isTyping,
              isLoading: widget.isLoading,
              errorText: widget.errorText,
              emptyStateTitle: widget.emptyStateTitle,
              emptyStateSubtitle: widget.emptyStateSubtitle,
            ),
            _ChatComposer(
              width: chatWidth,
              height: width * (108 / 1920),
              scale: scale,
              isDark: isDark,
              color: secondary,
              controller: _messageController,
              hintText: widget.hintText,
              enabled: !widget.readOnly && !widget.isLoading,
              canSend: _canSend,
              isSending: _isSending,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({
    required this.width,
    required this.height,
    required this.scale,
    required this.isDark,
    required this.color,
    required this.clientName,
    required this.clientSubtitle,
    required this.isClientOnline,
    this.clientAvatarAsset,
    this.clientAvatarUrl,
    this.onCallPressed,
    this.onMorePressed,
  });

  final double width;
  final double height;
  final double scale;
  final bool isDark;
  final Color color;
  final String clientName;
  final String clientSubtitle;
  final String? clientAvatarAsset;
  final String? clientAvatarUrl;
  final bool isClientOnline;
  final VoidCallback? onCallPressed;
  final VoidCallback? onMorePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 24 * scale),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 54 * scale,
                height: 54 * scale,
                decoration: BoxDecoration(
                  color: getCardColor(isDark),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(5 * scale),
                child: ClipOval(
                  child: _ClientAvatar(
                    avatarAsset: clientAvatarAsset,
                    avatarUrl: clientAvatarUrl,
                    isDark: isDark,
                    scale: scale,
                  ),
                ),
              ),
              Positioned(
                right: 2 * scale,
                bottom: 2 * scale,
                child: Container(
                  width: 13 * scale,
                  height: 13 * scale,
                  decoration: BoxDecoration(
                    color: isClientOnline
                        ? fifthColorSecondaryLightGreen
                        : getTertiaryTextColor(isDark),
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2 * scale),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 14 * scale),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: lightCardColor,
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: 21 * scale,
                  ),
                ),
                SizedBox(height: 3 * scale),
                Text(
                  clientSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: lightCardColor.withValues(alpha: .78),
                    fontFamily: 'NunitoSans-Regular',
                    fontSize: 13 * scale,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10 * scale),
          _HeaderActionIcon(
            icon: Icons.phone_outlined,
            scale: scale,
            tooltip: 'Call client',
            onTap: onCallPressed,
          ),
          SizedBox(width: 8 * scale),
          _HeaderActionIcon(
            icon: Icons.more_horiz,
            scale: scale,
            tooltip: 'More options',
            onTap: onMorePressed,
          ),
        ],
      ),
    );
  }
}

class _ClientAvatar extends StatelessWidget {
  const _ClientAvatar({
    required this.isDark,
    required this.scale,
    this.avatarAsset,
    this.avatarUrl,
  });

  final bool isDark;
  final double scale;
  final String? avatarAsset;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return Image.network(
        avatarUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _AvatarFallback(isDark: isDark, scale: scale),
      );
    }

    if (avatarAsset != null && avatarAsset!.isNotEmpty) {
      return Image.asset(
        avatarAsset!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            _AvatarFallback(isDark: isDark, scale: scale),
      );
    }

    return _AvatarFallback(isDark: isDark, scale: scale);
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.isDark, required this.scale});

  final bool isDark;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person_outline,
      color: getSecondaryTextColor(isDark),
      size: 28 * scale,
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody({
    required this.width,
    required this.height,
    required this.scale,
    required this.isDark,
    required this.currentUserId,
    required this.messages,
    required this.scrollController,
    required this.isTyping,
    required this.isLoading,
    required this.emptyStateTitle,
    required this.emptyStateSubtitle,
    this.dealStatusTitle,
    this.dealStatusSubtitle,
    this.errorText,
  });

  final double width;
  final double height;
  final double scale;
  final bool isDark;
  final String currentUserId;
  final List<ClientChatMessage> messages;
  final ScrollController scrollController;
  final String? dealStatusTitle;
  final String? dealStatusSubtitle;
  final bool isTyping;
  final bool isLoading;
  final String? errorText;
  final String emptyStateTitle;
  final String emptyStateSubtitle;

  bool get _hasStatusStrip {
    return (dealStatusTitle != null && dealStatusTitle!.isNotEmpty) ||
        (dealStatusSubtitle != null && dealStatusSubtitle!.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final orderedMessages = List<ClientChatMessage>.of(messages)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final feedItems = _buildFeedItems(orderedMessages);

    return Container(
      width: width,
      height: height,
      color: getCardColor(isDark),
      child: Column(
        children: [
          if (_hasStatusStrip)
            Padding(
              padding: EdgeInsets.fromLTRB(
                22 * scale,
                20 * scale,
                22 * scale,
                12 * scale,
              ),
              child: _DealStatusStrip(
                scale: scale,
                isDark: isDark,
                title: dealStatusTitle ?? '',
                subtitle: dealStatusSubtitle,
              ),
            ),
          Expanded(child: _buildContent(feedItems)),
        ],
      ),
    );
  }

  Widget _buildContent(List<_ChatFeedItem> feedItems) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 28 * scale,
          height: 28 * scale,
          child: CircularProgressIndicator(
            strokeWidth: 3 * scale,
            color: isDark ? darkPrimaryColor : primaryColor,
          ),
        ),
      );
    }

    if (errorText != null && errorText!.isNotEmpty) {
      return _ChatStateMessage(
        icon: Icons.error_outline,
        title: 'Could not load messages',
        subtitle: errorText!,
        scale: scale,
        isDark: isDark,
      );
    }

    if (feedItems.isEmpty) {
      return _ChatStateMessage(
        icon: Icons.chat_bubble_outline,
        title: emptyStateTitle,
        subtitle: emptyStateSubtitle,
        scale: scale,
        isDark: isDark,
      );
    }

    return ListView.builder(
      controller: scrollController,
      primary: false,
      padding: EdgeInsets.fromLTRB(
        18 * scale,
        _hasStatusStrip ? 4 * scale : 18 * scale,
        18 * scale,
        18 * scale,
      ),
      itemCount: feedItems.length,
      itemBuilder: (context, index) {
        final item = feedItems[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12 * scale),
          child: switch (item.type) {
            _ChatFeedItemType.day => _DayDivider(
              label: _formatDayLabel(item.day!),
              scale: scale,
              isDark: isDark,
            ),
            _ChatFeedItemType.message => _MessageBubble(
              message: item.message!,
              scale: scale,
              isDark: isDark,
              isMine: item.message!.sentBy(currentUserId),
            ),
            _ChatFeedItemType.typing => _TypingIndicator(
              scale: scale,
              isDark: isDark,
            ),
          },
        );
      },
    );
  }

  List<_ChatFeedItem> _buildFeedItems(List<ClientChatMessage> orderedMessages) {
    final items = <_ChatFeedItem>[];
    DateTime? lastDay;

    for (final message in orderedMessages) {
      final messageDay = _dateOnly(message.createdAt);
      if (lastDay == null || !_isSameDay(lastDay, messageDay)) {
        items.add(_ChatFeedItem.day(messageDay));
        lastDay = messageDay;
      }
      items.add(_ChatFeedItem.message(message));
    }

    if (isTyping) {
      items.add(const _ChatFeedItem.typing());
    }

    return items;
  }

  DateTime _dateOnly(DateTime date) {
    final localDate = date.toLocal();
    return DateTime(localDate.year, localDate.month, localDate.day);
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  String _formatDayLabel(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (_isSameDay(day, today)) {
      return 'Today';
    }
    if (_isSameDay(day, yesterday)) {
      return 'Yesterday';
    }
    return '${day.day}/${day.month}/${day.year}';
  }
}

class _ChatStateMessage extends StatelessWidget {
  const _ChatStateMessage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.scale,
    required this.isDark,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final double scale;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 44 * scale),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: getTertiaryTextColor(isDark), size: 42 * scale),
            SizedBox(height: 12 * scale),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: getPrimaryTextColor(isDark),
                fontFamily: 'NunitoSans-Bold',
                fontSize: 16 * scale,
              ),
            ),
            SizedBox(height: 4 * scale),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: getSecondaryTextColor(isDark),
                fontFamily: 'NunitoSans-Regular',
                fontSize: 12 * scale,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DealStatusStrip extends StatelessWidget {
  const _DealStatusStrip({
    required this.scale,
    required this.isDark,
    required this.title,
    this.subtitle,
  });

  final double scale;
  final bool isDark;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: BoxDecoration(
        color: isDark
            ? darkInputBackgroundColor
            : secondaryColor.withValues(alpha: .22),
        border: Border.all(color: getBorderColor(isDark), width: scale),
        borderRadius: BorderRadius.circular(18 * scale),
      ),
      child: Row(
        children: [
          Container(
            width: 38 * scale,
            height: 38 * scale,
            decoration: BoxDecoration(
              color: isDark ? darkPrimaryColor : primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.handshake_outlined,
              color: lightCardColor,
              size: 21 * scale,
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: getPrimaryTextColor(isDark),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: 15 * scale,
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  SizedBox(height: 2 * scale),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: getSecondaryTextColor(isDark),
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: 12 * scale,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DayDivider extends StatelessWidget {
  const _DayDivider({
    required this.label,
    required this.scale,
    required this.isDark,
  });

  final String label;
  final double scale;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: getDividerColor(isDark))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12 * scale),
          child: Text(
            label,
            style: TextStyle(
              color: getTertiaryTextColor(isDark),
              fontFamily: 'NunitoSans-SemiBold',
              fontSize: 11 * scale,
            ),
          ),
        ),
        Expanded(child: Divider(color: getDividerColor(isDark))),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.scale,
    required this.isDark,
    required this.isMine,
  });

  final ClientChatMessage message;
  final double scale;
  final bool isDark;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMine
        ? (isDark ? darkPrimaryColor : primaryColor)
        : (isDark
              ? darkInputBackgroundColor
              : secondaryColor.withValues(alpha: .32));
    final textColor = isMine ? lightCardColor : getPrimaryTextColor(isDark);
    final timeColor = isMine
        ? lightCardColor.withValues(alpha: .72)
        : getTertiaryTextColor(isDark);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 330 * scale),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15 * scale,
            vertical: 11 * scale,
          ),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18 * scale),
              topRight: Radius.circular(18 * scale),
              bottomLeft: Radius.circular(isMine ? 18 * scale : 5 * scale),
              bottomRight: Radius.circular(isMine ? 5 * scale : 18 * scale),
            ),
            border: isMine
                ? null
                : Border.all(color: getBorderColor(isDark), width: scale),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMine && message.senderName != null) ...[
                Text(
                  message.senderName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: getSecondaryTextColor(isDark),
                    fontFamily: 'NunitoSans-SemiBold',
                    fontSize: 11 * scale,
                  ),
                ),
                SizedBox(height: 4 * scale),
              ],
              Text(
                message.text,
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'NunitoSans-Regular',
                  fontSize: 14 * scale,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 6 * scale),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(message.createdAt),
                    style: TextStyle(
                      color: timeColor,
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: 10 * scale,
                    ),
                  ),
                  if (isMine) ...[
                    SizedBox(width: 5 * scale),
                    _MessageStatusIcon(
                      status: message.status,
                      scale: scale,
                      color: timeColor,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final localTime = time.toLocal();
    final hour = localTime.hour.toString().padLeft(2, '0');
    final minute = localTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _MessageStatusIcon extends StatelessWidget {
  const _MessageStatusIcon({
    required this.status,
    required this.scale,
    required this.color,
  });

  final ClientChatMessageStatus status;
  final double scale;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final (icon, iconColor) = switch (status) {
      ClientChatMessageStatus.sending => (Icons.schedule, color),
      ClientChatMessageStatus.sent => (Icons.check, color),
      ClientChatMessageStatus.delivered => (Icons.done_all, color),
      ClientChatMessageStatus.read => (Icons.done_all, secondaryColor),
      ClientChatMessageStatus.failed => (Icons.error_outline, errorColor),
    };

    return Icon(icon, color: iconColor, size: 13 * scale);
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator({required this.scale, required this.isDark});

  final double scale;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14 * scale,
          vertical: 10 * scale,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? darkInputBackgroundColor
              : secondaryColor.withValues(alpha: .24),
          borderRadius: BorderRadius.circular(18 * scale),
          border: Border.all(color: getBorderColor(isDark), width: scale),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TypingDot(scale: scale, isDark: isDark),
            SizedBox(width: 5 * scale),
            _TypingDot(scale: scale, isDark: isDark),
            SizedBox(width: 5 * scale),
            _TypingDot(scale: scale, isDark: isDark),
          ],
        ),
      ),
    );
  }
}

class _TypingDot extends StatelessWidget {
  const _TypingDot({required this.scale, required this.isDark});

  final double scale;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7 * scale,
      height: 7 * scale,
      decoration: BoxDecoration(
        color: getTertiaryTextColor(isDark),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({
    required this.width,
    required this.height,
    required this.scale,
    required this.isDark,
    required this.color,
    required this.controller,
    required this.hintText,
    required this.enabled,
    required this.canSend,
    required this.isSending,
    required this.onSend,
  });

  final double width;
  final double height;
  final double scale;
  final bool isDark;
  final Color color;
  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final bool canSend;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      padding: EdgeInsets.symmetric(
        horizontal: 20 * scale,
        vertical: 14 * scale,
      ),
      child: Container(
        height: 80 * scale,
        decoration: BoxDecoration(
          color: getCardColor(isDark),
          borderRadius: BorderRadius.circular(40 * scale),
          border: Border.all(color: getBorderColor(isDark), width: scale),
          boxShadow: [
            BoxShadow(
              color: getShadowColor(isDark).withValues(alpha: .16),
              blurRadius: 10 * scale,
              offset: Offset(0, 3 * scale),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 22 * scale, right: 12 * scale),
                child: TextField(
                  controller: controller,
                  cursorColor: isDark ? darkPrimaryColor : primaryColor,
                  enabled: enabled,
                  maxLines: 1,
                  onSubmitted: (_) => onSend(),
                  style: TextStyle(
                    color: getPrimaryTextColor(isDark),
                    fontFamily: 'NunitoSans-Regular',
                    fontSize: 18 * scale,
                  ),
                  textInputAction: TextInputAction.send,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 21 * scale),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: getHintTextColor(isDark),
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: 18 * scale,
                    ),
                    isDense: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10 * scale),
              child: SizedBox(
                width: 58 * scale,
                height: 58 * scale,
                child: Material(
                  color: canSend || isSending
                      ? (isDark ? darkPrimaryColor : primaryColor)
                      : getTertiaryTextColor(isDark).withValues(alpha: .45),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: canSend ? onSend : null,
                    child: Center(
                      child: isSending
                          ? SizedBox(
                              width: 21 * scale,
                              height: 21 * scale,
                              child: CircularProgressIndicator(
                                strokeWidth: 2 * scale,
                                color: lightCardColor,
                              ),
                            )
                          : Icon(
                              Icons.send,
                              color: lightCardColor,
                              size: 24 * scale,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderActionIcon extends StatelessWidget {
  const _HeaderActionIcon({
    required this.icon,
    required this.scale,
    required this.tooltip,
    this.onTap,
  });

  final IconData icon;
  final double scale;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: 36 * scale,
        height: 36 * scale,
        child: Material(
          color: lightCardColor.withValues(alpha: onTap == null ? .1 : .18),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Icon(
              icon,
              color: lightCardColor.withValues(alpha: onTap == null ? .5 : 1),
              size: 19 * scale,
            ),
          ),
        ),
      ),
    );
  }
}

enum _ChatFeedItemType { day, message, typing }

class _ChatFeedItem {
  const _ChatFeedItem.day(this.day)
    : type = _ChatFeedItemType.day,
      message = null;

  const _ChatFeedItem.message(this.message)
    : type = _ChatFeedItemType.message,
      day = null;

  const _ChatFeedItem.typing()
    : type = _ChatFeedItemType.typing,
      day = null,
      message = null;

  final _ChatFeedItemType type;
  final DateTime? day;
  final ClientChatMessage? message;
}
