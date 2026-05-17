import 'package:flutter/material.dart';
import 'package:untitled1/features/support_employee/core/services/socket_service.dart';
import 'package:untitled1/features/support_employee/features/home_feature/data/models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  final SocketService socketService;

  ChatProvider(this.socketService);

  List<ChatMessage> messages = [];
  final TextEditingController controller = TextEditingController();

  String myId = "user_1"; // مؤقت (بعدين من اليوزر الحقيقي)
  String chatId = "chat_123";

  // 🔌 connect socket
  void connect() {
    socketService.connect();
    socketService.emit('join_room', chatId);
    socketService.listen('receive_message', (data) {
      final msg = ChatMessage.fromJson(data);
      if (msg.chatId == chatId) {
        messages.add(msg);
        notifyListeners();
      }
    });
  }

  // 📤 send message
  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    final msg = ChatMessage(
      id: DateTime.now().toString(),
      message: controller.text,
      senderId: myId,
      createdAt: DateTime.now(),
      chatId: chatId,
    );

    // أضف مباشرة للـ UI
    messages.add(msg);
    notifyListeners();

    // ابعت للسيرفر
    socketService.emit('send_message', msg.toJson());

    controller.clear();
  }

  @override
  void dispose() {
    socketService.disconnect();
    controller.dispose();
    super.dispose();
  }
}
