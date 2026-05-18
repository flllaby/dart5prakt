import 'id.dart';

class Group implements Identity {
  @override
  final String id;
  final String name;

  const Group({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  @override
  String toString() => name;
}