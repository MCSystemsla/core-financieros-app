import 'package:isar/isar.dart';

part 'energia_limpia_db_local.g.dart';

@Collection()
class EnergiaLimpiaDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  int? solicitudNuevamenorId;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  String? objOrigenCatalogoValorId;
  String? objTipoComunidadId;
  bool? tieneProblemasEnergia;
  String? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  String? motivoPrestamo;
  String? planesFuturo;
  String? otrosDatosCliente;
  String? problemasEnergiaDescripcion;
}
