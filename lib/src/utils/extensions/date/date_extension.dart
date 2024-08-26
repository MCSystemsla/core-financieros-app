import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toDate() {
    return toLocal().toString().split(' ')[0];
  }

  String selectorFormat() {
    String day = this.day.toString().padLeft(2, '0');
    String month = this.month.toString().padLeft(2, '0');
    String year = this.year.toString();
    return '$month/$day/$year';
  }

  String formatDate() {
    String day = this.day.toString().padLeft(2, '0');
    String month = this.month.toString().padLeft(2, '0');
    String year = this.year.toString();
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }

  String formatDateV2() {
    String formattedDate = DateFormat('dd-MM-yy').format(this);
    String formattedHour = DateFormat('h:mm').format(this);

    final dateCombined = '$formattedDate, ${formattedHour}hrs.';
    return dateCombined;
  }

  String formatDateToTimePeriod() {
    String formattedDate = DateFormat('dd-MM-yy').format(this);
    String formattedHour = DateFormat('h:mm a').format(this);

    final dateCombined = '$formattedDate $formattedHour';
    return dateCombined;
  }
}
