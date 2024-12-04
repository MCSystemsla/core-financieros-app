import 'package:isar/isar.dart';

part 'mujer_emprende_db_local.g.dart';

@Collection()
class MujerEmprendeDbLocal {
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
  String? motivoEmprender;
  String? conocioMujerEmprende;
  String? impulsoOptar;
  String? motivoPrestamo;
  String? quienApoya;
  String? comoImpactariaNegocio;
  String? comoMejoraCalidadVida;
  String? otrosDatosCliente;
  bool? tieneTrabajo;
  String? trabajoNegocioDescripcion;
}
