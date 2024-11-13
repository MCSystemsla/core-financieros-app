import 'package:isar/isar.dart';

part 'micredi_estudio_db_local.g.dart';

@Collection()
class MiCrediEstudioDbLocal {
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
  String? carrera;
  int? tiempoCarrera;
  String? universidad;
  String? motivoCarrera;
  bool? relizandoProfesionalmente;
  String? explicacionRelizandoProfesionalmente;
  String? quienApoya;
  String? ocupacionPadres;
  String? motivoPrestamo;
  String? comoAyudaCrecer;
  bool? optarOtroEstudio;
  String? cualEstudio;
  String? planFuturo;
  String? aspiraLaboralmente;
  String? otrosDatosCliente;
}
