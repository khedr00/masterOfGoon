import 'chat_user.dart';
import 'chat_message.dart';

class Conversation {
  final String id;
  final ChatUser user;
  final ChatMessage? lastMessage;
  final List<ChatMessage> messages;

  Conversation({
    required this.id,
    required this.user,
    this.lastMessage,
    required this.messages,
  });
}
