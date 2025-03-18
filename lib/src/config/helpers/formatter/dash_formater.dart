import 'package:flutter/services.dart';

class DashFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll('-', '');
    String formattedText =
        text.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)}-');
    if (formattedText.endsWith('-')) {
      formattedText = formattedText.substring(0, formattedText.length - 1);
    }

    int cursorPosition =
        newValue.selection.baseOffset + (formattedText.length - text.length);

    cursorPosition = cursorPosition.clamp(0, formattedText.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
