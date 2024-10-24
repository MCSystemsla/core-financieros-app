import 'dart:convert';

String mujerEmprendeModelToJson(MujerEmprendeModel data) =>
    json.encode(data.toJson());

class MujerEmprendeModel {
  final String database;
  final int objSolicitudNuevamenorId;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objOrigenCatalogoValorId;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String motivoEmprender;
  final String conocioMujerEmprende;
  final String impulsoOptar;
  final String motivoPrestamo;
  final String quienApoya;
  final String comoImpactariaNegocio;
  final String comoMejoraCalidadVida;
  final String otrosDatosCliente;

  MujerEmprendeModel({
    required this.database,
    required this.objSolicitudNuevamenorId,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.objOrigenCatalogoValorId,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.motivoEmprender,
    required this.conocioMujerEmprende,
    required this.impulsoOptar,
    required this.motivoPrestamo,
    required this.quienApoya,
    required this.comoImpactariaNegocio,
    required this.comoMejoraCalidadVida,
    required this.otrosDatosCliente,
  });

  Map<String, dynamic> toJson() => {
        'database': database,
        'objSolicitudNuevamenorId': objSolicitudNuevamenorId,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenCatalogoValorId': objOrigenCatalogoValorId,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'motivoEmprender': motivoEmprender,
        'conocioMujerEmprende': conocioMujerEmprende,
        'impulsoOptar': impulsoOptar,
        'motivoPrestamo': motivoPrestamo,
        'quienApoya': quienApoya,
        'comoImpactariaNegocio': comoImpactariaNegocio,
        'comoMejoraCalidadVida': comoMejoraCalidadVida,
        'otrosDatosCliente': otrosDatosCliente,
      };
}
