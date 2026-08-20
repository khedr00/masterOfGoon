class ChatUser {
  final String id;
  final String name;
  final String avatar;
  final bool isActive;

  ChatUser({
    required this.id,
    required this.name,
    required this.avatar,
    this.isActive = false,
  });
}
