import 'id.dart';

class User implements Identity {
  @override
  final String id;
  final String name;
  final String phone;
  final String roleId;
  final String? groupId;

  const User({
    required this.id,
    required this.name,
    required this.phone,
    required this.roleId,
    this.groupId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'roleId': roleId,
        'groupId': groupId,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      roleId: map['roleId'] as String,
      groupId: map['groupId'] as String?,
    );
  }

  @override
  String toString() => '$name ($phone)';
}