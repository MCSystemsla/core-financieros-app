import 'package:isar/isar.dart';

part 'migrante_economico_db_local.g.dart';

@Collection()
class MigranteEconomicoDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  int? objSolicitudNuevamenorId;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  int? personasCargo;
  String? objOrigenUbicacionGeograficaId;
  String? motivoDejarPais;
  String? situacionMigratoria;
  String? dedicabaPaisOrigen;
  String? vivePaisActual;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  bool? enviaRemesas;
  String? enviaRemesasExplicacion;
  String? quienApoya;
  bool? fortalecerIngresos;
  String? fortalecerIngresosExplicacion;
  String? metasFuturo;
  String? motivoPrestamo;
  bool? ayudaMejorarCondiciones;
  String? ayudaMejorarCondicionesExplicacion;
  String? propositosProximos;
  String? piensaRegresar;
  String? otrosDatosCliente;
  String? tipoSolicitud;
}
