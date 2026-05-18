import 'id.dart';

class Discipline implements Identity {
  @override
  final String id;
  final String title;
  final int hours;

  const Discipline({
    required this.id,
    required this.title,
    required this.hours,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'hours': hours,
      };

  factory Discipline.fromMap(Map<String, dynamic> map) {
    return Discipline(
      id: map['id'] as String,
      title: map['title'] as String,
      hours: map['hours'] as int,
    );
  }

  @override
  String toString() => '$title ($hours ч)';
}