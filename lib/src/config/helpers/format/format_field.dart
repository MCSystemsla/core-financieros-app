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

    int? value = int.tryParse(rawText);
    if (value == null) return oldValue;

    String newText = _formatter.format(value);

    // Calcula nueva posición del cursor
    int selectionIndex =
        newText.length - (rawText.length - newValue.selection.end);

    // Clamp para evitar errores de rango
    selectionIndex = selectionIndex.clamp(0, newText.length);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
