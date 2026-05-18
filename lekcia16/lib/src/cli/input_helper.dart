import 'dart:io';
import '../domain/validators/text_validator.dart';
import '../domain/validators/number_validator.dart';
import '../domain/validators/datetime_validator.dart';

class InputHelper {
  // Простой ввод без валидации
  static String read(String label) {
    stdout.write(label);
    return stdin.readLineSync()?.trim() ?? '';
  }

  // Ввод с проверкой на пустоту
  static String readNotEmpty(String label, String fieldName) {
    while (true) {
      final input = read(label);
      final error = validateNotEmpty(input, fieldName);
      if (error == null) return input;
      print(error);
    }
  }

  // Ввод целого числа > 0
  static int readPositiveInt(String label, String fieldName) {
    while (true) {
      final input = read(label);
      final result = validatePositiveInt(input, fieldName);
      if (result != null) return result;
    }
  }

  // Ввод числа с плавающей точкой > 0
  static double readPositiveDouble(String label, String fieldName) {
    while (true) {
      final input = read(label);
      final result = validatePositiveDouble(input, fieldName);
      if (result != null) return result;
    }
  }

  // Ввод даты/времени
  static DateTime readDateTime(String label, String fieldName) {
    while (true) {
      final input = read(label);
      final result = validateDateTime(input, fieldName);
      if (result != null) return result;
    }
  }
}