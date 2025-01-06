import 'package:isar/isar.dart';

part 'mejora_vivienda_db_local.g.dart';

@Collection()
class MejoraViviendaDbLocal {
  Id id = Isar.autoIncrement;
  int? solicitudNuevamenorId;
  String? username;
  bool? tieneTrabajo;
  String? database;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  String? objOrigenCatalogoValorId;
  String? objTipoComunidadId;
  String? necesidadesComunidad;
  String? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  String? motivoPrestamo;
  String? comoAyudara;
  String? planesFuturo;
  String? otrosDatosCliente;
  String? tipoSolicitud;
}
