import 'package:intl/intl.dart';

extension IntExtension on int {
  String get toIntFormat {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(this);
  }
}
