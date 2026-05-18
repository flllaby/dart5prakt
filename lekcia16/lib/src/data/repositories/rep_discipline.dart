import 'package:lekcia16/src/data/repositories/rep_base.dart';
import 'package:lekcia16/src/domain/models/discipline.dart';

mixin DisciplineRepository on RepositoryBase {
  void insertDiscipline(Discipline discipline) {
    database.execute(
      'INSERT OR REPLACE INTO disciplines(id,title,hours) VALUES(?,?,?)',
      [discipline.id, discipline.title, discipline.hours],
    );
  }

  List<Discipline> getAllDisciplines() {
    final result = database.select('SELECT id,title,hours FROM disciplines');
    return result.map((row) => Discipline.fromMap(row)).toList();
  }

  Discipline? getDisciplineById(String id) {
    final result = database.select(
      'SELECT id,title,hours FROM disciplines WHERE id=?',
      [id],
    );
    return result.isNotEmpty ? Discipline.fromMap(result.first) : null;
  }

  void updateDiscipline(Discipline discipline) {
    database.execute(
      'UPDATE disciplines SET title=?,hours=? WHERE id=?',
      [discipline.title, discipline.hours, discipline.id],
    );
  }

  void deleteDiscipline(String id) {
    database.execute('DELETE FROM disciplines WHERE id=?', [id]);
  }
}