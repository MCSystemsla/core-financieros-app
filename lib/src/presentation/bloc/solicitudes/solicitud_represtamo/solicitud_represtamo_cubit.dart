import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/represtamo_autosave.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'solicitud_represtamo_state.dart';

class SolicitudReprestamoCubit extends Cubit<SolicitudReprestamoState> {
  final ObjectBoxService localDbProvider;
  final SolicitudesCreditoRepository _solicitudesCreditoRepository;
  SolicitudReprestamoCubit(
      this._solicitudesCreditoRepository, this.localDbProvider)
      : super(SolicitudReprestamoInitial());
  late final ReprestamoAutosave autoSaveHelper;

  Future<void> createSolicitudReprestamo() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) =
          await _solicitudesCreditoRepository.createSolicitudReprestamo(
        solicitudReprestamo: SolicitudReprestamo(
          isOffline: state.isOffline,
          cuota: state.cuota.toInt(),
          monto: state.monto.toInt(),
          userIp: '',
          username: '',
          database: state.database,
          objOrigenSolicitudId: state.objOrigenSolicitudId,
          cedula: state.cedula,
          objMonedaId: state.objMonedaId,
          objPropositoId: state.objPropositoId,
          objFrecuenciaId: state.objFrecuenciaId,
          objActividadId: state.objActividadId,
          objActividadId1: state.objActividadId1,
          objActividadId2: state.objActividadId2,
          objSectorId: state.objSectorId,
          beneficiarioSeguro: state.beneficiarioSeguro,
          cedulaBeneficiarioSeguro: state.cedulaBeneficiarioSeguro,
          objParentescoBeneficiarioSeguroId:
              state.objParentescoBeneficiarioSeguroId,
          objProductoId: state.objProductoId,
          observacion: state.observacion,
          ubicacionLongitud: state.ubicacionLongitud,
          ubicacionLatitud: state.ubicacionLatitud,
          sucursal: state.sucursal,
          ubicacion: state.ubicacion,
          esPeps: state.esPeps,
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
          objTipoDocumentoId: state.objTipoDocumentoId,
          objRubroActividad2: state.objRubroActividad2,
          objRubroActividad3: state.objRubroActividad3,
          objRubroActividadPredominante: state.objRubroActividadPredominante,
          tipoPersona: state.tipoPersona,
          objTipoPersonaId: state.objTipoPersonaId,
          telefonoBeneficiario: state.telefonoBeneficiario,
          esFamiliarEmpleado: state.esFamiliarEmpleado,
          nombreFamiliar: state.nombreFamiliar,
          cedulaFamiliar: state.cedulaFamiliar,
          plazoSolicitud: state.plazoSolicitud,
          celularReprestamo: state.celularReprestamo,
          fechaPrimerPagoSolicitud:
              DateTime.parse(state.fechaPrimerPagoSolicitud),
        ),
      );
      if (!isOk) {
        emit(state.copyWith(errorMsg: msg, status: Status.error));
        return;
      }
      emit(state.copyWith(successMsg: msg, status: Status.done));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  void initAutoSave({String? uuid}) {
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid));

    autoSaveHelper = ReprestamoAutosave(
      box: localDbProvider.solicitudesReprestamoResponsesBox,
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

  ReprestamoResponsesLocalDb _buildModel(ReprestamoResponsesLocalDb? existing) {
    final prev = existing;

    return ReprestamoResponsesLocalDb(
      id: prev?.id ?? 0,
      montoMaximo:
          state.montoMaximo == 0 ? prev?.montoMaximo ?? 0 : state.montoMaximo,
      montoMinimo:
          state.montoMinimo == 0 ? prev?.montoMinimo ?? 0 : state.montoMinimo,
      frecuenciaPagoMeses: _prefer(
        state.frecuenciaPagoMeses,
        prev?.frecuenciaPagoMeses,
      ),
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      celularReprestamo:
          _prefer(state.celularReprestamo, prev?.celularReprestamo),
      fechaPrimerPagoSolicitud: _preferDate(
        state.fechaPrimerPagoSolicitud,
        prev?.fechaPrimerPagoSolicitud,
      ),
      nombreCompletoCliente: _prefer(
        state.nombreCompletoCliente,
        prev?.nombreCompletoCliente,
      ),
      plazoSolicitud: state.plazoSolicitud == 0
          ? (prev?.plazoSolicitud ?? 0)
          : state.plazoSolicitud,
      objOrigenSolicitudIdVer:
          _prefer(state.objOrigenSolicitudIdVer, prev?.objOrigenSolicitudIdVer),
      createdAt: prev?.createdAt ?? DateTime.now(),
      objMonedaIdVer: _prefer(state.objMonedaIdVer, prev?.objMonedaIdVer),
      objPropositoIdVer:
          _prefer(state.objPropositoIdVer, prev?.objPropositoIdVer),
      objFrecuenciaIdVer2:
          _prefer(state.objFrecuenciaIdVer2, prev?.objFrecuenciaIdVer2),
      objActividadIdVer:
          _prefer(state.objActividadIdVer, prev?.objActividadIdVer),
      objActividadId1Ver:
          _prefer(state.objActividadId1Ver, prev?.objActividadId1Ver),
      objActividadId2Ver:
          _prefer(state.objActividadId2Ver, prev?.objActividadId2Ver),
      objSectorIdVer: _prefer(state.objSectorIdVer, prev?.objSectorIdVer),
      objParentescoBeneficiarioSeguroIdVer: _prefer(
          state.objParentescoBeneficiarioSeguroIdVer,
          prev?.objParentescoBeneficiarioSeguroIdVer),
      objProductoIdVer: _prefer(state.objProductoIdVer, prev?.objProductoIdVer),
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
      parentescoFamiliar:
          _prefer(state.parentescoFamiliar, prev?.parentescoFamiliar),
      parentescoFamiliarVer:
          _prefer(state.parentescoFamiliarVer, prev?.parentescoFamiliarVer),
      errorMsg: _prefer(state.errorMsg, prev?.errorMsg),
      isOffline:
          !state.isOffline ? (prev?.isOffline ?? false) : state.isOffline,
      objRubroActividad:
          _prefer(state.objRubroActividad, prev?.objRubroActividad),
      objFrecuenciaIdVer:
          _prefer(state.objFrecuenciaIdVer, prev?.objFrecuenciaIdVer),
      fechaDesembolso:
          _preferDate(state.fechaDesembolso, prev?.fechaDesembolso),
      hasVerified:
          !state.hasVerified ? (prev?.hasVerified ?? false) : state.hasVerified,
      isDone: !state.isDone ? (prev?.isDone ?? false) : state.isDone,
      prestamoInteres: state.tasaInteres == 0
          ? (prev?.prestamoInteres ?? 0)
          : state.tasaInteres,
      objOrigenSolicitudId:
          _prefer(state.objOrigenSolicitudId, prev?.objOrigenSolicitudId),
      cedula: _prefer(state.cedula, prev?.cedula),
      monto: state.monto == 0 ? (prev?.monto ?? 0) : state.monto,
      objMonedaId: _prefer(state.objMonedaId, prev?.objMonedaId),
      objPropositoId: _prefer(state.objPropositoId, prev?.objPropositoId),
      objFrecuenciaId: _prefer(state.objFrecuenciaId, prev?.objFrecuenciaId),
      cuota: state.cuota == 0 ? (prev?.cuota ?? 0) : state.cuota,
      objActividadId: _prefer(state.objActividadId, prev?.objActividadId),
      objActividadId1: _prefer(state.objActividadId1, prev?.objActividadId1),
      objActividadId2: _prefer(state.objActividadId2, prev?.objActividadId2),
      objSectorId: _prefer(state.objSectorId, prev?.objSectorId),
      beneficiarioSeguro:
          _prefer(state.beneficiarioSeguro, prev?.beneficiarioSeguro),
      cedulaBeneficiarioSeguro: _prefer(
          state.cedulaBeneficiarioSeguro, prev?.cedulaBeneficiarioSeguro),
      objParentescoBeneficiarioSeguroId: _prefer(
          state.objParentescoBeneficiarioSeguroId,
          prev?.objParentescoBeneficiarioSeguroId),
      objProductoId: _prefer(state.objProductoId, prev?.objProductoId),
      observacion: _prefer(state.observacion, prev?.observacion),
      ubicacionLongitud:
          _prefer(state.ubicacionLongitud, prev?.ubicacionLongitud),
      ubicacionLatitud: _prefer(state.ubicacionLatitud, prev?.ubicacionLatitud),
      sucursal: _prefer(state.sucursal, prev?.sucursal),
      ubicacion: _prefer(state.ubicacion, prev?.ubicacion),
      esPeps: !state.esPeps ? (prev?.esPeps ?? false) : state.esPeps,
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
    );
  }

  void onFieldChanged(SolicitudReprestamoState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';

  DateTime? _preferDate(String? current, DateTime? previous) {
    final parsed = DateTime.tryParse(current ?? '');
    return parsed ?? previous;
  }

  void saveCedula({String? cedulaFrontPath, String? cedulaBackPath}) {
    emit(
      state.copyWith(
        cedulaFrontPath: cedulaFrontPath,
        cedulaBackPath: cedulaBackPath,
      ),
    );
  }
}
