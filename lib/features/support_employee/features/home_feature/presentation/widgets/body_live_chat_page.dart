import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/chat_provider.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/body_message.dart';

class BodyLiveChatPage extends StatefulWidget {
  const BodyLiveChatPage({super.key});

  @override
  State<BodyLiveChatPage> createState() => _BodyLiveChatPageState();
}

class _BodyLiveChatPageState extends State<BodyLiveChatPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<ChatProvider>().connect();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.messages.length,
            itemBuilder: (context, index) {
              final msg = provider.messages[index];

              return BodyMessage(
                isUserMessage: msg.senderId == provider.myId,
                message: msg.message,
              );
            },
          );
        },
      ),
    );
  }
}
