import 'package:lekcia16/src/data/repositories/rep_base.dart';
import 'package:lekcia16/src/domain/models/user.dart';

mixin UserRepository on RepositoryBase {
  void insertUser(User user) {
    database.execute(
      'INSERT OR REPLACE INTO users(id,name,phone,roleId,groupId) VALUES(?,?,?,?,?)',
      [user.id, user.name, user.phone, user.roleId, user.groupId],
    );
  }

  List<User> getAllUsers() {
    final result = database.select('SELECT id,name,phone,roleId,groupId FROM users');
    return result.map((row) => User.fromMap(row)).toList();
  }

  User? getUserById(String id) {
    final result = database.select(
      'SELECT id,name,phone,roleId,groupId FROM users WHERE id=?',
      [id],
    );
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  void updateUser(User user) {
    database.execute(
      'UPDATE users SET name=?,phone=?,roleId=?,groupId=? WHERE id=?',
      [user.name, user.phone, user.roleId, user.groupId, user.id],
    );
  }

  void deleteUser(String id) {
    database.execute('DELETE FROM users WHERE id=?', [id]);
  }
}