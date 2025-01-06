import 'package:isar/isar.dart';

part 'recurrente_mujer_emprende_db_local.g.dart';

@Collection()
class RecurrenteMujerEmprendeDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  int? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  String? motivoPrestamo;
  int? objSolicitudRecurrenteId;
  bool? coincideRespuesta;
  String? explicacionInversion;
  String? comoAyudo;
  bool? apoyanNegocio;
  String? cuantosApoyan;
  bool? mejoraraEntorno;
  String? mejoraraEntornoExplicacion;
  String? siguientePaso;
  bool? alcanzaraMeta;
  String? explicacionAlcanzaraMeta;
  bool? tieneTrabajo;
  String? tieneTrabajoDescripcion;
  int? tiempoActividad;
  String? tipoSolicitud;
}
