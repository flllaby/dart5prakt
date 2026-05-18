import 'package:lekcia16/src/data/repositories/rep_base.dart';
import 'package:lekcia16/src/domain/models/enrollment.dart';

mixin EnrollmentRepository on RepositoryBase {
  void insertEnrollment(Enrollment enrollment) {
    database.execute(
      'INSERT OR REPLACE INTO enrollments(id,userId,disciplineId,date) VALUES(?,?,?,?)',
      [enrollment.id, enrollment.userId, enrollment.disciplineId, enrollment.date.toIso8601String()],
    );
  }

  List<Enrollment> getAllEnrollments() {
    final result = database.select('SELECT id,userId,disciplineId,date FROM enrollments');
    return result.map((row) => Enrollment.fromMap(row)).toList();
  }

  Enrollment? getEnrollmentById(String id) {
    final result = database.select(
      'SELECT id,userId,disciplineId,date FROM enrollments WHERE id=?',
      [id],
    );
    return result.isNotEmpty ? Enrollment.fromMap(result.first) : null;
  }

  void updateEnrollment(Enrollment enrollment) {
    database.execute(
      'UPDATE enrollments SET userId=?,disciplineId=?,date=? WHERE id=?',
      [enrollment.userId, enrollment.disciplineId, enrollment.date.toIso8601String(), enrollment.id],
    );
  }

  void deleteEnrollment(String id) {
    database.execute('DELETE FROM enrollments WHERE id=?', [id]);
  }
}