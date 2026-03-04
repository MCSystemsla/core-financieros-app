import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/hn/aslariado_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitud_asalariado_hn_db_local.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/solicitud_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/nueva/solicitud_nueva_signature_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'solicitud_aslariado_hn_state.dart';

class SolicitudAslariadoHnCubit extends Cubit<SolicitudAslariadoHnState> {
  final SolicitudesCreditoHnRepository _repository;
  late final AutoSaveSolicitudAsalariadoHN autoSaveHelper;
  final SolicitudesHnBoxService localDbProvider;
  SolicitudAslariadoHnCubit(
    this._repository,
    this.localDbProvider,
  ) : super(SolicitudAslariadoHnInitial());
  Future<void> createSolicitudAsalariado() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg, numeroSolicitud, idSolicitud) =
          await _repository.createSolicitudAsalariado(
        solicitud: SolicitudAsalariadoHn(
          cedulaConyuge: state.cedulaConyuge,
          tipoDocumentoConyugeCodigo: state.tipoDocumentoConyugeCodigo,
          historialCredito: state.historialCredito,
          descripcionDestino: state.descripcionDestino,
          database: state.database,
          isOffline: state.isOffline,
          origenSolicitudCodigo: state.origenSolicitudCodigo,
          nombre1: state.nombre1,
          nombre2: state.nombre2,
          apellido1: state.apellido1,
          apellido2: state.apellido2,
          cedula: state.cedula,
          paisEmisorCedulaCodigo: state.paisEmisorCedulaCodigo,
          fechaEmisionCedula: DateTime.tryParse(state.fechaEmisionCedula),
          fechaVencimientoCedula: DateTime.parse(state.fechaVencimientoCedula),
          fechaNacimiento: DateTime.parse(state.fechaNacimiento),
          telefono: state.telefono,
          celular: state.celular,
          direccionCasa: state.direccionCasa,
          barrioCasa: state.barrioCasa,
          municipioCasaCodigo: state.municipioCasaCodigo,
          departamentoCasaCodigo: state.departamentoCasaCodigo,
          paisCasaCodigo: state.paisCasaCodigo,
          nacinalidad: state.nacinalidad,
          condicionCasaCodigo: state.condicionCasaCodigo,
          anosResidirCasa: state.anosResidirCasa,
          email: state.email,
          monto: state.monto,
          monedaCodigo: state.monedaCodigo,
          propositoCodigo: state.propositoCodigo,
          frecuenciaCodigo: state.frecuenciaCodigo,
          cuota: state.cuotaWithDecimal,
          sectorCodigo: state.sectorCodigo,
          personasACargo: state.personasACargo,
          estadoCivilCodigo: state.estadoCivilCodigo,
          nombreConyugue: state.nombreConyugue,
          trabajaConyugue: state.trabajaConyugue == 'input.yes'.tr(),
          trabajoConyugue: state.trabajoConyugue,
          direccionTrabajoConyugue: state.direccionTrabajoConyugue,
          telefonoTrabajoConyugue: state.telefonoTrabajoConyugue,
          productoCodigo: state.productoCodigo,
          observacion: state.observacion,
          ubicacionLongitud: state.ubicacionLongitud,
          ubicacionLatitud: state.ubicacionLatitud,
          escolaridadCodigo: state.escolaridadCodigo,
          cantidadHijos: state.cantidadHijos,
          nombrePublico: state.nombrePublico,
          sexoCodigo: state.sexoCodigo,
          paisNacimientoCodigo: state.paisNacimientoCodigo,
          nacionalidadConyugue: state.nacionalidadConyugue,
          ubicacion: state.ubicacion,
          espeps: state.espeps == 'input.yes'.tr(),
          nombreDeEntidadPeps: state.nombreDeEntidadPeps,
          paisPeps: state.paisPeps,
          periodoPeps: state.periodoPeps,
          cargoOficialPeps: state.cargoOficialPeps,
          tieneFamiliarPeps: state.tieneFamiliarPeps == 'input.yes'.tr(),
          nombreFamiliarPeps2: state.nombreFamiliarPeps2,
          parentescoFamiliarPeps2: state.parentescoFamiliarPeps2,
          cargoFamiliarPeps2: state.cargoFamiliarPeps2,
          nombreEntidadPeps2: state.nombreEntidadPeps2,
          periodoPeps2: state.periodoPeps2,
          paisPeps2: state.paisPeps2,
          actividadPredominanteCodigo: state.actividadPredominanteCodigo,
          esFamiliarEmpleado: state.esFamiliarEmpleado == 'input.yes'.tr(),
          nombreFamiliar: state.nombreFamiliar,
          cedulaFamiliar: state.cedulaFamiliar,
          tipoDocumentoCodigo: state.tipoDocumentoCodigo,
          tipoPersonaCodigo: state.tipoPersonaCodigo,
          plazoSolicitud: state.plazoSolicitud,
          fechaPrimerPagoSolicitud:
              DateTime.parse(state.fechaPrimerPagoSolicitud),
          nombreTrabajo: state.nombreTrabajo,
          direccionTrabajo: state.direccionTrabajo,
          barrioTrabajo: state.barrioTrabajo,
          cargo: state.cargo,
          direccionFamiliarCercano: state.direccionFamiliarCercano,
          fuenteOtrosIngresos: state.fuenteOtrosIngresos,
          fuenteOtrosIngresosConyugue: state.fuenteOtrosIngresosConyugue,
          lugarTrabajoAnterior: state.lugarTrabajoAnterior,
          nombreFamiliarCercano: state.nombreFamiliarCercano,
          parentescoFamiliarCercanoCodigo:
              state.parentescoFamiliarCercanoCodigo,
          otrosIngresosConyugue: state.otrosIngresosConyugue,
          otrosIngresosCordoba: state.otrosIngresosCordoba,
          profesionConyugue: state.profesionConyugue,
          salarioNetoCordoba: state.salarioNetoCordoba,
          sueldoMesConyugue: state.sueldoMesConyugue,
          telefonoFamiliarCercano: state.telefonoFamiliarCercano,
          telefonoTrabajo: state.telefonoTrabajo,
          tiempoLaborar: state.tiempoLaborar,
          tiempoLaborarConyugue: state.tiempoLaborarConyugue,
          totalIngresoMes:
              state.salarioNetoCordoba + state.otrosIngresosCordoba,
          totalIngresoMesConyugue:
              state.sueldoMesConyugue + state.otrosIngresosConyugue,
          rtn: state.rtn,
          codigoUsa: state.codigoUsa,
          tipoPersonaCnbsidCodigo: state.tipoPersonaCnbsidCodigo,
          estatusClienteCodigo: state.estatusClienteCodigo,
          tipoClienteCodigo: state.tipoClienteCodigo,
          actividadEconomicaCiuu1Codigo: state.actividadEconomicaCiuu1Codigo,
          actividadEconomicaCiuu2Codigo: state.actividadEconomicaCiuu2Codigo,
          actividadEconomicaCiuu3Codigo: state.actividadEconomicaCiuu3Codigo,
          nivelAproximadoDeIngresosCodigo:
              state.nivelAproximadoDeIngresosCodigo,
          ocupacionCodigo: state.ocupacionCodigo,
          profesionCodigo: state.profesionCodigo,
          actividadEconomicaDescripcion1: state.actividadEconomicaDescripcion1,
          actividadEconomicaDescripcion2: state.actividadEconomicaDescripcion2,
          actividadEconomicaDescripcion3: state.actividadEconomicaDescripcion3,
          ejerceApnfd: state.ejerceApnfd == 'input.yes'.tr(),
          esApnfd: state.esApnfd == 'input.yes'.tr(),
          paisDestinoCodigo: state.paisDestinoCodigo,
          departamentoDestinoCodigo: state.departamentoDestinoCodigo,
          municipioDestinoId: state.municipioDestinoId,
          aldeaDestinoCodigo: state.aldeaDestinoCodigo,
          caserioDestino: state.caserioDestino,
          barrioDestino: state.barrioDestino,
          caseriCasa: state.caseriCasa,
          aldeaCodigo: state.aldeaCodigo,
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
      emit(state.copyWith(
        status: Status.done,
        numeroSolicitud: numeroSolicitud,
        idSolicitud: idSolicitud,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }

  sendCedulaImages({required String numeroSolicitud}) async {
    log('Enviando imagen de la cédula');
    try {
      await _repository.sendCedulaImageWhenSolicitudCreditoCreated(
        numeroSolicitud: int.parse(numeroSolicitud),
        cedulaCliente: state.cedula,
        imagenFrontal: state.imagenFrontal,
        imagenTrasera: state.imagenTrasera,
      );
    } catch (_) {}
  }

  setClientSignatureStatus({required ClientSignatureStatus status}) {
    emit(
      state.copyWith(
        clientSignatureStatus: status,
      ),
    );
  }

  Future<void> sendClientSignatureWhenSolicitudCreditoCreated({
    required String numeroSolicitud,
    required String tipoSolicitud,
    required String firmaCliente,
    required String documentoCliente,
    required ClientSignatureStatus clientSignatureStatus,
  }) async {
    try {
      await _repository.sendClientSignatureWhenSolicitudCreditoCreated(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
        firmaCliente: firmaCliente,
        documentoCliente: documentoCliente,
        clientSignatureStatus: clientSignatureStatus,
      );
    } catch (_) {}
  }

  saveCedula({String? imagenFrontal, String? imagenTrasera}) {
    emit(state.copyWith(
      imagenFrontal: imagenFrontal,
      imagenTrasera: imagenTrasera,
    ));
  }

  void initAutoSave({String? uuid}) {
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid));

    autoSaveHelper = AutoSaveSolicitudAsalariadoHN(
      box: localDbProvider.solicitudesAsalariadoBox,
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

  SolicitudAsalariadoHnDbLocal _buildModel(
    SolicitudAsalariadoHnDbLocal? existing,
  ) {
    final prev = existing;

    return SolicitudAsalariadoHnDbLocal(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      database: _prefer(state.database, prev?.database),
      isOffline: prev?.isOffline ?? false,
      origenSolicitudCodigo:
          _prefer(state.origenSolicitudCodigo, prev?.origenSolicitudCodigo),
      nombre1: _prefer(state.nombre1, prev?.nombre1),
      nombre2: _prefer(state.nombre2, prev?.nombre2),
      apellido1: _prefer(state.apellido1, prev?.apellido1),
      apellido2: _prefer(state.apellido2, prev?.apellido2),
      cedula: _prefer(state.cedula, prev?.cedula),
      paisEmisorCedulaCodigo:
          _prefer(state.paisEmisorCedulaCodigo, prev?.paisEmisorCedulaCodigo),
      fechaEmisionCedula: state.fechaEmisionCedula.isEmpty
          ? prev?.fechaEmisionCedula
          : DateTime.tryParse(state.fechaEmisionCedula),
      actividadEconomicaCiuu1Codigo: _prefer(
        state.actividadEconomicaCiuu1Codigo,
        prev?.actividadEconomicaCiuu1Codigo,
      ),
      actividadEconomicaCiuu2Codigo: _prefer(
        state.actividadEconomicaCiuu2Codigo,
        prev?.actividadEconomicaCiuu2Codigo,
      ),
      actividadEconomicaCiuu3Codigo: _prefer(
        state.actividadEconomicaCiuu3Codigo,
        prev?.actividadEconomicaCiuu3Codigo,
      ),
      nivelAproximadoDeIngresosCodigo: _prefer(
        state.nivelAproximadoDeIngresosCodigo,
        prev?.nivelAproximadoDeIngresosCodigo,
      ),
      ocupacionCodigo: _prefer(state.ocupacionCodigo, prev?.ocupacionCodigo),
      profesionCodigo: _prefer(state.profesionCodigo, prev?.profesionCodigo),
      actividadEconomicaDescripcion1: _prefer(
        state.actividadEconomicaDescripcion1,
        prev?.actividadEconomicaDescripcion1,
      ),
      actividadEconomicaDescripcion2: _prefer(
        state.actividadEconomicaDescripcion2,
        prev?.actividadEconomicaDescripcion2,
      ),
      actividadEconomicaDescripcion3: _prefer(
        state.actividadEconomicaDescripcion3,
        prev?.actividadEconomicaDescripcion3,
      ),
      ejerceApnfd: _prefer(state.ejerceApnfd, prev?.ejerceApnfd),
      esApnfd: _prefer(state.esApnfd, prev?.esApnfd),
      paisDestinoCodigo:
          _prefer(state.paisDestinoCodigo, prev?.paisDestinoCodigo),
      departamentoDestinoCodigo: _prefer(
          state.departamentoDestinoCodigo, prev?.departamentoDestinoCodigo),
      municipioDestinoId:
          _prefer(state.municipioDestinoId, prev?.municipioDestinoId),
      aldeaDestinoCodigo:
          _prefer(state.aldeaDestinoCodigo, prev?.aldeaDestinoCodigo),
      caserioDestino: _prefer(state.caserioDestino, prev?.caserioDestino),
      barrioDestino: _prefer(state.barrioDestino, prev?.barrioDestino),
      caseriCasa: _prefer(state.caseriCasa, prev?.caseriCasa),
      aldeaCodigo: _prefer(state.aldeaCodigo, prev?.aldeaCodigo),
      actividadPredominanteCodigo: _prefer(
        state.actividadPredominanteCodigo,
        prev?.actividadPredominanteCodigo,
      ),
      anosResidirCasa: state.anosResidirCasa == 0
          ? (prev?.anosResidirCasa ?? 0)
          : state.anosResidirCasa,
      estadoCivilCodigo:
          _prefer(state.estadoCivilCodigo, prev?.estadoCivilCodigo),
      nombreConyugue: _prefer(state.nombreConyugue, prev?.nombreConyugue),
      trabajaConyugue: _prefer(state.trabajaConyugue, prev?.trabajaConyugue),
      trabajoConyugue: _prefer(state.trabajoConyugue, prev?.trabajoConyugue),
      direccionTrabajoConyugue: _prefer(
          state.direccionTrabajoConyugue, prev?.direccionTrabajoConyugue),
      telefonoTrabajoConyugue:
          _prefer(state.telefonoTrabajoConyugue, prev?.telefonoTrabajoConyugue),
      productoCodigo: _prefer(state.productoCodigo, prev?.productoCodigo),
      observacion: _prefer(state.observacion, prev?.observacion),
      ubicacionLongitud:
          _prefer(state.ubicacionLongitud, prev?.ubicacionLongitud),
      ubicacionLatitud: _prefer(state.ubicacionLatitud, prev?.ubicacionLatitud),
      escolaridadCodigo:
          _prefer(state.escolaridadCodigo, prev?.escolaridadCodigo),
      cantidadHijos: state.cantidadHijos == 0
          ? (prev?.cantidadHijos ?? 0)
          : state.cantidadHijos,
      nombrePublico: _prefer(state.nombrePublico, prev?.nombrePublico),
      sexoCodigo: _prefer(state.sexoCodigo, prev?.sexoCodigo),
      paisNacimientoCodigo:
          _prefer(state.paisNacimientoCodigo, prev?.paisNacimientoCodigo),
      nacionalidadConyugue:
          _prefer(state.nacionalidadConyugue, prev?.nacionalidadConyugue),
      ubicacion: _prefer(state.ubicacion, prev?.ubicacion),
      espeps: _prefer(state.espeps, prev?.espeps),
      nombreDeEntidadPeps:
          _prefer(state.nombreDeEntidadPeps, prev?.nombreDeEntidadPeps),
      paisPeps: _prefer(state.paisPeps, prev?.paisPeps),
      periodoPeps: _prefer(state.periodoPeps, prev?.periodoPeps),
      cargoOficialPeps: _prefer(state.cargoOficialPeps, prev?.cargoOficialPeps),
      tieneFamiliarPeps:
          _prefer(state.tieneFamiliarPeps, prev?.tieneFamiliarPeps),
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
      esFamiliarEmpleado:
          _prefer(state.esFamiliarEmpleado, prev?.esFamiliarEmpleado),
      nombreFamiliar: _prefer(state.nombreFamiliar, prev?.nombreFamiliar),
      cedulaFamiliar: _prefer(state.cedulaFamiliar, prev?.cedulaFamiliar),
      tipoDocumentoCodigo:
          _prefer(state.tipoDocumentoCodigo, prev?.tipoDocumentoCodigo),
      tipoPersonaCodigo:
          _prefer(state.tipoPersonaCodigo, prev?.tipoPersonaCodigo),
      plazoSolicitud: state.plazoSolicitud == 0
          ? (prev?.plazoSolicitud ?? 0)
          : state.plazoSolicitud,
      fechaPrimerPagoSolicitud: state.fechaPrimerPagoSolicitud.isEmpty
          ? prev?.fechaPrimerPagoSolicitud
          : DateTime.tryParse(state.fechaPrimerPagoSolicitud),
      nombreTrabajo: _prefer(state.nombreTrabajo, prev?.nombreTrabajo),
      direccionTrabajo: _prefer(state.direccionTrabajo, prev?.direccionTrabajo),
      barrioTrabajo: _prefer(state.barrioTrabajo, prev?.barrioTrabajo),
      cargo: _prefer(state.cargo, prev?.cargo),
      direccionFamiliarCercano: _prefer(
          state.direccionFamiliarCercano, prev?.direccionFamiliarCercano),
      fuenteOtrosIngresos:
          _prefer(state.fuenteOtrosIngresos, prev?.fuenteOtrosIngresos),
      fuenteOtrosIngresosConyugue: _prefer(
          state.fuenteOtrosIngresosConyugue, prev?.fuenteOtrosIngresosConyugue),
      lugarTrabajoAnterior:
          _prefer(state.lugarTrabajoAnterior, prev?.lugarTrabajoAnterior),
      nombreFamiliarCercano:
          _prefer(state.nombreFamiliarCercano, prev?.nombreFamiliarCercano),
      parentescoFamiliarCercanoCodigo: _prefer(
          state.parentescoFamiliarCercanoCodigo,
          prev?.parentescoFamiliarCercanoCodigo),
      otrosIngresosConyugue: state.otrosIngresosConyugue == 0
          ? (prev?.otrosIngresosConyugue ?? 0)
          : state.otrosIngresosConyugue,
      otrosIngresosCordoba: state.otrosIngresosCordoba == 0
          ? (prev?.otrosIngresosCordoba ?? 0)
          : state.otrosIngresosCordoba,
      profesionConyugue:
          _prefer(state.profesionConyugue, prev?.profesionConyugue),
      salarioNetoCordoba: state.salarioNetoCordoba == 0
          ? (prev?.salarioNetoCordoba ?? 0)
          : state.salarioNetoCordoba,
      sueldoMesConyugue: state.sueldoMesConyugue == 0
          ? prev?.sueldoMesConyugue ?? 0
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
      rtn: _prefer(state.rtn, prev?.rtn),
      codigoUsa: _prefer(state.codigoUsa, prev?.codigoUsa),
      tipoPersonaCnbsidCodigo: _prefer(
        state.tipoPersonaCnbsidCodigo,
        prev?.tipoPersonaCnbsidCodigo,
      ),
      estatusClienteCodigo: _prefer(
        state.estatusClienteCodigo,
        prev?.estatusClienteCodigo,
      ),
      tipoClienteCodigo:
          _prefer(state.tipoClienteCodigo, prev?.tipoClienteCodigo),
      barrioCasa: _prefer(state.barrioCasa, prev?.barrioCasa),
      paisCasaCodigo: _prefer(state.paisCasaCodigo, prev?.paisCasaCodigo),
      departamentoCasaCodigo:
          _prefer(state.departamentoCasaCodigo, prev?.departamentoCasaCodigo),
      celular: _prefer(state.celular, prev?.celular),
      direccionCasa: _prefer(state.direccionCasa, prev?.direccionCasa),
      municipioCasaCodigo:
          _prefer(state.municipioCasaCodigo, prev?.municipioCasaCodigo),
      condicionCasaCodigo:
          _prefer(state.condicionCasaCodigo, prev?.condicionCasaCodigo),
      email: _prefer(state.email, prev?.email),
      monto: state.monto == 0 ? (prev?.monto ?? 0) : state.monto,
      cuota: state.cuota == 0 ? prev?.cuota : state.cuota,
      cuotaWithDecimal: state.cuotaWithDecimal == 0
          ? prev?.cuotaWithDecimal ?? 0
          : state.cuotaWithDecimal,
      sectorCodigo: _prefer(state.sectorCodigo, prev?.sectorCodigo),
      personasACargo: state.personasACargo == 0
          ? (prev?.personasACargo ?? 0)
          : state.personasACargo,
      fechaNacimiento: state.fechaNacimiento.isEmpty
          ? prev?.fechaNacimiento
          : DateTime.tryParse(state.fechaNacimiento),
      fechaVencimientoCedula: state.fechaVencimientoCedula.isEmpty
          ? prev?.fechaVencimientoCedula
          : DateTime.tryParse(state.fechaVencimientoCedula),
      frecuenciaCodigo: _prefer(state.frecuenciaCodigo, prev?.frecuenciaCodigo),
      monedaCodigo: _prefer(state.monedaCodigo, prev?.monedaCodigo),
      nacinalidad: _prefer(state.nacinalidad, prev?.nacinalidad),
      propositoCodigo: _prefer(state.propositoCodigo, prev?.propositoCodigo),
      telefono: _prefer(state.telefono, prev?.telefono),
      descripcionDestino:
          _prefer(state.descripcionDestino, prev?.descripcionDestino),
      tieneVinculosUsa: _prefer(state.tieneVinculosUsa, prev?.tieneVinculosUsa),
      isDone: state.isDone,
      fechaDesembolso: state.fechaDesembolso.isEmpty
          ? prev?.fechaDesembolso
          : DateTime.tryParse(state.fechaDesembolso),
      frecuenciaMeses: _prefer(state.frecuenciaMeses, prev?.frecuenciaMeses),
      tasaInteres:
          state.tasaInteres == 0 ? (prev?.tasaInteres ?? 0) : state.tasaInteres,
      cedulaConyuge: _prefer(state.cedulaConyuge, prev?.cedulaConyuge),
      tipoDocumentoConyugeCodigo: _prefer(
        state.tipoDocumentoConyugeCodigo,
        prev?.tipoDocumentoConyugeCodigo,
      ),
    );
  }

  void onFieldChanged(SolicitudAslariadoHnState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';

  loadFromLocalDb(SolicitudAsalariadoHnDbLocal solicitud) {
    onFieldChanged(
      () => state.copyWith(
        cuotaWithDecimal: solicitud.cuotaWithDecimal,
        fechaVencimientoCedula:
            solicitud.fechaVencimientoCedula?.toUtc().toIso8601String(),
        fechaEmisionCedula:
            solicitud.fechaEmisionCedula?.toUtc().toIso8601String(),
        fechaNacimiento: solicitud.fechaNacimiento?.toUtc().toIso8601String(),
        tipoPersonaCnbsidCodigo: solicitud.tipoPersonaCnbsidCodigo,
        nombre1: solicitud.nombre1,
        nombre2: solicitud.nombre2,
        apellido1: solicitud.apellido1,
        apellido2: solicitud.apellido2,
        sexoCodigo: solicitud.sexoCodigo,
        paisNacimientoCodigo: solicitud.paisNacimientoCodigo,
        tipoDocumentoCodigo: solicitud.tipoDocumentoCodigo,
        tipoPersonaCodigo: solicitud.tipoPersonaCodigo,
        cedula: solicitud.cedula,
        rtn: solicitud.rtn,
        nacinalidad: solicitud.nacinalidad,
        escolaridadCodigo: solicitud.escolaridadCodigo,
        paisEmisorCedulaCodigo: solicitud.paisEmisorCedulaCodigo,
        telefono: solicitud.telefono,
        celular: solicitud.celular,
        email: solicitud.email,
        cantidadHijos: solicitud.cantidadHijos,
        tieneVinculosUsa: solicitud.tieneVinculosUsa,
        codigoUsa: solicitud.codigoUsa,
        ubicacion: solicitud.ubicacion,
        paisCasaCodigo: solicitud.paisCasaCodigo,
        departamentoCasaCodigo: solicitud.departamentoCasaCodigo,
        municipioCasaCodigo: solicitud.municipioCasaCodigo,
        aldeaCodigo: solicitud.aldeaCodigo,
        caseriCasa: solicitud.caseriCasa,
        direccionCasa: solicitud.direccionCasa,
        barrioCasa: solicitud.barrioCasa,
        condicionCasaCodigo: solicitud.condicionCasaCodigo,
        anosResidirCasa: solicitud.anosResidirCasa,
        profesionCodigo: solicitud.profesionCodigo,
        ocupacionCodigo: solicitud.ocupacionCodigo,
        cargo: solicitud.cargo,
        nombreTrabajo: solicitud.nombreTrabajo,
        direccionTrabajo: solicitud.direccionTrabajo,
        barrioTrabajo: solicitud.barrioTrabajo,
        telefonoTrabajo: solicitud.telefonoTrabajo,
        tiempoLaborar: solicitud.tiempoLaborar,
        lugarTrabajoAnterior: solicitud.lugarTrabajoAnterior,
        salarioNetoCordoba: solicitud.salarioNetoCordoba,
        totalIngresoMes: solicitud.totalIngresoMes,
        otrosIngresosCordoba: solicitud.otrosIngresosCordoba,
        fuenteOtrosIngresos: solicitud.fuenteOtrosIngresos,
        espeps: solicitud.espeps,
        nombreDeEntidadPeps: solicitud.nombreDeEntidadPeps,
        periodoPeps: solicitud.periodoPeps,
        cargoOficialPeps: solicitud.cargoOficialPeps,
        paisPeps: solicitud.paisPeps,
        tieneFamiliarPeps: solicitud.tieneFamiliarPeps,
        nombreFamiliarPeps2: solicitud.nombreFamiliarPeps2,
        parentescoFamiliarPeps2: solicitud.parentescoFamiliarPeps2,
        cargoFamiliarPeps2: solicitud.cargoFamiliarPeps2,
        nombreEntidadPeps2: solicitud.nombreEntidadPeps2,
        periodoPeps2: solicitud.periodoPeps2,
        paisPeps2: solicitud.paisPeps2,
        nombreFamiliar: solicitud.nombreFamiliar,
        cedulaFamiliar: solicitud.cedulaFamiliar,
        esFamiliarEmpleado: solicitud.esFamiliarEmpleado,
        estadoCivilCodigo: solicitud.estadoCivilCodigo,
        nombreConyugue: solicitud.nombreConyugue,
        profesionConyugue: solicitud.profesionConyugue,
        trabajaConyugue: solicitud.trabajaConyugue,
        trabajoConyugue: solicitud.trabajoConyugue,
        direccionTrabajoConyugue: solicitud.direccionTrabajoConyugue,
        telefonoTrabajoConyugue: solicitud.telefonoTrabajoConyugue,
        tiempoLaborarConyugue: solicitud.tiempoLaborarConyugue,
        sueldoMesConyugue: solicitud.sueldoMesConyugue,
        otrosIngresosConyugue: solicitud.otrosIngresosConyugue,
        fuenteOtrosIngresosConyugue: solicitud.fuenteOtrosIngresosConyugue,
        nacionalidadConyugue: solicitud.nacionalidadConyugue,
        personasACargo: solicitud.personasACargo,
        nombreFamiliarCercano: solicitud.nombreFamiliarCercano,
        direccionFamiliarCercano: solicitud.direccionFamiliarCercano,
        telefonoFamiliarCercano: solicitud.telefonoFamiliarCercano,
        paisDestinoCodigo: solicitud.paisDestinoCodigo,
        departamentoDestinoCodigo: solicitud.departamentoDestinoCodigo,
        municipioDestinoId: solicitud.municipioDestinoId,
        aldeaDestinoCodigo: solicitud.aldeaDestinoCodigo,
        caserioDestino: solicitud.caserioDestino,
        barrioDestino: solicitud.barrioDestino,
        actividadEconomicaCiuu1Codigo: solicitud.actividadEconomicaCiuu1Codigo,
        actividadEconomicaDescripcion1:
            solicitud.actividadEconomicaDescripcion1,
        actividadEconomicaCiuu2Codigo: solicitud.actividadEconomicaCiuu2Codigo,
        actividadEconomicaDescripcion2:
            solicitud.actividadEconomicaDescripcion2,
        actividadEconomicaCiuu3Codigo: solicitud.actividadEconomicaCiuu3Codigo,
        actividadEconomicaDescripcion3:
            solicitud.actividadEconomicaDescripcion3,
        ejerceApnfd: solicitud.ejerceApnfd,
        esApnfd: solicitud.esApnfd,
        fechaDesembolso: solicitud.fechaDesembolso?.toUtc().toIso8601String(),
        tasaInteres: solicitud.tasaInteres,
        frecuenciaMeses: solicitud.frecuenciaMeses,
        cuota: solicitud.cuota,
        sectorCodigo: solicitud.sectorCodigo,
        productoCodigo: solicitud.productoCodigo,
        monedaCodigo: solicitud.monedaCodigo,
        propositoCodigo: solicitud.propositoCodigo,
        descripcionDestino: solicitud.descripcionDestino,
        monto: solicitud.monto,
        frecuenciaCodigo: solicitud.frecuenciaCodigo,
        plazoSolicitud: solicitud.plazoSolicitud,
        fechaPrimerPagoSolicitud:
            solicitud.fechaPrimerPagoSolicitud?.toUtc().toIso8601String(),
        observacion: solicitud.observacion,
        totalIngresoMesConyugue: solicitud.totalIngresoMesConyugue,
        actividadPredominanteCodigo: solicitud.actividadPredominanteCodigo,
        nombrePublico: solicitud.nombrePublico,
        parentescoFamiliarCercanoCodigo:
            solicitud.parentescoFamiliarCercanoCodigo,
        tipoClienteCodigo: solicitud.tipoClienteCodigo,
        cedulaConyuge: solicitud.cedulaConyuge,
        tipoDocumentoConyugeCodigo: solicitud.tipoDocumentoConyugeCodigo,
      ),
    );
  }

  void saveHistorialCredito({
    required HistorialCredito historialCredito,
  }) {
    emit(
      state.copyWith(
        historialCredito: [
          ...state.historialCredito,
          historialCredito,
        ],
      ),
    );
  }

  void saveHistorialesCreditoOnState({
    required List<HistorialCredito> historialCredito,
  }) {
    emit(
      state.copyWith(
        historialCredito: historialCredito,
      ),
    );
  }

  void updateHistorialCredito({required HistorialCredito updated}) {
    emit(
      state.copyWith(
        historialCredito: state.historialCredito.map((item) {
          return item.uuid == updated.uuid ? updated : item;
        }).toList(),
      ),
    );
  }

  void deleteHistorialCredito({required String uuid}) {
    emit(
      state.copyWith(
        historialCredito:
            state.historialCredito.where((item) => item.uuid != uuid).toList(),
      ),
    );
  }
}
