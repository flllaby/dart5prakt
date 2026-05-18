import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:lekcia16/src/data/repositories/rep_base.dart';
import 'package:lekcia16/src/data/repositories/rep_role.dart';
import 'package:lekcia16/src/data/repositories/rep_group.dart';
import 'package:lekcia16/src/data/repositories/rep_user.dart';
import 'package:lekcia16/src/data/repositories/rep_discipline.dart';
import 'package:lekcia16/src/data/repositories/rep_enrollment.dart';

class MptDatabase extends RepositoryBase
    with RoleRepository, GroupRepository, UserRepository, DisciplineRepository, EnrollmentRepository {
  final Database _sqlite;

  MptDatabase(String filePath) : _sqlite = sqlite3.open(filePath) {
    _createTables();
  }

  factory MptDatabase.inApp() {
    final filePath = p.join(Directory.current.path, 'mpt.db');
    return MptDatabase(filePath);
  }

  @override
  Database get database => _sqlite;

  void _createTables() {
    database.execute('''
      CREATE TABLE IF NOT EXISTS roles (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL
      );
    ''');

    database.execute('''
      CREATE TABLE IF NOT EXISTS groups (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL
      );
    ''');

    database.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        roleId TEXT NOT NULL,
        groupId TEXT,
        FOREIGN KEY (roleId) REFERENCES roles(id) ON DELETE CASCADE,
        FOREIGN KEY (groupId) REFERENCES groups(id) ON DELETE SET NULL
      );
    ''');

    database.execute('''
      CREATE TABLE IF NOT EXISTS disciplines (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        hours INTEGER NOT NULL
      );
    ''');

    database.execute('''
      CREATE TABLE IF NOT EXISTS enrollments (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        disciplineId TEXT NOT NULL,
        date TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (disciplineId) REFERENCES disciplines(id) ON DELETE CASCADE
      );
    ''');
  }

  void close() {
    _sqlite.dispose();
  }
}