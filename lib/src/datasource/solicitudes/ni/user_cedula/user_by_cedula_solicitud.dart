import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';

class UserByCedulaSolicitud {
  final String? primerNombre;
  final String? segundoNombre;
  final String? primerApellido;
  final String? segundoApellido;
  final String cedula;
  final DateTime? fechaEmision;
  final DateTime? fechaVencimiento;
  final DateTime? fechaNacimiento;
  final String? tipoDocumento;
  final String? tipoPersona;
  final Item? paisEmisor;
  final String? sexo;

  UserByCedulaSolicitud({
    this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    required this.cedula,
    this.fechaEmision,
    this.fechaVencimiento,
    this.fechaNacimiento,
    this.tipoDocumento,
    this.paisEmisor,
    this.tipoPersona,
    this.sexo,
  });
}
