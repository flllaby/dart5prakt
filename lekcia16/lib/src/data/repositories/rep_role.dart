import 'package:lekcia16/src/data/repositories/rep_base.dart';
import 'package:lekcia16/src/domain/models/role.dart';

mixin RoleRepository on RepositoryBase {
  void insertRole(Role role) {
    database.execute(
      'INSERT OR REPLACE INTO roles(id,name) VALUES(?,?)',
      [role.id, role.name],
    );
  }

  List<Role> getAllRoles() {
    final result = database.select('SELECT id,name FROM roles');
    return result.map((row) => Role.fromMap(row)).toList();
  }

  Role? getRoleById(String id) {
    final result = database.select('SELECT id,name FROM roles WHERE id=?', [id]);
    return result.isNotEmpty ? Role.fromMap(result.first) : null;
  }

  void deleteRole(String id) {
    database.execute('DELETE FROM roles WHERE id=?', [id]);
  }
}