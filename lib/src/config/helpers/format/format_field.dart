import 'package:intl/intl.dart';

class FormatField {
  static String formatMonto(String value) {
    if (value.isEmpty) return value;

    String newValue = value.replaceAll(',', '');

    int? number = int.tryParse(newValue);
    if (number == null) return value;

    final NumberFormat formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(number);
  }
}
