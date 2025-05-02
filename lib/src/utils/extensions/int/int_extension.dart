import 'package:intl/intl.dart';

extension IntExtension on int {
  String get toIntFormat {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(this);
  }

  String get toCurrencyFormat {
    final formatter = NumberFormat.currency(
      locale: 'es_ES',
      symbol: '',
      decimalDigits: 0,
    );
    return formatter.format(this).replaceAll('.', ',').replaceAll(',', '.');
  }
}
