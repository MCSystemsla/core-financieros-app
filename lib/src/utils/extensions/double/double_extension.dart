import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String get toDoubleFormat {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(this);
  }
}
