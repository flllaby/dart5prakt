import 'id.dart';

class Enrollment implements Identity {
  @override
  final String id;
  final String userId;
  final String disciplineId;
  final DateTime date;

  const Enrollment({
    required this.id,
    required this.userId,
    required this.disciplineId,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'disciplineId': disciplineId,
        'date': date.toIso8601String(),
      };

  factory Enrollment.fromMap(Map<String, dynamic> map) {
    return Enrollment(
      id: map['id'] as String,
      userId: map['userId'] as String,
      disciplineId: map['disciplineId'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  @override
  String toString() => 'User $userId -> Discipline $disciplineId';
}