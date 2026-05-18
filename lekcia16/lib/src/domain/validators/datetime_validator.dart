DateTime? validateDateTime(String value, String fieldName) {
  try {
    final parsed = DateTime.parse(value);
    return parsed;
  } catch (_) {
    return null;
  }
}

String? validateDateTimeString(String value, String fieldName) {
  try {
    DateTime.parse(value);
    return null;
  } catch (_) {
    return '$fieldName должно быть в формате ГГГГ-ММ-ДД или ГГГГ-ММ-ДДТчч:мм:сс';
  }
}