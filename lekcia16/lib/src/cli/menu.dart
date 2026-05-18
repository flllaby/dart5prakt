import 'dart:io';
// ignore: unused_import
import 'package:lekcia16/src/domain/models/role.dart';
import 'package:lekcia16/src/data/Database.dart';
import 'package:lekcia16/src/domain/models/user.dart';
import 'package:lekcia16/src/domain/models/discipline.dart';
import 'package:lekcia16/src/domain/models/enrollment.dart';
import 'input_helper.dart';

void runMenu(MptDatabase db) {
  while (true) {
    stdout.writeln("МПТ");
     stdout.writeln("1 — список пользователей");
     stdout.writeln("2 — добавить пользователя");
     stdout.writeln("3 — удалить пользователя");
     stdout.writeln("4 — список дисциплин");
     stdout.writeln("5 — добавить дисциплину");
     stdout.writeln("6 — список назначений");
     stdout.writeln("7 — добавить назначение");
     stdout.writeln("8 — показать всё из БД");
     stdout.writeln("0 — выход");
     stdout.writeln("Выберите пункт:");

    final choice = stdin.readLineSync()?.trim() ?? '';
    switch (choice) {
      case '1':
        _printUsers(db);
        break;
      case '2':
        _addUser(db);
        break;
      case '3':
        _deleteUser(db);
        break;
      case '4':
        _printDisciplines(db);
        break;
      case '5':
        _addDiscipline(db);
        break;
      case '6':
        _printEnrollments(db);
        break;
      case '7':
        _addEnrollment(db);
        break;
      case '8':
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

void _printAll(MptDatabase db) {
  stdout.writeln('ПОЛЬЗОВАТЕЛИ');
  _printUsers(db);
  stdout.writeln('ДИСЦИПЛИНЫ');
  _printDisciplines(db);
  stdout.writeln('НАЗНАЧЕНИЯ');
  _printEnrollments(db);
}