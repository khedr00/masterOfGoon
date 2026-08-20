import 'package:flutter/material.dart';
import '../../../core/widgets/constants.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.scale,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * scale,
        vertical: 18 * scale,
      ),
      decoration: BoxDecoration(
        color: isDark ? darkThirdColorSecondary : primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20 * scale),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSend(),
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: 14 * scale,
                color: getPrimaryTextColor(isDark),
              ),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 14 * scale,
                  color: getHintTextColor(isDark),
                ),
                filled: true,
                fillColor: getCardColor(isDark),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24 * scale),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18 * scale,
                  vertical: 10 * scale,
                ),
              ),
            ),
          ),
          SizedBox(width: 12 * scale),
          SizedBox(
            width: 48 * scale,
            height: 48 * scale,
            child: Material(
              color: secondaryColor,
              shape: const CircleBorder(),
              child: IconButton(
                onPressed: onSend,
                icon: Icon(Icons.send, size: 20 * scale, color: primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
