import 'chat_user.dart';
import 'chat_message.dart';

class Conversation {
  final String id;
  final ChatUser user;
  final ChatMessage? lastMessage;
  final List<ChatMessage> messages;
  final List<ChatUser> members;
  final String type;
  final bool isPlaceholder;

  Conversation({
    required this.id,
    required this.user,
    this.lastMessage,
    required this.messages,
    this.members = const [],
    this.type = '',
    this.isPlaceholder = false,
  });

  factory Conversation.fromJson(
    Map<String, dynamic>? json, {
    String currentUserId = '',
  }) {
    final data = json ?? const <String, dynamic>{};
    final members = _membersFromJson(data);
    final otherMember = members.where((member) => member.id != currentUserId);
    final messages = _messagesFromJson(data, currentUserId);
    final lastMessage = _lastMessageFromJson(data, messages, currentUserId);

    return Conversation(
      id: _firstText([data['id'], data['_id'], data['chatId'], data['roomId']]),
      user: otherMember.isNotEmpty
          ? otherMember.first
          : ChatUser.fromJson(
              _asMap(data['user']) ??
                  _asMap(data['employee']) ??
                  {
                    'id': data['id'],
                    'name': data['name'],
                    'image': data['image'],
                    'type': data['type'],
                  },
            ),
      lastMessage: lastMessage,
      messages: messages,
      members: members,
      type: _firstText([data['type'], data['chatType'], data['roomType']]),
    );
  }

  String get displayName {
    final directName = user.name.trim();
    if (directName.isNotEmpty && directName != 'Unknown') return directName;
    if (members.isNotEmpty) {
      final memberNames = members
          .where((member) => member.id != user.id)
          .map((member) => member.name.trim())
          .where((name) => name.isNotEmpty && name != 'Unknown')
          .toList();
      if (memberNames.isNotEmpty) return memberNames.join(', ');
    }
    if (type.trim().isNotEmpty) return type.replaceAll('_', ' ');
    return 'Internal chat';
  }

  Conversation copyWith({
    String? id,
    ChatUser? user,
    ChatMessage? lastMessage,
    List<ChatMessage>? messages,
    List<ChatUser>? members,
    String? type,
    bool? isPlaceholder,
  }) {
    return Conversation(
      id: id ?? this.id,
      user: user ?? this.user,
      lastMessage: lastMessage ?? this.lastMessage,
      messages: messages ?? this.messages,
      members: members ?? this.members,
      type: type ?? this.type,
      isPlaceholder: isPlaceholder ?? this.isPlaceholder,
    );
  }
}

Map<String, dynamic>? _asMap(Object? value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

List<ChatUser> _membersFromJson(Map<String, dynamic> data) {
  final rawMembers = _firstList([
    data['members'],
    data['roomMembers'],
    data['participants'],
    data['users'],
    data['employees'],
  ]);
  return rawMembers
      .map(_asMap)
      .whereType<Map<String, dynamic>>()
      .map(ChatUser.fromJson)
      .where((member) => member.id.isNotEmpty)
      .toList();
}

List<ChatMessage> _messagesFromJson(
  Map<String, dynamic> data,
  String currentUserId,
) {
  final rawMessages = _firstList([data['messages'], data['chatMessages']]);
  return rawMessages
      .map(_asMap)
      .whereType<Map<String, dynamic>>()
      .map(
        (message) =>
            ChatMessage.fromJson(message, currentUserId: currentUserId),
      )
      .toList();
}

ChatMessage? _lastMessageFromJson(
  Map<String, dynamic> data,
  List<ChatMessage> messages,
  String currentUserId,
) {
  final lastMessageMap = _asMap(data['lastMessage']);
  if (lastMessageMap != null) {
    return ChatMessage.fromJson(lastMessageMap, currentUserId: currentUserId);
  }
  if (messages.isNotEmpty) return messages.last;
  return null;
}

List<Object?> _firstList(List<Object?> values) {
  for (final value in values) {
    if (value is List) return value;
  }
  return const [];
}

String _firstText(List<Object?> values, {String fallback = ''}) {
  for (final value in values) {
    if (value == null) continue;
    final text = value.toString().trim();
    if (text.isNotEmpty && text.toLowerCase() != 'null') return text;
  }
  return fallback;
}
