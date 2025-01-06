import 'package:isar/isar.dart';

part 'recurrente_mejora_vivienda_db_local.g.dart';

@Collection()
class RecurrenteMejoraViviendaDbLocal {
  Id id = Isar.autoIncrement;
  int? objSolicitudRecurrenteId;
  String? username;
  bool? tieneTrabajo;
  String? database;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  String? objTipoComunidadId;
  String? necesidadesComunidad;
  String? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  String? motivoPrestamo;
  bool? coincideRespuesta;
  String? explicacionInversion;
  String? viviendaAntesDespues;
  String? mejoraSeguridadFamilia;
  String? quienApoya;
  String? siguienteMeta;
  String? tipoSolicitud;
}
