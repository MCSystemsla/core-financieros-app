import 'package:isar/isar.dart';

part 'recurrente_saneamiento_db_local.g.dart';

@Collection()
class RecurrenteSaneamientoDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  String? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  String? otrosDatosCliente;
  int? objSolicitudRecurrenteId;
  bool? coincideRespuesta;
  String? explicacionInversion;
  String? comoAyudoCondiciones;
  String? motivoPrestamo;
  String? comoMejoraCondicionesEntorno;
  String? quienApoya;
  String? siguientePaso;
  bool? alcanzaraMeta;
  String? explicacionAlcanzaraMeta;
  String? tipoSolicitud;
}
