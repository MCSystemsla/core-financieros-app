import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/autosave_helper.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'solicitud_nueva_menor_state.dart';

class SolicitudNuevaMenorCubit extends Cubit<SolicitudNuevaMenorState> {
  final SolicitudesCreditoRepository repository;
  final ObjectBoxService localDbProvider;
  SolicitudNuevaMenorCubit(this.repository, this.localDbProvider)
      : super(SolicitudNuevaMenorInitial());
  late final AutoSaveResponseLocalDb autoSaveHelper;

  Future<void> createSolicitudNuevaMenor() async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      await Future.delayed(const Duration(seconds: 3));
      final (isOk, msg) = await repository.createSolicitudCreditoNuevaMenor(
          solicitudNuevaMenor: SolicitudNuevaMenor(
        isOffline: state.isDone,
        objOrigenSolicitudId: state.objOrigenSolicitudId,
        nombre1: state.nombre1,
        nombre2: state.nombre2,
        apellido1: state.apellido1,
        apellido2: state.apellido2,
        cedula: state.cedula,
        objPaisEmisorCedula: state.objPaisEmisorCedula,
        fechaEmisionCedula: state.fechaEmisionCedula,
        fechaVencimientoCedula: state.fechaVencimientoCedula,
        fechaNacimiento: state.fechaNacimiento,
        telefono: state.telefono,
        celular: state.celular,
        direccionCasa: state.direccionCasa,
        barrioCasa: state.barrioCasa,
        objMunicipioCasaId: state.objMunicipioCasaId,
        objDepartamentoCasaId: state.objDepartamentoCasaId,
        objPaisCasaId: state.objPaisCasaId,
        profesion: state.profesion,
        ocupacion: state.ocupacion,
        nacionalidad: state.nacionalidad,
        objCondicionCasaId: state.objCondicionCasaId,
        anosResidirCasa: state.anosResidirCasa,
        email: state.email,
        monto: state.monto,
        objMonedaId: state.objMonedaId,
        objPropositoId: state.objPropositoId,
        objFrecuenciaId: state.objFrecuenciaId,
        cuota: state.cuota,
        objActividadId: state.objActividadId,
        objActividadId1: state.objActividadId1,
        objActividadId2: state.objActividadId2,
        objSectorId: state.objSectorId,
        nombreNegocio: state.nombreNegocio,
        tiempoFuncionamientoNegocio: state.tiempoFuncionamientoNegocio,
        direccionNegocio: state.direccionNegocio,
        barrioNegocio: state.barrioNegocio,
        objMunicipioNegocioId: state.objMunicipioNegocioId,
        objCondicionNegocioId: state.objCondicionNegocioId,
        horarioTrabajo: state.horarioTrabajo,
        horarioVisita: state.horarioVisita,
        personasACargo: state.personasACargo,
        objEstadoCivilId: state.objEstadoCivilId,
        nombreConyugue: state.nombreConyugue,
        trabajaConyugue: state.trabajaConyugue,
        trabajoConyugue: state.trabajoConyugue,
        direccionTrabajoConyugue: state.direccionTrabajoConyugue,
        telefonoTrabajoConyugue: state.telefonoTrabajoConyugue,
        beneficiarioSeguro: state.beneficiarioSeguro,
        cedulaBeneficiarioSeguro: state.cedulaBeneficiarioSeguro,
        objParentescoBeneficiarioSeguroId:
            state.objParentescoBeneficiarioSeguroId,
        beneficiarioSeguro1: state.beneficiarioSeguro1,
        cedulaBeneficiarioSeguro1: state.cedulaBeneficiarioSeguro1,
        objParentescoBeneficiarioSeguroId1:
            state.objParentescoBeneficiarioSeguroId1,
        objEstadoSolicitudId: state.objEstadoSolicitudId,
        objOficialCreditoId: state.objOficialCreditoId,
        objProductoId: state.objProductoId,
        observacion: state.observacion,
        sucursal: state.sucursal,
        ubicacionLongitud: state.ubicacionLongitud,
        ubicacionLatitud: state.ubicacionLatitud,
        ubicacionGradosLongitud: state.ubicacionGradosLongitud,
        ubicacionGradosLatitud: state.ubicacionGradosLatitud,
        objEscolaridadId: state.objEscolaridadId,
        cantidadHijos: state.cantidadHijos,
        nombrePublico: state.nombrePublico,
        objSexoId: state.objSexoId,
        objPaisNacimientoId: state.objPaisNacimientoId,
        nacionalidadConyugue: state.nacionalidadConyugue,
        database: state.database,
        ubicacion: state.ubicacion,
        espeps: state.espeps,
        nombreDeEntidadPeps: state.nombreDeEntidadPeps,
        paisPeps: state.paisPeps,
        periodoPeps: state.periodoPeps,
        cargoOficialPeps: state.cargoOficialPeps,
        tieneFamiliarPeps: state.tieneFamiliarPeps,
        nombreFamiliarPeps2: state.nombreFamiliarPeps2,
        parentescoFamiliarPeps2: state.parentescoFamiliarPeps2,
        cargoFamiliarPeps2: state.cargoFamiliarPeps2,
        nombreEntidadPeps2: state.nombreEntidadPeps2,
        periodoPeps2: state.periodoPeps2,
        paisPeps2: state.paisPeps2,
        objRubroActividad: state.objRubroActividad,
        objActividadPredominante: state.objActividadPredominante,
        esFamiliarEmpleado: state.esFamiliarEmpleado,
        nombreFamiliar: state.nombreFamiliar,
        cedulaFamiliar: state.cedulaFamiliar,
        objTipoDocumentoId: state.objTipoDocumentoId,
        objRubroActividad2: state.objRubroActividad2,
        objRubroActividad3: state.objRubroActividad3,
        objRubroActividadPredominante: state.objRubroActividadPredominante,
        tipoPersona: state.tipoPersona,
        objTipoPersonaId: state.objTipoPersonaId,
        telefonoBeneficiario: state.telefonoBeneficiario,
        telefonoBeneficiarioSeguro1: state.telefonoBeneficiarioSeguro1,
        plazoSolicitud: state.plazoSolicitud,
        fechaPrimerPagoSolicitud: state.fechaPrimerPagoSolicitud,
      ));
      if (!isOk) {
        return emit(state.copyWith(status: Status.error, errorMsg: msg));
      }
      emit(state.copyWith(status: Status.done, onSuccessMsg: msg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void initAutoSave({String? uuid}) {
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid));

    autoSaveHelper = AutoSaveResponseLocalDb(
      box: localDbProvider.solicitudesResponsesBox,
      buildModel: _buildModel,
      uuid: newUuid,
      onSaved: (m) {
        emit(state.copyWith(
          idLocalResponse: m.id,
          uuid: m.uuid,
        ));
      },
    );
  }

  ResponseLocalDb _buildModel(ResponseLocalDb? existing) {
    final prev = existing;

    return ResponseLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      frecuenciaPagoMeses: state.frecuenciaPagoMeses == '0'
          ? prev?.frecuenciaPagoMeses
          : state.frecuenciaPagoMeses,
      montoMaximo:
          state.montoMaximo == 0 ? prev?.montoMaximo : state.montoMaximo,
      montoMinimo:
          state.montoMinimo == 0 ? prev?.montoMinimo : state.montoMinimo,
      hasVerified: state.hasVerified,
      errorMsg: _prefer(state.errorMsg, prev?.errorMsg),
      isDone: state.isDone,
      createdAt: prev?.createdAt ?? DateTime.now(),
      objOrigenSolicitudId:
          _prefer(state.objOrigenSolicitudId, prev?.objOrigenSolicitudId),
      horarioTrabajo: _prefer(state.horarioTrabajo, prev?.horarioTrabajo),
      horarioVisita: _prefer(state.horarioVisita, prev?.horarioVisita),
      personasACargo: state.personasACargo == 0
          ? (prev?.personasACargo ?? 0)
          : state.personasACargo,
      objEstadoCivilId: _prefer(state.objEstadoCivilId, prev?.objEstadoCivilId),
      nombreConyugue: _prefer(state.nombreConyugue, prev?.nombreConyugue),
      trabajaConyugue: !state.trabajaConyugue
          ? prev?.trabajaConyugue
          : state.trabajaConyugue,
      trabajoConyugue: _prefer(state.trabajoConyugue, prev?.trabajoConyugue),
      direccionTrabajoConyugue: _prefer(
          state.direccionTrabajoConyugue, prev?.direccionTrabajoConyugue),
      telefonoTrabajoConyugue:
          _prefer(state.telefonoTrabajoConyugue, prev?.telefonoTrabajoConyugue),
      beneficiarioSeguro:
          _prefer(state.beneficiarioSeguro, prev?.beneficiarioSeguro),
      cedulaBeneficiarioSeguro: _prefer(
          state.cedulaBeneficiarioSeguro, prev?.cedulaBeneficiarioSeguro),
      objParentescoBeneficiarioSeguroId: _prefer(
          state.objParentescoBeneficiarioSeguroId,
          prev?.objParentescoBeneficiarioSeguroId),
      beneficiarioSeguro1:
          _prefer(state.beneficiarioSeguro1, prev?.beneficiarioSeguro1),
      cedulaBeneficiarioSeguro1: _prefer(
          state.cedulaBeneficiarioSeguro1, prev?.cedulaBeneficiarioSeguro1),
      objParentescoBeneficiarioSeguroId1: _prefer(
          state.objParentescoBeneficiarioSeguroId1,
          prev?.objParentescoBeneficiarioSeguroId1),
      objEstadoSolicitudId:
          _prefer(state.objEstadoSolicitudId, prev?.objEstadoSolicitudId),
      objOficialCreditoId:
          _prefer(state.objOficialCreditoId, prev?.objOficialCreditoId),
      objProductoId: _prefer(state.objProductoId, prev?.objProductoId),
      observacion: _prefer(state.observacion, prev?.observacion),
      sucursal: _prefer(state.sucursal, prev?.sucursal),
      ubicacionLongitud: state.ubicacionLongitud.isEmpty
          ? prev?.ubicacionLongitud
          : state.ubicacionLongitud,
      ubicacionLatitud: state.ubicacionLatitud.isEmpty
          ? prev?.ubicacionLatitud
          : state.ubicacionLatitud,
      ubicacionGradosLongitud: state.ubicacionGradosLongitud,
      ubicacionGradosLatitud: state.ubicacionGradosLatitud,
      objEscolaridadId: _prefer(state.objEscolaridadId, prev?.objEscolaridadId),
      cantidadHijos: state.cantidadHijos == 0
          ? (prev?.cantidadHijos ?? 0)
          : state.cantidadHijos,
      nombrePublico: _prefer(state.nombrePublico, prev?.nombrePublico),
      objSexoId: _prefer(state.objSexoId, prev?.objSexoId),
      objPaisNacimientoId:
          _prefer(state.objPaisNacimientoId, prev?.objPaisNacimientoId),
      nacionalidadConyugue:
          _prefer(state.nacionalidadConyugue, prev?.nacionalidadConyugue),
      database: _prefer(state.database, prev?.database),
      ubicacion: state.ubicacion.isNotEmpty
          ? state.ubicacion
          : (prev?.ubicacion ?? ''),
      espeps: !state.espeps ? prev?.espeps : state.espeps,
      nombreDeEntidadPeps:
          _prefer(state.nombreDeEntidadPeps, prev?.nombreDeEntidadPeps),
      paisPeps: _prefer(state.paisPeps, prev?.paisPeps),
      periodoPeps: _prefer(state.periodoPeps, prev?.periodoPeps),
      cargoOficialPeps: _prefer(state.cargoOficialPeps, prev?.cargoOficialPeps),
      tieneFamiliarPeps: !state.tieneFamiliarPeps
          ? prev?.tieneFamiliarPeps
          : state.tieneFamiliarPeps,
      nombreFamiliarPeps2:
          _prefer(state.nombreFamiliarPeps2, prev?.nombreFamiliarPeps2),
      parentescoFamiliarPeps2:
          _prefer(state.parentescoFamiliarPeps2, prev?.parentescoFamiliarPeps2),
      cargoFamiliarPeps2:
          _prefer(state.cargoFamiliarPeps2, prev?.cargoFamiliarPeps2),
      nombreEntidadPeps2:
          _prefer(state.nombreEntidadPeps2, prev?.nombreEntidadPeps2),
      periodoPeps2: _prefer(state.periodoPeps2, prev?.periodoPeps2),
      paisPeps2: _prefer(state.paisPeps2, prev?.paisPeps2),
      objRubroActividad:
          _prefer(state.objRubroActividad, prev?.objRubroActividad),
      objActividadPredominante: _prefer(
          state.objActividadPredominante, prev?.objActividadPredominante),
      esFamiliarEmpleado: !state.esFamiliarEmpleado
          ? prev?.esFamiliarEmpleado
          : state.esFamiliarEmpleado,
      nombreFamiliar: _prefer(state.nombreFamiliar, prev?.nombreFamiliar),
      cedulaFamiliar: _prefer(state.cedulaFamiliar, prev?.cedulaFamiliar),
      objTipoDocumentoId:
          _prefer(state.objTipoDocumentoId, prev?.objTipoDocumentoId),
      objRubroActividad2:
          _prefer(state.objRubroActividad2, prev?.objRubroActividad2),
      objRubroActividad3:
          _prefer(state.objRubroActividad3, prev?.objRubroActividad3),
      objRubroActividadPredominante: _prefer(
          state.objRubroActividadPredominante,
          prev?.objRubroActividadPredominante),
      tipoPersona: _prefer(state.tipoPersona, prev?.tipoPersona),
      objTipoPersonaId: _prefer(state.objTipoPersonaId, prev?.objTipoPersonaId),
      telefonoBeneficiario:
          _prefer(state.telefonoBeneficiario, prev?.telefonoBeneficiario),
      telefonoBeneficiarioSeguro1: _prefer(
          state.telefonoBeneficiarioSeguro1, prev?.telefonoBeneficiarioSeguro1),
      plazoSolicitud: state.plazoSolicitud == 0
          ? (prev?.plazoSolicitud ?? 0)
          : state.plazoSolicitud,
      fechaPrimerPagoSolicitud: state.fechaPrimerPagoSolicitud.isEmpty
          ? prev?.fechaPrimerPagoSolicitud
          : state.fechaPrimerPagoSolicitud,
      nombre1: state.nombre1.isNotEmpty ? state.nombre1 : (prev?.nombre1 ?? ''),
      nombre2: _prefer(state.nombre2, prev?.nombre2),
      apellido1: _prefer(state.apellido1, prev?.apellido1),
      apellido2: _prefer(state.apellido2, prev?.apellido2),
      cedula: _prefer(state.cedula, prev?.cedula),
      objPaisEmisorCedula:
          _prefer(state.objPaisEmisorCedula, prev?.objPaisEmisorCedula),
      fechaEmisionCedula: state.fechaEmisionCedula.isEmpty
          ? prev?.fechaEmisionCedula
          : state.fechaEmisionCedula,
      fechaVencimientoCedula: state.fechaVencimientoCedula.isEmpty
          ? prev?.fechaVencimientoCedula
          : state.fechaVencimientoCedula,
      fechaNacimiento: state.fechaNacimiento.isEmpty
          ? prev?.fechaNacimiento
          : state.fechaNacimiento,
      telefono: _prefer(state.telefono, prev?.telefono),
      celular: _prefer(state.celular, prev?.celular),
      direccionCasa: _prefer(state.direccionCasa, prev?.direccionCasa),
      barrioCasa: _prefer(state.barrioCasa, prev?.barrioCasa),
      objMunicipioCasaId:
          _prefer(state.objMunicipioCasaId, prev?.objMunicipioCasaId),
      objDepartamentoCasaId:
          _prefer(state.objDepartamentoCasaId, prev?.objDepartamentoCasaId),
      objPaisCasaId: _prefer(state.objPaisCasaId, prev?.objPaisCasaId),
      profesion: _prefer(state.profesion, prev?.profesion),
      ocupacion: _prefer(state.ocupacion, prev?.ocupacion),
      nacionalidad: _prefer(state.nacionalidad, prev?.nacionalidad),
      objCondicionCasaId:
          _prefer(state.objCondicionCasaId, prev?.objCondicionCasaId),
      anosResidirCasa: state.anosResidirCasa == 0
          ? (prev?.anosResidirCasa ?? 0)
          : state.anosResidirCasa,
      email: _prefer(state.email, prev?.email),
      monto: state.monto == 0 ? (prev?.monto ?? 0) : state.monto,
      objMonedaId: _prefer(state.objMonedaId, prev?.objMonedaId),
      objPropositoId: _prefer(state.objPropositoId, prev?.objPropositoId),
      objFrecuenciaId: _prefer(state.objFrecuenciaId, prev?.objFrecuenciaId),
      cuota: state.cuota == 0 ? prev?.cuota : state.cuota,
      objActividadId: _prefer(state.objActividadId, prev?.objActividadId),
      objActividadId1: _prefer(state.objActividadId1, prev?.objActividadId1),
      objActividadId2: _prefer(state.objActividadId2, prev?.objActividadId2),
      objSectorId: _prefer(state.objSectorId, prev?.objSectorId),
      nombreNegocio: _prefer(state.nombreNegocio, prev?.nombreNegocio),
      tiempoFuncionamientoNegocio: state.tiempoFuncionamientoNegocio.isEmpty
          ? prev?.tiempoFuncionamientoNegocio
          : state.tiempoFuncionamientoNegocio,
      direccionNegocio: _prefer(state.direccionNegocio, prev?.direccionNegocio),
      barrioNegocio: _prefer(state.barrioNegocio, prev?.barrioNegocio),
      objMunicipioNegocioId:
          _prefer(state.objMunicipioNegocioId, prev?.objMunicipioNegocioId),
      objCondicionNegocioId:
          _prefer(state.objCondicionNegocioId, prev?.objCondicionNegocioId),
      fechaDesembolso: state.fechaDesembolso.isEmpty
          ? prev?.fechaDesembolso
          : state.fechaDesembolso,
      prestamoInteres: state.prestamoInteres == 0
          ? (prev?.prestamoInteres ?? 0)
          : state.prestamoInteres,
      objOrigenSolicitudIdVer:
          _prefer(state.objOrigenSolicitudIdVer, prev?.objOrigenSolicitudIdVer),
      objPaisEmisorCedulaVer:
          _prefer(state.objPaisEmisorCedulaVer, prev?.objPaisEmisorCedulaVer),
      objMunicipioCasaIdVer:
          _prefer(state.objMunicipioCasaIdVer, prev?.objMunicipioCasaIdVer),
      objDepartamentoCasaIdVer: _prefer(
          state.objDepartamentoCasaIdVer, prev?.objDepartamentoCasaIdVer),
      objPaisCasaIdVer: _prefer(state.objPaisCasaIdVer, prev?.objPaisCasaIdVer),
      objCondicionCasaIdVer:
          _prefer(state.objCondicionCasaIdVer, prev?.objCondicionCasaIdVer),
      objMonedaIdVer: _prefer(state.objMonedaIdVer, prev?.objMonedaIdVer),
      objPropositoIdVer:
          _prefer(state.objPropositoIdVer, prev?.objPropositoIdVer),
      objFrecuenciaIdVer:
          _prefer(state.objFrecuenciaIdVer, prev?.objFrecuenciaIdVer),
      objActividadIdVer:
          _prefer(state.objActividadIdVer, prev?.objActividadIdVer),
      objActividadId1Ver:
          _prefer(state.objActividadId1Ver, prev?.objActividadId1Ver),
      objActividadId2Ver:
          _prefer(state.objActividadId2Ver, prev?.objActividadId2Ver),
      objSectorIdVer: _prefer(state.objSectorIdVer, prev?.objSectorIdVer),
      objMunicipioNegocioIdVer: _prefer(
          state.objMunicipioNegocioIdVer, prev?.objMunicipioNegocioIdVer),
      objCondicionNegocioIdVer: _prefer(
          state.objCondicionNegocioIdVer, prev?.objCondicionNegocioIdVer),
      objEstadoCivilIdVer:
          _prefer(state.objEstadoCivilIdVer, prev?.objEstadoCivilIdVer),
      objParentescoBeneficiarioSeguroIdVer: _prefer(
          state.objParentescoBeneficiarioSeguroIdVer,
          prev?.objParentescoBeneficiarioSeguroIdVer),
      objParentescoBeneficiarioSeguroId1Ver: _prefer(
          state.objParentescoBeneficiarioSeguroId1Ver,
          prev?.objParentescoBeneficiarioSeguroId1Ver),
      objEstadoSolicitudIdVer:
          _prefer(state.objEstadoSolicitudIdVer, prev?.objEstadoSolicitudIdVer),
      objOficialCreditoIdVer:
          _prefer(state.objOficialCreditoIdVer, prev?.objOficialCreditoIdVer),
      objProductoIdVer: _prefer(state.objProductoIdVer, prev?.objProductoIdVer),
      objEscolaridadIdVer:
          _prefer(state.objEscolaridadIdVer, prev?.objEscolaridadIdVer),
      objSexoIdVer: _prefer(state.objSexoIdVer, prev?.objSexoIdVer),
      objPaisNacimientoIdVer:
          _prefer(state.objPaisNacimientoIdVer, prev?.objPaisNacimientoIdVer),
      objRubroActividadVer:
          _prefer(state.objRubroActividadVer, prev?.objRubroActividadVer),
      objActividadPredominanteVer: _prefer(
          state.objActividadPredominanteVer, prev?.objActividadPredominanteVer),
      objTipoDocumentoIdVer:
          _prefer(state.objTipoDocumentoIdVer, prev?.objTipoDocumentoIdVer),
      objRubroActividad2Ver:
          _prefer(state.objRubroActividad2Ver, prev?.objRubroActividad2Ver),
      objRubroActividad3Ver:
          _prefer(state.objRubroActividad3Ver, prev?.objRubroActividad3Ver),
      objRubroActividadPredominanteVer: _prefer(
          state.objRubroActividadPredominanteVer,
          prev?.objRubroActividadPredominanteVer),
      objTipoPersonaIdVer:
          _prefer(state.objTipoPersonaIdVer, prev?.objTipoPersonaIdVer),
    );
  }

  void onFieldChanged(SolicitudNuevaMenorState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';

  @override
  Future<void> close() {
    // autoSaveHelper.dispose();
    return super.close();
  }

  void saveCedula({
    String? cedulaFrontPath,
    String? cedulaBackPath,
  }) {
    emit(
      state.copyWith(
        cedulaFrontPath: cedulaFrontPath,
        cedulaBackPath: cedulaBackPath,
      ),
    );
  }
}
