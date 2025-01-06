import 'package:isar/isar.dart';

part 'recurrente_energia_limpia_db_local.g.dart';

@Collection()
class RecurrenteEnergiaLimpiaDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  String? objTipoComunidadId;
  bool? tieneProblemasEnergia;
  String? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  String? motivoPrestamo;
  int? objSolicitudRecurrenteId;
  bool? coincideRespuesta;
  String? explicacionInversion;
  String? situacionAntesAhora;
  String? comoMejoraSituacion;
  String? quienApoya;
  String? siguienteMeta;
  String? problemasEnergiaDescripcion;
  String? tipoSolicitud;
}
