import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';

extension TypeFormParser on String {
  TypeForm toTypeForm() {
    return switch (this) {
      'NUEVAMENOR' => TypeForm.nueva,
      'ASALARIADO' => TypeForm.asalariado,
      'REPRESTAMO' => TypeForm.represtamo,
      _ => throw Exception('Tipo Solicitud no reconocido: $this'),
    };
  }
}
