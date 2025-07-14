import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,##0', 'en_US');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String rawText = newValue.text.replaceAll(',', '');

    if (rawText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Si el texto no es un número válido, permitilo momentáneamente
    int? value = int.tryParse(rawText);
    if (value == null) {
      // permitimos que el usuario borre o modifique sin regresarlo al oldValue
      return newValue;
    }

    String newText = _formatter.format(value);

    int selectionIndex =
        newText.length - (rawText.length - newValue.selection.end);
    selectionIndex = selectionIndex.clamp(0, newText.length);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
