import 'package:isar/isar.dart';

part 'recurrente_migrante_economico_db_local.g.dart';

@Collection()
class RecurrenteMigranteEconomicoDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  int? personasCargo;
  String? motivoPrestamo;
  int? objSolicitudRecurrenteId;
  bool? coincideRespuesta;
  String? explicacionInversion;
  bool? apoyanNegocio;
  String? quienApoya;
  String? cuantosApoyan;
  bool? mejoraCondiciones;
  String? explicacionMejoraCondiciones;
  String? siguienteMeta;
}
