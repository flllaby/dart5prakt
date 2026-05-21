import 'dart:io';
import 'package:lekcia16/src/data/Database.dart';
import 'package:lekcia16/src/domain/models/role.dart';
import 'package:lekcia16/src/domain/models/user.dart';
import 'package:lekcia16/src/domain/models/group.dart';
import 'package:lekcia16/src/domain/models/discipline.dart';
import 'package:lekcia16/src/domain/models/enrollment.dart';
import 'input_helper.dart';

void runMenu(MptDatabase db) {
  while (true) {
    stdout.writeln("МПТ");
    stdout.writeln("--- Роли ---");
    stdout.writeln("1 - список ролей");
    stdout.writeln("2 - добавить роль");
    stdout.writeln("3 - удалить роль");
    stdout.writeln("--- Группы ---");
    stdout.writeln("4 - список групп");
    stdout.writeln("5 - добавить группу");
    stdout.writeln("6 - удалить группу");
    stdout.writeln("--- Пользователи ---");
    stdout.writeln("7 - список пользователей");
    stdout.writeln("8 - добавить пользователя");
    stdout.writeln("9 - удалить пользователя");
    stdout.writeln("--- Дисциплины ---");
    stdout.writeln("10 - список дисциплин");
    stdout.writeln("11 -добавить дисциплину");
    stdout.writeln("12 - удалить дисциплину");
    stdout.writeln("--- Назначения ---");
    stdout.writeln("13 - список назначений");
    stdout.writeln("14 - добавить назначение");
    stdout.writeln("15 - удалить назначение");
    stdout.writeln("--- Всё ---");
    stdout.writeln("16 - показать всё из БД");
    stdout.writeln("0 - выход");
    stdout.writeln("Выберите пункт:");

    final choice = stdin.readLineSync()?.trim() ?? '';
    switch (choice) {
      case '1':
        _printRoles(db);
        break;
      case '2':
        _addRole(db);
        break;
      case '3':
        _deleteRole(db);
        break;
      case '4':
        _printGroups(db);
        break;
      case '5':
        _addGroup(db);
        break;
      case '6':
        _deleteGroup(db);
        break;
      case '7':
        _printUsers(db);
        break;
      case '8':
        _addUser(db);
        break;
      case '9':
        _deleteUser(db);
        break;
      case '10':
        _printDisciplines(db);
        break;
      case '11':
        _addDiscipline(db);
        break;
      case '12':
        _deleteDiscipline(db);
        break;
      case '13':
        _printEnrollments(db);
        break;
      case '14':
        _addEnrollment(db);
        break;
      case '15':
        _deleteEnrollment(db);
        break;
      case '16':
        _printAll(db);
        break;
      case '0':
        stdout.writeln('До свидания.');
        return;
      default:
        stdout.writeln('Другое пиши');
    }
    stdout.writeln();
  }
}

void _printRoles(MptDatabase db) {
  final list = db.getAllRoles();
  if (list.isEmpty) {
    stdout.writeln('Ролей нет. Добавь роль');
    return;
  }
  for (final r in list) {
    stdout.writeln('id: ${r.id} | ${r.name}');
  }
}

void _addRole(MptDatabase db) {
  final id = InputHelper.readNotEmpty('id роли: ', 'id');
  final name = InputHelper.readNotEmpty('название роли: ', 'название');
  db.insertRole(Role(id: id, name: name));
  stdout.writeln('Роль сохранена.');
}

void _deleteRole(MptDatabase db) {
  final id = InputHelper.read('id роли для удаления: ');
  db.deleteRole(id);
  stdout.writeln('Готово.');
}

void _printGroups(MptDatabase db) {
  final list = db.getAllGroups();
  if (list.isEmpty) {
    stdout.writeln('Групп нет.');
    return;
  }
  for (final g in list) {
    stdout.writeln('id: ${g.id} | ${g.name}');
  }
}

void _addGroup(MptDatabase db) {
  final id = InputHelper.readNotEmpty('id группы: ', 'id');
  final name = InputHelper.readNotEmpty('название группы: ', 'название');
  db.insertGroup(Group(id: id, name: name));
  stdout.writeln('Группа сохранена.');
}

void _deleteGroup(MptDatabase db) {
  final id = InputHelper.read('id группы для удаления: ');
  db.deleteGroup(id);
  stdout.writeln('Готово.');
}

void _printUsers(MptDatabase db) {
  final list = db.getAllUsers();
  if (list.isEmpty) {
    stdout.writeln('Пользователей нет.');
    return;
  }
  for (final u in list) {
    final role = db.getRoleById(u.roleId);
    final group = u.groupId != null ? db.getGroupById(u.groupId!) : null;
    stdout.writeln('id: ${u.id} | ${u.name} | ${u.phone} | роль: ${role?.name ?? '?'} | группа: ${group?.name ?? '-'}');
  }
}

void _addUser(MptDatabase db) {
  stdout.writeln('Доступные роли ');
  _printRoles(db);
  stdout.writeln('Доступные группы');
  _printGroups(db);

  final id = InputHelper.readNotEmpty('id пользователя: ', 'id');
  final name = InputHelper.readNotEmpty('имя: ', 'имя');
  final phone = InputHelper.readNotEmpty('телефон: ', 'телефон');
  final roleId = InputHelper.readNotEmpty('id роли: ', 'id роли');
  final groupId = InputHelper.read('id группы (Enter если не нужно): ');
  final finalGroupId = groupId.isEmpty ? null : groupId;

  db.insertUser(User(id: id, name: name, phone: phone, roleId: roleId, groupId: finalGroupId));
  stdout.writeln('Пользователь сохранён.');
}

void _deleteUser(MptDatabase db) {
  final id = InputHelper.read('id пользователя для удаления: ');
  db.deleteUser(id);
  stdout.writeln('Готово.');
}

void _printDisciplines(MptDatabase db) {
  final list = db.getAllDisciplines();
  if (list.isEmpty) {
    stdout.writeln('Дисциплин нет');
    return;
  }
  for (final d in list) {
    stdout.writeln('id: ${d.id} | ${d.title} | ${d.hours} ч');
  }
}

void _addDiscipline(MptDatabase db) {
  final id = InputHelper.readNotEmpty('id дисциплины: ', 'id');
  final title = InputHelper.readNotEmpty('название: ', 'название');
  final hours = InputHelper.readPositiveInt('часы: ', 'часы');
  db.insertDiscipline(Discipline(id: id, title: title, hours: hours));
  stdout.writeln('Дисциплина сохранена');
}

void _deleteDiscipline(MptDatabase db) {
  final id = InputHelper.read('id дисциплины для удаления: ');
  db.deleteDiscipline(id);
  stdout.writeln('Готово.');
}

void _printEnrollments(MptDatabase db) {
  final list = db.getAllEnrollments();
  if (list.isEmpty) {
    stdout.writeln('Назначений нет');
    return;
  }
  for (final e in list) {
    stdout.writeln('id: ${e.id} | пользователь: ${e.userId} | дисциплина: ${e.disciplineId} | дата: ${e.date.toLocal()}');
  }
}

void _addEnrollment(MptDatabase db) {
  stdout.writeln('Доступные пользователи');
  _printUsers(db);
  stdout.writeln('Доступные дисциплины');
  _printDisciplines(db);

  final id = InputHelper.readNotEmpty('id назначения: ', 'id');
  final userId = InputHelper.readNotEmpty('id пользователя: ', 'id пользователя');
  final disciplineId = InputHelper.readNotEmpty('id дисциплины: ', 'id дисциплины');
  final date = InputHelper.readDateTime('дата (ГГГГ-ММ-ДД): ', 'дата');

  db.insertEnrollment(Enrollment(id: id, userId: userId, disciplineId: disciplineId, date: date));
  stdout.writeln('Назначение сохранено');
}

void _deleteEnrollment(MptDatabase db) {
  final id = InputHelper.read('id назначения для удаления: ');
  db.deleteEnrollment(id);
  stdout.writeln('Готово.');
}

void _printAll(MptDatabase db) {
  stdout.writeln('РОЛИ');
  _printRoles(db);
  stdout.writeln('ГРУППЫ');
  _printGroups(db);
  stdout.writeln('ПОЛЬЗОВАТЕЛИ');
  _printUsers(db);
  stdout.writeln('ДИСЦИПЛИНЫ');
  _printDisciplines(db);
  stdout.writeln('НАЗНАЧЕНИЯ');
  _printEnrollments(db);
}
