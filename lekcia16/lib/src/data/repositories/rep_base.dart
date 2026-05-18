import 'package:sqlite3/sqlite3.dart';

abstract class RepositoryBase {
  Database get database;
}