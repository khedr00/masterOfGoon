class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final bool isRead;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
    this.isRead = false,
  });

  factory ChatMessage.fromJson(
    Map<String, dynamic>? json, {
    String currentUserId = '',
  }) {
    final data = json ?? const <String, dynamic>{};
    final sender =
        _asMap(data['sender']) ??
        _asMap(data['senderEmployee']) ??
        _asMap(data['employee']) ??
        _asMap(data['user']);
    final senderId = _firstText([
      data['userId'],
      data['user_id'],
      data['senderId'],
      data['sender_id'],
      sender?['id'],
      sender?['_id'],
      sender?['userId'],
      data['employeeId'],
      sender?['employeeId'],
    ]);

    return ChatMessage(
      id: _firstText([
        data['id'],
        data['_id'],
        data['messageId'],
        data['message_id'],
      ], fallback: DateTime.now().microsecondsSinceEpoch.toString()),
      senderId: senderId,
      text: _firstText([
        data['message'],
        data['text'],
        data['content'],
        data['body'],
      ]),
      timestamp:
          _dateFrom(data['createdAt']) ??
          _dateFrom(data['updatedAt']) ??
          _dateFrom(data['timestamp']) ??
          DateTime.now(),
      isMe:
          data['isMe'] == true ||
          (currentUserId.isNotEmpty && senderId == currentUserId),
      isRead:
          data['isRead'] == true ||
          data['read'] == true ||
          data['seen'] == true ||
          data['readAt'] != null ||
          data['seenAt'] != null,
    );
  }

  ChatMessage copyWith({
    String? id,
    String? senderId,
    String? text,
    DateTime? timestamp,
    bool? isMe,
    bool? isRead,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      isMe: isMe ?? this.isMe,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'message': text,
    'createdAt': timestamp.toIso8601String(),
    'isMe': isMe,
    'isRead': isRead,
  };
}

Map<String, dynamic>? _asMap(Object? value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

String _firstText(List<Object?> values, {String fallback = ''}) {
  for (final value in values) {
    if (value == null) continue;
    final text = value.toString().trim();
    if (text.isNotEmpty && text.toLowerCase() != 'null') return text;
  }
  return fallback;
}

DateTime? _dateFrom(Object? value) {
  if (value is DateTime) return value;
  if (value == null) return null;
  return DateTime.tryParse(value.toString());
}
