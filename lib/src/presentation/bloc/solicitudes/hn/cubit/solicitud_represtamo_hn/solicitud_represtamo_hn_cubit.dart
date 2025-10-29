import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/hn/represtamo_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/local_db/solicitud_represtamo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/solicitud_represtamo_hn.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'solicitud_represtamo_hn_state.dart';

class SolicitudReprestamoHnCubit extends Cubit<SolicitudReprestamoHnState> {
  final SolicitudesCreditoHnRepository _repository;
  final SolicitudesHnBoxService localDbProvider;
  SolicitudReprestamoHnCubit(
    this._repository,
    this.localDbProvider,
  ) : super(SolicitudReprestamoHnInitial());
  late final ReprestamoHnAutosave autoSaveHelper;

  Future<void> createSolicitudReprestamo() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) = await _repository.createSolicitudReprestamo(
        solicitud: SolicitudReprestamoHn(
          descripcionDestino: state.descripcionDestino,
          origenSolicitudCodigo: state.origenSolicitudCodigo,
          cedula: state.cedula,
          monto: state.monto,
          monedaCodigo: state.monedaCodigo,
          propositoCodigo: state.propositoCodigo,
          frecuenciaCodigo: state.frecuenciaCodigo,
          cuota: state.cuota,
          beneficiarioSeguro: state.beneficiarioSeguro,
          cedulaBeneficiarioSeguro: state.cedulaBeneficiarioSeguro,
          parentescoBeneficiarioSeguroCodigo:
              state.parentescoBeneficiarioSeguroCodigo,
          productoCodigo: state.productoCodigo,
          observacion: state.observacion,
          ubicacionLongitud: state.ubicacionLongitud,
          ubicacionLatitud: state.ubicacionLatitud,
          ubicacion: state.ubicacion,
          esPeps: state.esPeps == 'input.yes'.tr(),
          nombreDeEntidadPeps: state.nombreDeEntidadPeps,
          paisPeps: state.paisPeps,
          periodoPeps: state.periodoPeps,
          cargoOficialPeps: state.cargoOficialPeps,
          tieneFamiliarPeps: state.tieneFamiliarPeps == 'input.yes'.tr(),
          nombreFamiliarPeps2: state.nombreFamiliarPeps2,
          parentescoFamiliarPeps2Codigo: state.parentescoFamiliarPeps2Codigo,
          cargoFamiliarPeps2: state.cargoFamiliarPeps2,
          nombreEntidadPeps2: state.nombreEntidadPeps2,
          periodoPeps2: state.periodoPeps2,
          paisPeps2: state.paisPeps2,
          tipoDocumentoCodigo: state.tipoDocumentoCodigo,
          celularReprestamo: state.celularReprestamo,
          esFamiliarEmpleado: state.esFamiliarEmpleado == 'input.yes'.tr(),
          nombreFamiliar: state.nombreFamiliar,
          cedulaFamiliar: state.cedulaFamiliar,
          plazoSolicitud: state.plazoSolicitud,
          fechaPrimerPagoSolicitud:
              DateTime.parse(state.fechaPrimerPagoSolicitud),
          tipoPersonaCodigo: state.tipoPersonaCodigo,
          cargaAnalisisAutomatico:
              state.cargaAnalisisAutomatico == 'input.yes'.tr(),
          motivoRevisionCodigo: state.motivoRevisionCodigo,
          actividadEconomicaCiuu1: state.actividadEconomicaCiuu1,
          actividadEconomicaCiuu2: state.actividadEconomicaCiuu2,
          actividadEconomicaCiuu3: state.actividadEconomicaCiuu3,
          codigoUsa: state.codigoUsa,
          apnfd: state.apnfd == 'input.yes'.tr(),
          actividadEconomicaRealizaCiuu1: state.actividadEconomicaRealizaCiuu1,
          actividadEconomicaRealizaCiuu2: state.actividadEconomicaRealizaCiuu2,
          actividadEconomicaRealizaCiuu3: state.actividadEconomicaRealizaCiuu3,
          tieneIdentificacionEstadosUnidos:
              state.tieneIdentificacionEstadosUnidos == 'input.yes'.tr(),
          tieneVinculoEstadosUnidos:
              state.tieneVinculoEstadosUnidos == 'input.yes'.tr(),
          vinculoEstadosUnidosDescripcion:
              state.vinculoEstadosUnidosDescripcion,
          ejerceActividadApfnd: state.ejerceActividadApfnd == 'input.yes'.tr(),
          medidasConocimientoCodigo: state.medidasConocimientoCodigo,
          nombreEmpleadoFamiliar: state.nombreEmpleadoFamiliar,
        ),
      );
      if (!isOk) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMsg: msg,
          ),
        );
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }

  void initAutoSave({String? uuid}) {
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid));

    autoSaveHelper = ReprestamoHnAutosave(
      box: localDbProvider.solicitudesReprestamoBox,
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

  SolicitudReprestamoHnLocalDb _buildModel(
      SolicitudReprestamoHnLocalDb? existing) {
    final prev = existing;

    return SolicitudReprestamoHnLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      actividadEconomicaCiuu1:
          _prefer(state.actividadEconomicaCiuu1, prev?.actividadEconomicaCiuu1),
      actividadEconomicaCiuu2:
          _prefer(state.actividadEconomicaCiuu2, prev?.actividadEconomicaCiuu2),
      actividadEconomicaCiuu3:
          _prefer(state.actividadEconomicaCiuu3, prev?.actividadEconomicaCiuu3),
      actividadEconomicaRealizaCiuu1: _prefer(
          state.actividadEconomicaRealizaCiuu1,
          prev?.actividadEconomicaRealizaCiuu1),
      actividadEconomicaRealizaCiuu2: _prefer(
          state.actividadEconomicaRealizaCiuu2,
          prev?.actividadEconomicaRealizaCiuu2),
      actividadEconomicaRealizaCiuu3: _prefer(
          state.actividadEconomicaRealizaCiuu3,
          prev?.actividadEconomicaRealizaCiuu3),
      tieneIdentificacionEstadosUnidos: _prefer(
          state.tieneIdentificacionEstadosUnidos,
          prev?.tieneIdentificacionEstadosUnidos),
      tieneVinculoEstadosUnidos: _prefer(
          state.tieneVinculoEstadosUnidos, prev?.tieneVinculoEstadosUnidos),
      ejerceActividadApfnd:
          _prefer(state.ejerceActividadApfnd, prev?.ejerceActividadApfnd),
      apnfd: _prefer(state.apnfd, prev?.apnfd),
      beneficiarioSeguro:
          _prefer(state.beneficiarioSeguro, prev?.beneficiarioSeguro),
      cedulaBeneficiarioSeguro: _prefer(
          state.cedulaBeneficiarioSeguro, prev?.cedulaBeneficiarioSeguro),
      parentescoBeneficiarioSeguroCodigo: _prefer(
          state.parentescoBeneficiarioSeguroCodigo,
          prev?.parentescoBeneficiarioSeguroCodigo),
      productoCodigo: _prefer(state.productoCodigo, prev?.productoCodigo),
      observacion: _prefer(state.observacion, prev?.observacion),
      ubicacionLongitud:
          _prefer(state.ubicacionLongitud, prev?.ubicacionLongitud),
      ubicacionLatitud: _prefer(state.ubicacionLatitud, prev?.ubicacionLatitud),
      ubicacion: _prefer(state.ubicacion, prev?.ubicacion),
      esPeps: _prefer(state.esPeps, prev?.esPeps),
      nombreDeEntidadPeps:
          _prefer(state.nombreDeEntidadPeps, prev?.nombreDeEntidadPeps),
      paisPeps: _prefer(state.paisPeps, prev?.paisPeps),
      periodoPeps: _prefer(state.periodoPeps, prev?.periodoPeps),
      cargoOficialPeps: _prefer(state.cargoOficialPeps, prev?.cargoOficialPeps),
      tieneFamiliarPeps:
          _prefer(state.tieneFamiliarPeps, prev?.tieneFamiliarPeps),
      nombreFamiliarPeps2:
          _prefer(state.nombreFamiliarPeps2, prev?.nombreFamiliarPeps2),
      parentescoFamiliarPeps2Codigo: _prefer(
          state.parentescoFamiliarPeps2Codigo,
          prev?.parentescoFamiliarPeps2Codigo),
      cargoFamiliarPeps2:
          _prefer(state.cargoFamiliarPeps2, prev?.cargoFamiliarPeps2),
      nombreEntidadPeps2:
          _prefer(state.nombreEntidadPeps2, prev?.nombreEntidadPeps2),
      periodoPeps2: _prefer(state.periodoPeps2, prev?.periodoPeps2),
      paisPeps2: _prefer(state.paisPeps2, prev?.paisPeps2),
      tipoDocumentoCodigo:
          _prefer(state.tipoDocumentoCodigo, prev?.tipoDocumentoCodigo),
      celularReprestamo:
          _prefer(state.celularReprestamo, prev?.celularReprestamo),
      esFamiliarEmpleado:
          _prefer(state.esFamiliarEmpleado, prev?.esFamiliarEmpleado),
      nombreFamiliar: _prefer(state.nombreFamiliar, prev?.nombreFamiliar),
      cedulaFamiliar: _prefer(state.cedulaFamiliar, prev?.cedulaFamiliar),
      tipoPersonaCodigo:
          _prefer(state.tipoPersonaCodigo, prev?.tipoPersonaCodigo),
      cedula: _prefer(state.cedula, prev?.cedula),
      monto: state.monto == 0 ? (prev?.monto ?? 0) : state.monto,
      codigoUsa: _prefer(state.codigoUsa, prev?.codigoUsa),
      cuota: state.cuota == 0 ? (prev?.cuota ?? 0) : state.cuota,
      fechaPrimerPagoSolicitud: _preferDate(
        state.fechaPrimerPagoSolicitud,
        prev?.fechaPrimerPagoSolicitud,
      ),
      monedaCodigo: _prefer(state.monedaCodigo, prev?.monedaCodigo),
      medidasConocimientoCodigo: _prefer(
          state.medidasConocimientoCodigo, prev?.medidasConocimientoCodigo),
      vinculoEstadosUnidosDescripcion: _prefer(
        state.vinculoEstadosUnidosDescripcion,
        prev?.vinculoEstadosUnidosDescripcion,
      ),
      plazoSolicitud: state.plazoSolicitud == 0
          ? (prev?.plazoSolicitud ?? 0)
          : state.plazoSolicitud,
      nombreEmpleadoFamiliar:
          _prefer(state.nombreEmpleadoFamiliar, prev?.nombreEmpleadoFamiliar),
      propositoCodigo: _prefer(state.propositoCodigo, prev?.propositoCodigo),
      origenSolicitudCodigo:
          _prefer(state.origenSolicitudCodigo, prev?.origenSolicitudCodigo),
      frecuenciaCodigo: _prefer(state.frecuenciaCodigo, prev?.frecuenciaCodigo),
      nombreCompleto: _prefer(state.nombreCompleto, prev?.nombreCompleto),
      descripcionDestino:
          _prefer(state.descripcionDestino, prev?.descripcionDestino),
      tasaInteres:
          state.tasaInteres == 0 ? prev?.tasaInteres : state.tasaInteres,
      montoMinimo:
          state.montoMinimo == 0 ? prev?.montoMinimo : state.montoMinimo,
      montoMaximo:
          state.montoMaximo == 0 ? prev?.montoMaximo : state.montoMaximo,
      fechaDesembolso:
          _preferDate(state.fechaDesembolso, prev?.fechaDesembolso),
      frecuenciaPagoMeses:
          _prefer(state.frecuenciaPagoMeses, prev?.frecuenciaPagoMeses),
      isDone: state.isDone,
    );
  }

  void onFieldChanged(SolicitudReprestamoHnState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';
  bool boolPrefer(bool stateValue, bool? prevValue) {
    return stateValue ? true : (prevValue ?? false);
  }

  DateTime? _preferDate(String? current, DateTime? previous) {
    final parsed = DateTime.tryParse(current ?? '');
    return parsed ?? previous;
  }

  void loadFromLocalDb(SolicitudReprestamoHnLocalDb solicitud) {
    onFieldChanged(
      () => state.copyWith(
        nombreCompleto: solicitud.nombreCompleto,
        tipoPersonaCodigo: solicitud.tipoPersonaCodigo,
        tipoDocumentoCodigo: solicitud.tipoDocumentoCodigo,
        cedula: solicitud.cedula,
        celularReprestamo: solicitud.celularReprestamo,
        ubicacion: solicitud.ubicacion,
        vinculoEstadosUnidosDescripcion:
            solicitud.vinculoEstadosUnidosDescripcion,
        codigoUsa: solicitud.codigoUsa,
        tieneIdentificacionEstadosUnidos:
            solicitud.tieneIdentificacionEstadosUnidos,
        tieneFamiliarPeps: solicitud.tieneFamiliarPeps,
        nombreFamiliar: solicitud.nombreFamiliar,
        cedulaFamiliar: solicitud.cedulaFamiliar,
        esPeps: solicitud.esPeps,
        nombreDeEntidadPeps: solicitud.nombreDeEntidadPeps,
        paisPeps: solicitud.paisPeps,
        periodoPeps: solicitud.periodoPeps,
        cargoOficialPeps: solicitud.cargoOficialPeps,
        esFamiliarEmpleado: solicitud.esFamiliarEmpleado,
        nombreFamiliarPeps2: solicitud.nombreFamiliarPeps2,
        nombreEntidadPeps2: solicitud.nombreEntidadPeps2,
        parentescoFamiliarPeps2Codigo: solicitud.parentescoFamiliarPeps2Codigo,
        cargoFamiliarPeps2: solicitud.cargoFamiliarPeps2,
        periodoPeps2: solicitud.periodoPeps2,
        paisPeps2: solicitud.paisPeps2,
        propositoCodigo: solicitud.propositoCodigo,
        descripcionDestino: solicitud.descripcionDestino,
        monedaCodigo: solicitud.monedaCodigo,
        monto: solicitud.monto,
        productoCodigo: solicitud.productoCodigo,
        plazoSolicitud: solicitud.plazoSolicitud,
        fechaPrimerPagoSolicitud:
            solicitud.fechaPrimerPagoSolicitud?.toUtc().toIso8601String(),
        frecuenciaCodigo: solicitud.frecuenciaCodigo,
        observacion: solicitud.observacion,
        actividadEconomicaCiuu1: solicitud.actividadEconomicaCiuu1,
        actividadEconomicaRealizaCiuu1:
            solicitud.actividadEconomicaRealizaCiuu1,
        actividadEconomicaCiuu2: solicitud.actividadEconomicaCiuu2,
        actividadEconomicaRealizaCiuu2:
            solicitud.actividadEconomicaRealizaCiuu2,
        actividadEconomicaCiuu3: solicitud.actividadEconomicaCiuu3,
        actividadEconomicaRealizaCiuu3:
            solicitud.actividadEconomicaRealizaCiuu3,
        ejerceActividadApfnd: solicitud.ejerceActividadApfnd,
        apnfd: solicitud.apnfd,
        medidasConocimientoCodigo: solicitud.medidasConocimientoCodigo,
        nombreEmpleadoFamiliar: solicitud.nombreEmpleadoFamiliar,
        cuota: solicitud.cuota,
        tieneVinculoEstadosUnidos: solicitud.tieneVinculoEstadosUnidos,
        fechaDesembolso: solicitud.fechaDesembolso?.toUtc().toIso8601String(),
        tasaInteres: solicitud.tasaInteres,
        montoMinimo: solicitud.montoMinimo,
        montoMaximo: solicitud.montoMaximo,
        frecuenciaPagoMeses: solicitud.frecuenciaPagoMeses,
        isDone: solicitud.isDone,
      ),
    );
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
