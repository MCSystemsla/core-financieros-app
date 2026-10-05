import 'package:intl/intl.dart';

extension IntExtension on int {
  String get toIntFormat {
    final formatter = NumberFormat('#,##0', 'en_US');
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

  /// Convierte segundos en un texto legible con las dos unidades más grandes
  /// (ej: `2 d 5 h`, `3 h 12 min`, `4 min 05 s`, `45 s`).
  String get toRemainingTimeFormat {
    final duration = Duration(seconds: this < 0 ? 0 : this);
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (days > 0) return '$days d $hours h';
    if (hours > 0) return '$hours h $minutes min';
    if (minutes > 0) {
      return '$minutes min ${seconds.toString().padLeft(2, '0')} s';
    }
    return '$seconds s';
  }
}
