import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String get toDoubleFormat {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(this);
  }

  String get toCurrencyFormat {
    // Formatea el monto correctamente para créditos, mostrando los centavos.
    // Si el número es menor a 1,000 usa el formato español, si es 1,000 o más usa el formato US.
    if (this >= 1000) {
      final usFormatter = NumberFormat('#,##0.00', 'en_US');
      return usFormatter.format(this).trim();
    }
    final esFormatter = NumberFormat('#,##0.00', 'es_ES');
    return esFormatter.format(this).trim();
  }
}
