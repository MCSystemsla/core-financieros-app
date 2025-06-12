import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

(String saludo, Icon icono) getGreetings() {
  final now = DateTime.now();
  final hora = int.parse(DateFormat('H').format(now));

  if (hora >= 5 && hora < 12) {
    return (
      'Buenos días',
      Icon(
        Icons.wb_sunny_outlined,
        color: Colors.yellow.shade600,
      ),
    );
  }

  if (hora >= 12 && hora < 19) {
    return (
      'Buenas tardes',
      Icon(Icons.wb_twilight, color: Colors.orange.shade600)
    );
  }

  return (
    'Buenas noches',
    Icon(Icons.nightlight_outlined, color: Colors.blue.shade600)
  );
}
