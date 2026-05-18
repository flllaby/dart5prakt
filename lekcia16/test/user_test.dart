import 'package:test/test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:lekcia16/src/domain/models/user.dart';

void main() {
  late Database db;

  setUp(() {
    db = sqlite3.openInMemory();
    db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        roleId TEXT NOT NULL,
        groupId TEXT
      );
    ''');
  });

  tearDown(() {
    db.dispose();
  });

  test('User toMap and fromMap работают корректно', () {
    final user = User(
      id: 'u1',
      name: 'Никита Головачев',
      phone: '8-800-555-55-35',
      roleId: 'r1',
      groupId: 'g1',
    );

    final map = user.toMap();
    expect(map['id'], 'u1');
    expect(map['name'], 'Никита Головачев');
    expect(map['phone'], '8-800-555-55-35');
    expect(map['roleId'], 'r1');
    expect(map['groupId'], 'g1');

    final restored = User.fromMap(map);
    expect(restored.id, user.id);
    expect(restored.name, user.name);
    expect(restored.phone, user.phone);
    expect(restored.roleId, user.roleId);
    expect(restored.groupId, user.groupId);
  });

  test('Вставка и чтение пользователя', () {
    db.execute(
      'INSERT INTO users(id,name,phone,roleId,groupId) VALUES(?,?,?,?,?)',
      ['u1', 'Никита Головачев', '8-800-555-55-35', 'r2', null],
    );

    final result = db.select('SELECT id,name,phone,roleId,groupId FROM users WHERE id=?', ['u1']);
    final user = User.fromMap(result.first);

    expect(user.id, 'u1');
    expect(user.name, 'Никита Головачев');
    expect(user.phone, '8-800-555-55-35');
    expect(user.roleId, 'r2');
    expect(user.groupId, null);
  });
}