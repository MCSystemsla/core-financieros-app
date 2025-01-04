import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class MiCrediEstudioModel {
  final String database;
  final int objSolicitudNuevamenorId;
  final bool tieneTrabajo;
  final String trabajoNegocioDescripcion;
  final int tiempoActividad;
  final bool otrosIngresos;
  final String otrosIngresosDescripcion;
  final String objOrigenCatalogoValorId;
  final int personasCargo;
  final int numeroHijos;
  final String edadHijos;
  final String tipoEstudioHijos;
  final String carrera;
  final int tiempoCarrera;
  final String universidad;
  final String motivoCarrera;
  final bool relizandoProfesionalmente;
  final String explicacionRelizandoProfesionalmente;
  final String quienApoya;
  final String ocupacionPadres;
  final String motivoPrestamo;
  final String comoAyudaCrecer;
  final bool optarOtroEstudio;
  final String cualEstudio;
  final String planFuturo;
  final String aspiraLaboralmente;
  final String otrosDatosCliente;

  MiCrediEstudioModel({
    required this.database,
    required this.objSolicitudNuevamenorId,
    required this.tieneTrabajo,
    required this.trabajoNegocioDescripcion,
    required this.tiempoActividad,
    required this.otrosIngresos,
    required this.otrosIngresosDescripcion,
    required this.objOrigenCatalogoValorId,
    required this.personasCargo,
    required this.numeroHijos,
    required this.edadHijos,
    required this.tipoEstudioHijos,
    required this.carrera,
    required this.tiempoCarrera,
    required this.universidad,
    required this.motivoCarrera,
    required this.relizandoProfesionalmente,
    required this.explicacionRelizandoProfesionalmente,
    required this.quienApoya,
    required this.ocupacionPadres,
    required this.motivoPrestamo,
    required this.comoAyudaCrecer,
    required this.optarOtroEstudio,
    required this.cualEstudio,
    required this.planFuturo,
    required this.aspiraLaboralmente,
    required this.otrosDatosCliente,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'objSolicitudId': objSolicitudNuevamenorId,
        'tieneTrabajo': tieneTrabajo,
        'trabajoNegocioDescripcion': trabajoNegocioDescripcion,
        'tiempoActividad': tiempoActividad,
        'otrosIngresos': otrosIngresos,
        'otrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenUbicacionGeograficaId': objOrigenCatalogoValorId,
        'personasCargo': personasCargo,
        'numeroHijos': numeroHijos,
        'edadHijos': edadHijos,
        'tipoEstudioHijos': tipoEstudioHijos,
        'carrera': carrera,
        'tiempoCarrera': tiempoCarrera,
        'universidad': universidad,
        'motivoCarrera': motivoCarrera,
        'realizandoProfesionalmente': relizandoProfesionalmente,
        'explicacionRealizandoProfesionalmente':
            explicacionRelizandoProfesionalmente,
        'quienApoya': quienApoya,
        'ocupacionPadres': ocupacionPadres,
        'motivoPrestamo': motivoPrestamo,
        'comoAyudaCrecer': comoAyudaCrecer,
        'optarOtroEstudio': optarOtroEstudio,
        'cualEstudio': cualEstudio,
        'planFuturo': planFuturo,
        'aspiraLaboralmente': aspiraLaboralmente,
        'otrosDatosCliente': otrosDatosCliente,
      };
}
