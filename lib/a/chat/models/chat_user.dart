class ChatUser {
  final String id;
  final String name;
  final String avatar;
  final bool isActive;
  final String role;
  final String userId;
  final String employeeId;

  ChatUser({
    required this.id,
    required this.name,
    required this.avatar,
    this.isActive = false,
    this.role = '',
    this.userId = '',
    this.employeeId = '',
  });

  factory ChatUser.fromJson(Map<String, dynamic>? json) {
    final data = json ?? const <String, dynamic>{};
    final user = _asMap(data['user']);
    final employee = _asMap(data['employee']) ?? _asMap(user?['employee']);
    final source = employee ?? user ?? data;
    final parsedUserId = _firstText([
      data['userId'],
      data['user_id'],
      user?['id'],
      user?['_id'],
      user?['uuid'],
    ]);
    final parsedEmployeeId = _firstText([
      employee?['id'],
      employee?['_id'],
      employee?['uuid'],
      source['employeeId'],
      source['employee_id'],
      user?['employeeId'],
      data['employeeId'],
      data['employee_id'],
      data['id'],
    ]);

    return ChatUser(
      id: _firstText([
        parsedEmployeeId,
        parsedUserId,
        source['id'],
        source['_id'],
      ]),
      name: _nameFrom(source, user),
      avatar: _firstText([
        source['avatar'],
        source['image'],
        source['photo'],
        source['profileImage'],
        source['employeePhoto'],
        user?['avatar'],
        data['image'],
      ]),
      isActive: data['isActive'] == true || source['isActive'] == true,
      role: _firstText([
        source['role'],
        source['type'],
        source['employeeType'],
        user?['role'],
        data['role'],
      ]),
      userId: parsedUserId,
      employeeId: parsedEmployeeId,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'isActive': isActive,
    'role': role,
    'userId': userId,
    'employeeId': employeeId,
  };
}

String _nameFrom(Map<String, dynamic> source, Map<String, dynamic>? user) {
  final firstName = _firstText([source['firstName'], source['first_name']]);
  final lastName = _firstText([source['lastName'], source['last_name']]);
  final fullName = [
    firstName,
    lastName,
  ].where((part) => part.isNotEmpty).join(' ').trim();
  if (fullName.isNotEmpty) return fullName;

  return _firstText([
    source['name'],
    source['fullName'],
    source['employeeName'],
    source['username'],
    source['displayName'],
    source['email'],
    user?['name'],
    user?['fullName'],
    user?['email'],
  ], fallback: 'Unknown');
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
