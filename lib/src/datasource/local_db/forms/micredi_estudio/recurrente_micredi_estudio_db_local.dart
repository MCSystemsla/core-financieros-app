import 'package:isar/isar.dart';

part 'recurrente_micredi_estudio_db_local.g.dart';

@Collection()
class RecurrenteMiCrediEstudioDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  int? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  String? carrera;
  int? tiempoCarrera;
  String? universidad;
  String? quienApoya;
  String? motivoPrestamo;
  String? comoAyudaCrecer;
  int? objSolicitudRecurrenteId;
  bool? coincideRespuesta;
  String? explicacionInversion;
  String? comoAyudoProfesionalmente;
  String? siguientePaso;
  bool? alcanzaraMeta;
  String? explicacionAlcanzaraMeta;
}
