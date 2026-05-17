import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Consumer, ReadContext;
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/chat_provider.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/custom_text_field_for_send_message.dart';

class BottomNavigationBarForLiveChatPage extends StatelessWidget {
  const BottomNavigationBarForLiveChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: width * 0.05),
          Icon(Icons.mic, size: width * 0.02, color: secondaryColor),
          SizedBox(width: width * 0.005),
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, provider, child) {
                return CustomTextFieldForSendMessage();
              },
            ),
          ),
          SizedBox(width: width * 0.005),
          GestureDetector(
            onTap: () {
              context.read<ChatProvider>().sendMessage();
            },
            child: Icon(Icons.send, size: width * 0.02, color: secondaryColor),
          ),
          SizedBox(width: width * 0.05),
        ],
      ),
    );
  }
}
