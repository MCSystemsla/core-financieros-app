DateTime? parseDate(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString());
}

int? parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}

bool? parseBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;

  final v = value.toString().toLowerCase();
  if (v == 'true' || v == '1') return true;
  if (v == 'false' || v == '0') return false;

  return null;
}
