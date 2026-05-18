int? validatePositiveInt(String value, String fieldName) {
  final parsed = int.tryParse(value);
  if (parsed == null) {
    print('$fieldName должно быть целым числом');
    return null;
  }
  if (parsed <= 0) {
    print('$fieldName должно быть больше 0');
    return null;
  }
  return parsed;
}

double? validatePositiveDouble(String value, String fieldName) {
  final parsed = double.tryParse(value.replaceAll(',', '.'));
  if (parsed == null) {
    print('$fieldName должно быть числом');
    return null;
  }
  if (parsed <= 0) {
    print('$fieldName должно быть больше 0');
    return null;
  }
  return parsed;
}