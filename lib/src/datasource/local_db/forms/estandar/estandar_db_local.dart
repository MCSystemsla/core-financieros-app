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
  String? imagen1;
  String? imagen2;
  String? imagen3;
  String? imagen4;
  String? imagenFirma;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
}
