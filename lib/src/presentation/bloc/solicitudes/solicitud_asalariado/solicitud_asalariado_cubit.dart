import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/asalariado_autosave.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asalariado/solicitud_asalariado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'solicitud_asalariado_state.dart';

class SolicitudAsalariadoCubit extends Cubit<SolicitudAsalariadoState> {
  final SolicitudesCreditoRepository _repository;
  final ObjectBoxService localDbProvider;

  SolicitudAsalariadoCubit(this._repository, this.localDbProvider)
      : super(SolicitudAsalariadoInitial());

  late final AsalariadoAutosave autoSaveHelper;

  Future<void> createSolicitudAsalariado() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg, numeroSolicitud) =
          await _repository.createSolicitudAsalariado(
        solicitudAsalariado: SolicitudAsalariado(
          isOffline: state.isOffline,
          objOrigenSolicitudId: state.objOrigenSolicitudId,
          database: state.database,
          nombre1: state.nombre1,
          nombre2: state.nombre2,
          apellido1: state.apellido1,
          apellido2: state.apellido2,
          cedula: state.cedula,
          objPaisEmisorCedula: state.objPaisEmisorCedula,
          fechaEmisionCedula: DateTime.tryParse(state.fechaEmisionCedula),
          fechaVencimientoCedula:
              DateTime.tryParse(state.fechaVencimientoCedula),
          fechaNacimiento: DateTime.tryParse(state.fechaNacimiento),
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
          objSectorId: state.objSectorId,
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
          codigoRed: state.codigoRed,
          plazoSolicitud: state.plazoSolicitud,
          fechaPrimerPagoSolicitud:
              DateTime.tryParse(state.fechaPrimerPagoSolicitud),
          nombreTrabajo: state.nombreTrabajo,
          direccionTrabajo: state.direccionTrabajo,
          barrioTrabajo: state.barrioTrabajo,
          objActividadEconomicaId: state.objActividadEconomicaId,
          objActividadEconomicaId1: state.objActividadEconomicaId1,
          objActividadEconomicaId2: state.objActividadEconomicaId2,
          cargo: state.cargo,
          direccionFamiliarCercano: state.direccionFamiliarCercano,
          duenoVivienda: state.duenoVivienda,
          fechaVenceAvaluoAsalariado:
              DateTime.tryParse(state.fechaVenceAvaluoAsalariado),
          fuenteOtrosIngresos: state.fuenteOtrosIngresos,
          fuenteOtrosIngresosConyugue: state.fuenteOtrosIngresosConyugue,
          lugarTrabajoAnterior: state.lugarTrabajoAnterior,
          nombreFamiliarCercano: state.nombreFamiliarCercano,
          objParentescoFamiliarCercanoId: state.objParentescoFamiliarCercanoId,
          otrosIngresosConyugue: state.otrosIngresosConyugue,
          otrosIngresosCordoba: state.otrosIngresosCordoba,
          pagoAlquiler: state.pagoAlquiler,
          profesionConyugue: state.profesionConyugue,
          salarioNetoCordoba: state.salarioNetoCordoba,
          sueldoMesConyugue: state.sueldoMesConyugue,
          telefonoFamiliarCercano: state.telefonoFamiliarCercano,
          telefonoTrabajo: state.telefonoTrabajo,
          tiempoLaborar: state.tiempoLaborar,
          tiempoLaborarConyugue: state.tiempoLaborarConyugue,
          totalIngresoMes: state.totalIngresoMes,
          totalIngresoMesConyugue: state.totalIngresoMesConyugue,
        ),
      );
      if (!isOk) {
        emit(state.copyWith(
          status: Status.error,
          errorMsg: msg,
        ));
        return;
      }
      emit(state.copyWith(
        status: Status.done,
        successMsg: msg,
        numeroSolicitud: numeroSolicitud,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMsg: e.toString(),
        status: Status.error,
      ));
    }
  }

  void sendCedulaImages({required String numeroSolicitud}) async {
    try {
      await _repository.sendCedulaImageWhenSolicitudCreditoCreated(
        numeroSolicitud: int.tryParse(numeroSolicitud) ?? 0,
        cedulaCliente: state.cedula,
        imagenFrontal: state.cedulaFrontPath,
        imagenTrasera: state.cedulaBackPath,
      );
    } catch (e) {
      emit(state.copyWith(
        errorMsg: e.toString(),
        status: Status.error,
      ));
    }
  }

  void initAutoSave({String? uuid}) {
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid));

    autoSaveHelper = AsalariadoAutosave(
      box: localDbProvider.solicitudesAsalariadoResponsesBox,
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

  AsalariadoResponsesLocalDb _buildModel(AsalariadoResponsesLocalDb? existing) {
    final prev = existing;

    return AsalariadoResponsesLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      objOrigenSolicitudIdVer:
          _prefer(state.objOrigenSolicitudIdVer, prev?.objOrigenSolicitudIdVer),
      createdAt: prev?.createdAt ?? DateTime.now(),
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
      objSectorIdVer: _prefer(state.objSectorIdVer, prev?.objSectorIdVer),
      objEstadoCivilIdVer:
          _prefer(state.objEstadoCivilIdVer, prev?.objEstadoCivilIdVer),
      objParentescoBeneficiarioSeguroIdVer: _prefer(
          state.objParentescoBeneficiarioSeguroIdVer,
          prev?.objParentescoBeneficiarioSeguroIdVer),
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
      objActividadEconomicaIdVer: _prefer(
          state.objActividadEconomicaIdVer, prev?.objActividadEconomicaIdVer),
      objActividadEconomicaId1Ver: _prefer(
          state.objActividadEconomicaId1Ver, prev?.objActividadEconomicaId1Ver),
      objActividadEconomicaId2Ver: _prefer(
          state.objActividadEconomicaId2Ver, prev?.objActividadEconomicaId2Ver),
      objParentescoFamiliarCercanoIdVer: _prefer(
          state.objParentescoFamiliarCercanoIdVer,
          prev?.objParentescoFamiliarCercanoIdVer),
      fechaDesembolso:
          _preferDate(state.fechaDesembolso, prev?.fechaDesembolso),
      tasaInteres:
          state.tasaInteres == 0 ? (prev?.tasaInteres ?? 0) : state.tasaInteres,
      montoMinimo:
          state.montoMinimo == 0 ? (prev?.montoMinimo ?? 0) : state.montoMinimo,
      montoMaximo:
          state.montoMaximo == 0 ? (prev?.montoMaximo ?? 0) : state.montoMaximo,
      hasVerified:
          !state.hasVerified ? (prev?.hasVerified ?? false) : state.hasVerified,
      isOffline: prev?.isOffline ?? false,
      objOrigenSolicitudId:
          _prefer(state.objOrigenSolicitudId, prev?.objOrigenSolicitudId),
      database: _prefer(state.database, prev?.database),
      nombre1: _prefer(state.nombre1, prev?.nombre1),
      nombre2: _prefer(state.nombre2, prev?.nombre2),
      apellido1: _prefer(state.apellido1, prev?.apellido1),
      apellido2: _prefer(state.apellido2, prev?.apellido2),
      cedula: _prefer(state.cedula, prev?.cedula),
      objPaisEmisorCedula:
          _prefer(state.objPaisEmisorCedula, prev?.objPaisEmisorCedula),
      fechaEmisionCedula:
          _preferDate(state.fechaEmisionCedula, prev?.fechaEmisionCedula),
      fechaVencimientoCedula: _preferDate(
          state.fechaVencimientoCedula, prev?.fechaVencimientoCedula),
      fechaNacimiento:
          _preferDate(state.fechaNacimiento, prev?.fechaNacimiento),
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
      cuota: state.cuota == 0 ? (prev?.cuota ?? 0) : state.cuota,
      objSectorId: _prefer(state.objSectorId, prev?.objSectorId),
      personasACargo: state.personasACargo == 0
          ? (prev?.personasACargo ?? 0)
          : state.personasACargo,
      objEstadoCivilId: _prefer(state.objEstadoCivilId, prev?.objEstadoCivilId),
      nombreConyugue: _prefer(state.nombreConyugue, prev?.nombreConyugue),
      trabajaConyugue: !state.trabajaConyugue
          ? (prev?.trabajaConyugue ?? false)
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
      objEstadoSolicitudId:
          _prefer(state.objEstadoSolicitudId, prev?.objEstadoSolicitudId),
      objOficialCreditoId:
          _prefer(state.objOficialCreditoId, prev?.objOficialCreditoId),
      objProductoId: _prefer(state.objProductoId, prev?.objProductoId),
      observacion: _prefer(state.observacion, prev?.observacion),
      sucursal: _prefer(state.sucursal, prev?.sucursal),
      ubicacionLongitud:
          _prefer(state.ubicacionLongitud, prev?.ubicacionLongitud),
      ubicacionLatitud: _prefer(state.ubicacionLatitud, prev?.ubicacionLatitud),
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
      ubicacion: _prefer(state.ubicacion, prev?.ubicacion),
      espeps: !state.espeps ? (prev?.espeps ?? false) : state.espeps,
      nombreDeEntidadPeps:
          _prefer(state.nombreDeEntidadPeps, prev?.nombreDeEntidadPeps),
      paisPeps: _prefer(state.paisPeps, prev?.paisPeps),
      periodoPeps: _prefer(state.periodoPeps, prev?.periodoPeps),
      cargoOficialPeps: _prefer(state.cargoOficialPeps, prev?.cargoOficialPeps),
      tieneFamiliarPeps: !state.tieneFamiliarPeps
          ? (prev?.tieneFamiliarPeps ?? false)
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
          ? (prev?.esFamiliarEmpleado ?? false)
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
      plazoSolicitud: state.plazoSolicitud == 0
          ? (prev?.plazoSolicitud ?? 0)
          : state.plazoSolicitud,
      fechaPrimerPagoSolicitud: _preferDate(
        state.fechaPrimerPagoSolicitud,
        prev?.fechaPrimerPagoSolicitud,
      ),
      nombreTrabajo: _prefer(state.nombreTrabajo, prev?.nombreTrabajo),
      direccionTrabajo: _prefer(state.direccionTrabajo, prev?.direccionTrabajo),
      barrioTrabajo: _prefer(state.barrioTrabajo, prev?.barrioTrabajo),
      objActividadEconomicaId:
          _prefer(state.objActividadEconomicaId, prev?.objActividadEconomicaId),
      objActividadEconomicaId1: _prefer(
          state.objActividadEconomicaId1, prev?.objActividadEconomicaId1),
      objActividadEconomicaId2: _prefer(
          state.objActividadEconomicaId2, prev?.objActividadEconomicaId2),
      cargo: _prefer(state.cargo, prev?.cargo),
      direccionFamiliarCercano: _prefer(
          state.direccionFamiliarCercano, prev?.direccionFamiliarCercano),
      duenoVivienda: _prefer(state.duenoVivienda, prev?.duenoVivienda),
      fuenteOtrosIngresos:
          _prefer(state.fuenteOtrosIngresos, prev?.fuenteOtrosIngresos),
      fuenteOtrosIngresosConyugue: _prefer(
          state.fuenteOtrosIngresosConyugue, prev?.fuenteOtrosIngresosConyugue),
      lugarTrabajoAnterior:
          _prefer(state.lugarTrabajoAnterior, prev?.lugarTrabajoAnterior),
      nombreFamiliarCercano:
          _prefer(state.nombreFamiliarCercano, prev?.nombreFamiliarCercano),
      objParentescoFamiliarCercanoId: _prefer(
          state.objParentescoFamiliarCercanoId,
          prev?.objParentescoFamiliarCercanoId),
      otrosIngresosConyugue: state.otrosIngresosConyugue,
      otrosIngresosCordoba: state.otrosIngresosCordoba == 0
          ? (prev?.otrosIngresosCordoba ?? 0)
          : state.otrosIngresosCordoba,
      pagoAlquiler:
          state.pagoAlquiler == 0 ? (prev?.pagoAlquiler) : state.pagoAlquiler,
      profesionConyugue:
          _prefer(state.profesionConyugue, prev?.profesionConyugue),
      salarioNetoCordoba: state.salarioNetoCordoba == 0
          ? (prev?.salarioNetoCordoba)
          : state.salarioNetoCordoba,
      sueldoMesConyugue: state.sueldoMesConyugue == 0
          ? prev?.sueldoMesConyugue
          : state.sueldoMesConyugue,
      telefonoFamiliarCercano:
          _prefer(state.telefonoFamiliarCercano, prev?.telefonoFamiliarCercano),
      telefonoTrabajo: _prefer(state.telefonoTrabajo, prev?.telefonoTrabajo),
      tiempoLaborar: state.tiempoLaborar == '0'
          ? (prev?.tiempoLaborar ?? '0')
          : state.tiempoLaborar,
      tiempoLaborarConyugue: state.tiempoLaborarConyugue == '0'
          ? (prev?.tiempoLaborarConyugue ?? '0')
          : state.tiempoLaborarConyugue,
      totalIngresoMes: state.totalIngresoMes == 0
          ? (prev?.totalIngresoMes ?? 0)
          : state.totalIngresoMes,
      totalIngresoMesConyugue: state.totalIngresoMesConyugue == 0
          ? (prev?.totalIngresoMesConyugue ?? 0)
          : state.totalIngresoMesConyugue,
      errorMsg: _prefer(state.errorMsg, prev?.errorMsg),
      isDone: !state.isDone ? (prev?.isDone ?? false) : state.isDone,
      frecuenciaPagoMeses:
          _prefer(state.frecuenciaPagoMeses, prev?.frecuenciaPagoMeses),
    );
  }

  void onFieldChanged(SolicitudAsalariadoState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';

  DateTime? _preferDate(String? current, DateTime? previous) {
    final parsed = DateTime.tryParse(current ?? '');
    return parsed ?? previous;
  }

  void saveCedula({
    String? cedulaFrontPath,
    String? cedulaBackPath,
  }) async {
    emit(state.copyWith(
      cedulaFrontPath: cedulaFrontPath,
      cedulaBackPath: cedulaBackPath,
    ));
  }
}
