import 'package:isar/isar.dart';

part 'saneamiento_db_local.g.dart';

@Collection()
class SaneamientoDbLocal {
  Id id = Isar.autoIncrement;
  String? database;
  int? objSolicitudNuevamenorId;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
  int? tiempoActividad;
  bool? otrosIngresos;
  String? otrosIngresosDescripcion;
  String? objOrigenCatalogoValorId;
  String? personasCargo;
  int? numeroHijos;
  String? edadHijos;
  String? tipoEstudioHijos;
  String? motivacionCredito;
  String? importanciaMejorarCondiciones;
  bool? cumpliriaPropuesta;
  String? explicacionCumpliriaPropuesta;
  String? motivoPrestamo;
  String? mejoraCalidadVida;
  String? siguienteProyectoCalidadVida;
  String? metasProximas;
  String? otrosDatosCliente;
}
