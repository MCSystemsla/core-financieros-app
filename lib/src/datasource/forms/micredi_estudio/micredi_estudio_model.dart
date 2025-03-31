import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class MiCrediEstudioModel {
  final String tipoSolitud;
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
    required this.tipoSolitud,
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
        'tipoSolicitud': tipoSolitud,
        'database': LocalStorage().database,
        'objSolicitudId': objSolicitudNuevamenorId,
        'OtrosIngresos': otrosIngresos,
        'OtrosIngresosDescripcion': otrosIngresosDescripcion,
        'objOrigenUbicacionGeograficaId': objOrigenCatalogoValorId,
        'EdadHijos': edadHijos,
        'TipoEstudioHijos': tipoEstudioHijos,
        'Carrera': carrera,
        'TiempoCarrera': tiempoCarrera,
        'Universidad': universidad,
        'MotivoCarrera': motivoCarrera,
        'RealizandoProfesionalmente': relizandoProfesionalmente,
        'ExplicacionRealizandoProfesionalmente':
            explicacionRelizandoProfesionalmente,
        'QuienApoya': quienApoya,
        'OcupacionPadres': ocupacionPadres,
        'MotivoPrestamo': motivoPrestamo,
        'ComoAyudaCrecer': comoAyudaCrecer,
        'OptarOtroEstudio': optarOtroEstudio,
        'CualEstudio': cualEstudio,
        'PlanFuturo': planFuturo,
        'AspiraLaboralmente': aspiraLaboralmente,
        'OtrosDatosCliente': otrosDatosCliente,
      };
}
