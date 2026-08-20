import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import 'chat_widget.dart';

class ChatDialog extends StatelessWidget {
  const ChatDialog({super.key, required this.userType});

  final UserType userType;

  static void show(BuildContext context, UserType userType) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ChatDialog(userType: userType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ChatWidget(
        userType: userType,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }
}
