import 'package:flutter/material.dart';
import '../../../core/widgets/constants.dart';
import '../models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.scale});

  final ChatMessage message;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5 * scale,
          horizontal: 22 * scale,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 12 * scale,
        ),
        constraints: BoxConstraints(maxWidth: 400 * scale),
        decoration: BoxDecoration(
          color: message.isMe ? primaryColor : getCardColor(isDark),
          borderRadius: BorderRadius.circular(14 * scale),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: 14 * scale,
                color: message.isMe
                    ? lightCardColor
                    : getPrimaryTextColor(isDark),
              ),
            ),
            SizedBox(height: 4 * scale),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 10 * scale,
                    color: message.isMe
                        ? lightCardColor.withValues(alpha: .72)
                        : getTertiaryTextColor(isDark),
                  ),
                ),
                if (message.isMe) ...[
                  SizedBox(width: 6 * scale),
                  Icon(
                    message.isRead ? Icons.check : Icons.done_all,
                    size: 14 * scale,
                    color: lightCardColor.withValues(alpha: .78),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) =>
      '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
}
