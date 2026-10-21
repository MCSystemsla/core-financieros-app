import 'package:flutter/material.dart';

/// Tipos de fiador de Nicaragua.
///
/// Códigos PROVISIONALES: solo `FIA` viene confirmado por backend. Se
/// reemplazan por los reales de NI cuando backend los defina.
enum FiadoresNiFormType {
  fiador('FIA'),
  conyuge('CON'),
  codeudor('COD');

  final String codigo;
  const FiadoresNiFormType(this.codigo);
}

class FiadoresNiFormScreen extends StatelessWidget {
  final FiadoresNiFormType typeForm;
  final int numeroSolicitud;
  const FiadoresNiFormScreen({
    super.key,
    required this.typeForm,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    // El formulario por pasos se arma en el paso 5 de la spec.
    return const Scaffold();
  }
}
