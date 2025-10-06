import 'package:isar/isar.dart';

part 'estandar_db_local.g.dart';

@Collection()
class EstandarDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  int? objSolicitudNuevamenorId;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  String? objOrigenCatalogoValorId;
  int? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  DateTime? inicioNegocio;
  bool? apoyanNegocio;
  String? cuantosApoyan;
  String? publicitarNegocio;
  String? negocioProximosAnios;
  String? motivoPrestamo;
  String? comoMejoraVida;
  String? planesFuturo;
  String? otrosDatosCliente;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  String? tipoSolicitud;
  String? solicitudCreditoId;
  String? numeroSolicitud;
  String? solicitudId;
}
