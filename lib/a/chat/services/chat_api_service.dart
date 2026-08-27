import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';

import '../models/chat_message.dart';
import '../models/chat_user.dart';
import '../models/conversation.dart';

class ChatApiService {
  ChatApiService({required UserAuthInfo userAuthInfo, Dio? dio})
    : _currentUserId =
          _userIdFromToken(userAuthInfo.accessToken) ?? userAuthInfo.id,
      _dio = dio ?? DioClient(userAuthInfo: userAuthInfo).dio;

  final Dio _dio;
  final String _currentUserId;
  static const _defaultChatImage = 'https://example.com/chat.jpg';

  Future<List<Conversation>> getAllChats() async {
    final response = await _dio.get('api/v1/chat');
    return _responseList(response.data)
        .map(_asMap)
        .whereType<Map<String, dynamic>>()
        .map(
          (chat) => Conversation.fromJson(chat, currentUserId: _currentUserId),
        )
        .where((chat) => chat.id.isNotEmpty)
        .toList();
  }

  Future<List<ChatUser>> getEmployeesForChat() async {
    final response = await _dio.get('api/v1/employees');
    return _responseList(response.data)
        .map(_asMap)
        .whereType<Map<String, dynamic>>()
        .map(ChatUser.fromJson)
        .where((user) => user.id.isNotEmpty)
        .toList();
  }

  Future<ChatUser> getEmployeeForChat(String employeeId) async {
    final response = await _dio.get('api/v1/employees/$employeeId');
    return ChatUser.fromJson(_responseMap(response.data));
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await _dio.get('api/v1/auth/getMe');
    return _responseMap(response.data);
  }

  Future<Conversation> createChat({
    required String name,
    required String description,
    required String type,
    required List<String> members,
    List<String>? fallbackMembers,
    String image = '',
  }) async {
    final body = {
      'name': name,
      'image': image.trim().isEmpty ? _defaultChatImage : image,
      'description': description,
      'type': type,
      'members': members,
    };
    try {
      if (kDebugMode) {
        debugPrint('Create chat body: $body');
      }
      final response = await _dio.post('api/v1/chat', data: body);
      return Conversation.fromJson(
        _responseMap(response.data),
        currentUserId: _currentUserId,
      );
    } on DioException catch (error) {
      if (kDebugMode) {
        debugPrint('Create chat failed: ${error.response?.data}');
      }
      if (_shouldRetryWithFallbackMembers(error, fallbackMembers, members)) {
        return _createChatWithFallbackMembers(
          originalBody: body,
          fallbackMembers: fallbackMembers!,
        );
      }
      throw Exception(_dioErrorMessage(error));
    }
  }

  Future<Conversation> _createChatWithFallbackMembers({
    required Map<String, Object> originalBody,
    required List<String> fallbackMembers,
  }) async {
    final body = {...originalBody, 'members': fallbackMembers};
    try {
      if (kDebugMode) {
        debugPrint('Retry create chat body: $body');
      }
      final response = await _dio.post('api/v1/chat', data: body);
      return Conversation.fromJson(
        _responseMap(response.data),
        currentUserId: _currentUserId,
      );
    } on DioException catch (error) {
      if (kDebugMode) {
        debugPrint('Retry create chat failed: ${error.response?.data}');
      }
      throw Exception(_dioErrorMessage(error));
    }
  }

  Future<List<ChatMessage>> getChatMessages(String chatId) async {
    final response = await _dio.get('api/v1/chat/$chatId/messages');
    return _responseList(response.data)
        .map(_asMap)
        .whereType<Map<String, dynamic>>()
        .map(
          (message) =>
              ChatMessage.fromJson(message, currentUserId: _currentUserId),
        )
        .toList();
  }

  Future<ChatMessage> sendMessage({
    required String chatId,
    required String message,
  }) async {
    final response = await _dio.post(
      'api/v1/chat/$chatId/messages',
      data: {'message': message},
    );
    return ChatMessage.fromJson(
      _responseMap(response.data),
      currentUserId: _currentUserId,
    );
  }

  Future<ChatMessage> editMessage({
    required String messageId,
    required String message,
  }) async {
    final response = await _dio.patch(
      'api/v1/chat/messages/$messageId',
      data: {'message': message},
    );
    return ChatMessage.fromJson(
      _responseMap(response.data),
      currentUserId: _currentUserId,
    );
  }

  Future<void> deleteMessage(String messageId) async {
    await _dio.delete('api/v1/chat/messages/$messageId');
  }

  Future<void> markAsRead(String chatId) async {
    await _dio.patch('api/v1/chat/$chatId/read');
  }
}

Map<String, dynamic> _responseMap(Object? raw) {
  final data = _asMap(raw);
  if (data == null) return const {};

  final nestedData = _asMap(data['data']);
  if (nestedData != null) return nestedData;

  final chat = _asMap(data['chat']);
  if (chat != null) return chat;

  final message = _asMap(data['message']);
  if (message != null) return message;

  return data;
}

List<Object?> _responseList(Object? raw) {
  if (raw is List) return raw;

  final data = _asMap(raw);
  if (data == null) return const [];

  final directData = data['data'];
  if (directData is List) return directData;

  final nestedData = _asMap(directData);
  if (nestedData != null) {
    final nestedList = _firstList([
      nestedData['data'],
      nestedData['chats'],
      nestedData['messages'],
      nestedData['rooms'],
      nestedData['items'],
      nestedData['results'],
    ]);
    if (nestedList.isNotEmpty) return nestedList;
  }

  return _firstList([
    data['chats'],
    data['messages'],
    data['rooms'],
    data['items'],
    data['results'],
  ]);
}

List<Object?> _firstList(List<Object?> values) {
  for (final value in values) {
    if (value is List) return value;
  }
  return const [];
}

Map<String, dynamic>? _asMap(Object? value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  return null;
}

String _dioErrorMessage(DioException error) {
  final data = _asMap(error.response?.data);
  final message = data?['message'] ?? data?['error'] ?? error.message;
  final text = message?.toString().trim();
  if (text == null || text.isEmpty) return 'Request failed';
  return text;
}

bool _shouldRetryWithFallbackMembers(
  DioException error,
  List<String>? fallbackMembers,
  List<String> members,
) {
  if (fallbackMembers == null || fallbackMembers.isEmpty) return false;
  if (fallbackMembers.length != members.length) return false;
  if (_sameMembers(fallbackMembers, members)) return false;

  final message = _dioErrorMessage(error).toLowerCase();
  return message.contains('foreign key') ||
      message.contains('invalid reference') ||
      message.contains('reference');
}

bool _sameMembers(List<String> left, List<String> right) {
  final leftSet = left.toSet();
  final rightSet = right.toSet();
  return leftSet.length == rightSet.length && leftSet.containsAll(rightSet);
}

String? _userIdFromToken(String token) {
  final parts = token.split('.');
  if (parts.length < 2) return null;

  try {
    final normalized = base64Url.normalize(parts[1]);
    final payload = utf8.decode(base64Url.decode(normalized));
    final decoded = jsonDecode(payload);
    if (decoded is! Map) return null;

    final id = decoded['id'] ?? decoded['userId'] ?? decoded['sub'];
    final text = id?.toString().trim();
    if (text == null || text.isEmpty || text.toLowerCase() == 'null') {
      return null;
    }
    return text;
  } catch (error) {
    return null;
  }
}
