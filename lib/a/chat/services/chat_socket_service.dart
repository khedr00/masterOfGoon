import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:untitled1/core/widgets/constants.dart';

import '../models/chat_message.dart';

class ChatSocketService {
  ChatSocketService({required String token, required String currentUserId})
    : _token = token,
      _currentUserId = currentUserId;

  final String _token;
  final String _currentUserId;
  io.Socket? _socket;

  void Function(ChatMessage message)? onMessageCreated;
  void Function(ChatMessage message)? onMessageEdited;
  void Function(String messageId)? onMessageDeleted;
  void Function(String roomId, String messageId)? onMessageRead;

  bool get isConnected => _socket?.connected == true;

  void connect() {
    if (_token.isEmpty || _socket != null) return;

    _socket = io.io(
      '${base}chat',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': _token})
          .build(),
    );

    _socket!
      ..on('newMessage', _handleCreatedMessage)
      ..on('messageCreated', _handleCreatedMessage)
      ..on('messageSent', _handleCreatedMessage)
      ..on('messageEdited', _handleEditedMessage)
      ..on('messageUpdated', _handleEditedMessage)
      ..on('messageDeleted', _handleDeletedMessage)
      ..on('messageRead', _handleReadMessage)
      ..connect();
  }

  void joinRoom(String roomId) {
    if (roomId.isEmpty) return;
    _socket?.emitWithAck('joinRoom', roomId, ack: (_) {});
  }

  void leaveRoom(String roomId) {
    if (roomId.isEmpty) return;
    _socket?.emit('leaveRoom', roomId);
  }

  void markAsRead({required String roomId, String messageId = ''}) {
    if (roomId.isEmpty) return;
    _socket?.emitWithAck('markAsRead', {
      'roomId': roomId,
      if (messageId.isNotEmpty) 'messageId': messageId,
    }, ack: (_) {});
  }

  void disconnect() {
    final socket = _socket;
    if (socket == null) return;

    socket
      ..off('newMessage')
      ..off('messageCreated')
      ..off('messageSent')
      ..off('messageEdited')
      ..off('messageUpdated')
      ..off('messageDeleted')
      ..off('messageRead')
      ..disconnect()
      ..dispose();
    _socket = null;
  }

  void _handleCreatedMessage(Object? data) {
    final messageData = _eventMap(data);
    if (messageData.isEmpty) return;
    onMessageCreated?.call(
      ChatMessage.fromJson(messageData, currentUserId: _currentUserId),
    );
  }

  void _handleEditedMessage(Object? data) {
    final messageData = _eventMap(data);
    if (messageData.isEmpty) return;
    onMessageEdited?.call(
      ChatMessage.fromJson(messageData, currentUserId: _currentUserId),
    );
  }

  void _handleDeletedMessage(Object? data) {
    final messageData = _eventMap(data);
    final id = _firstText([
      messageData['id'],
      messageData['_id'],
      messageData['messageId'],
      messageData['message_id'],
      data,
    ]);
    if (id.isEmpty) return;
    onMessageDeleted?.call(id);
  }

  void _handleReadMessage(Object? data) {
    final messageData = _eventMap(data);
    final roomId = _firstText([
      messageData['roomId'],
      messageData['chatId'],
      messageData['id'],
    ]);
    final messageId = _firstText([
      messageData['messageId'],
      messageData['message_id'],
      messageData['lastReadMessageId'],
    ]);
    onMessageRead?.call(roomId, messageId);
  }
}

Map<String, dynamic> _eventMap(Object? data) {
  if (data is Map<String, dynamic>) {
    return _nestedEventMap(data);
  }
  if (data is Map) {
    return _nestedEventMap(Map<String, dynamic>.from(data));
  }
  return const {};
}

Map<String, dynamic> _nestedEventMap(Map<String, dynamic> data) {
  for (final key in ['data', 'message', 'payload']) {
    final nested = data[key];
    if (nested is Map<String, dynamic>) return nested;
    if (nested is Map) return Map<String, dynamic>.from(nested);
  }
  return data;
}

String _firstText(List<Object?> values) {
  for (final value in values) {
    if (value == null) continue;
    final text = value.toString().trim();
    if (text.isNotEmpty && text.toLowerCase() != 'null') return text;
  }
  return '';
}
