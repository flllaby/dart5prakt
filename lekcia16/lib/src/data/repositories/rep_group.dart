import 'package:lekcia16/src/data/repositories/rep_base.dart';
import 'package:lekcia16/src/domain/models/group.dart';

mixin GroupRepository on RepositoryBase {
  void insertGroup(Group group) {
    database.execute(
      'INSERT OR REPLACE INTO groups(id,name) VALUES(?,?)',
      [group.id, group.name],
    );
  }

  List<Group> getAllGroups() {
    final result = database.select('SELECT id,name FROM groups');
    return result.map((row) => Group.fromMap(row)).toList();
  }

  Group? getGroupById(String id) {
    final result = database.select('SELECT id,name FROM groups WHERE id=?', [id]);
    return result.isNotEmpty ? Group.fromMap(result.first) : null;
  }

  void deleteGroup(String id) {
    database.execute('DELETE FROM groups WHERE id=?', [id]);
  }
}