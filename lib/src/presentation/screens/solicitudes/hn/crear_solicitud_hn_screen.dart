import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/asalariado_hn_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/nueva_menor_hn_form.dart';
import 'package:flutter/material.dart';

class CrearSolicitudHnScreen extends StatelessWidget {
  final TypeForm typeForm;
  const CrearSolicitudHnScreen({
    super.key,
    required this.typeForm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: switch (typeForm) {
      TypeForm.nueva => const NuevaMenorHnForm(),
      TypeForm.asalariado => const AsalariadoHnForm(),
      TypeForm.represtamo => const Text('Formulario Represtamo HN'),
    });
  }
}
