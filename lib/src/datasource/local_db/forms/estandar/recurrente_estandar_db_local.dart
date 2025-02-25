import 'package:isar/isar.dart';

part 'recurrente_estandar_db_local.g.dart';

@Collection()
class RecurrenteEstandarDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  int? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  bool? apoyanNegocio;
  String? cuantosApoyan;
  int? objSolicitudRecurrenteId;
  bool? coincideRespuesta;
  String? explicacionInversion;
  String? comoMejoraEntorno;
  String? motivoPrestamo;
  String? comoFortalece;
  String? siguientePaso;
  String? personaAutoSuficiente;
  String? imagen1;
  String? imagen2;
  String? imagen3;
  String? imagen4;
  String? imagenFirma;
  bool? tieneTrabajo;
  String? trabajoDescripcion;
  int? tiempoActividad;
  String? tipoSolicitud;
}
