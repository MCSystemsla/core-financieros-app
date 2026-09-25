import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/asalariado/solicitud_asalariado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/represtamo/solicitud_represtamo.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'enviar_solicitud_when_isdone_state.dart';

typedef OnSolicitudCreditoIsKivaFn = Future<bool> Function({
  required String uuid,
  required String numeroSolicitud,
  required String solicitudId,
  required String tipoProducto,
  required String nombreFomularioKiva,
  required String cedula,
  required int tipoSolicitudId,
  required String nombreCliente,
});

class EnviarSolicitudWhenIsdoneCubit
    extends Cubit<EnviarSolicitudWhenIsdoneState> {
  final ObjectBoxService objectBoxService;
  final SolicitudesCreditoRepository repository;
  EnviarSolicitudWhenIsdoneCubit(this.objectBoxService, this.repository)
      : super(EnviarSolicitudWhenIsdoneInitial());
  final _logger = Logger();

  /// Evita dos sincronizaciones simultáneas (p. ej. dos instancias de la
  /// pantalla de solicitudes), que crearían solicitudes duplicadas en el
  /// servidor al leer los mismos registros con hasVerified == false.
  static bool _isSyncing = false;

  void _safeEmit(EnviarSolicitudWhenIsdoneState state) {
    if (!isClosed) emit(state);
  }

  void sendSolicitudWhenIsDone({
    required bool isConnected,
    required OnSolicitudCreditoIsKivaFn onSolicitudCreditoIsKivaFn,
  }) async {
    if (_isSyncing) {
      _safeEmit(EnviarSolicitudWhenIsdoneInitial());
      return;
    }

    List<String> errors = [];
    List<String> solicitudesSent = [];
    List<String> unSentCedulas = [];
    List<String> unSentKivaForms = [];

    bool hasAnySent = false;

    _isSyncing = true;
    _safeEmit(OnEnviarSolicitudWhenIsdoneLoading());

    try {
      final solicitudes = objectBoxService.sendSolicitudesWhenIsDone();
      if (solicitudes.isEmpty || !isConnected) {
        _safeEmit(EnviarSolicitudWhenIsdoneInitial());
        return;
      }
      for (var solicitud in solicitudes) {
        final data = _extractSyncData(solicitud);

        (bool, String, String?, String?, int?) result;
        try {
          result = await _sendSolicitud(solicitud: solicitud);
        } catch (e, stackTrace) {
          // No sabemos si el servidor la creó: no se marca, se reintenta en
          // la próxima sincronización.
          _logger.e('Error creando solicitud ${data.cedula}',
              error: e, stackTrace: stackTrace);
          errors.add('Solicitud con cedula ${data.cedula}: $e');
          continue;
        }

        if (!result.$1) {
          objectBoxService.updateWhenSolicitdIsFailed(
            solicitud: solicitud,
            errorMsg: result.$2,
          );
          errors.add('Solicitud con cedula ${data.cedula}: ${result.$2}');
          continue;
        }

        // La solicitud ya existe en el servidor: marcarla antes de cualquier
        // paso posterior para que un fallo en cédulas/Kiva no provoque que se
        // vuelva a crear en la próxima sincronización.
        objectBoxService.updateWhenSolicitdIsDone(solicitud: solicitud);
        hasAnySent = true;
        solicitudesSent
            .add('Solicitud de credito creada con cedula ${data.cedula}');

        try {
          final cedulaError = await _sendCedulaImages(
            cedula: data.cedula,
            tipoSolicitud: data.tipoSolicitud,
            numeroSolicitud: result.$3,
          );
          if (cedulaError != null) unSentCedulas.add(cedulaError);
        } catch (e, stackTrace) {
          _logger.e('Error enviando cédula ${data.cedula}',
              error: e, stackTrace: stackTrace);
          unSentCedulas.add(
            'Error al enviar la imagen de la cédula ${data.cedula} al expediente digital.',
          );
        }

        final nombreFormularioKiva = data.nombreFormularioKiva ?? '';
        if (nombreFormularioKiva.isEmpty) continue;

        try {
          final isKivFormIsOk = await onSolicitudCreditoIsKivaFn(
            solicitudId: result.$4 ?? '0',
            numeroSolicitud: result.$3 ?? '0',
            uuid: data.uuid ?? '',
            tipoProducto: nombreFormularioKiva,
            nombreFomularioKiva: nombreFormularioKiva,
            cedula: data.cedula ?? '',
            tipoSolicitudId: result.$5 ?? 0,
            nombreCliente: data.nombreCliente,
          );
          if (!isKivFormIsOk) {
            unSentKivaForms.add(
              'Error al enviar formulario Kiva: ${data.objProductoIdVer}',
            );
          } else {
            solicitudesSent.add(
              'Historia Kiva de Cedula a sido creada: ${data.cedula} ${data.objProductoIdVer}',
            );
          }
        } catch (e, stackTrace) {
          _logger.e('Error enviando formulario Kiva ${data.cedula}',
              error: e, stackTrace: stackTrace);
          unSentKivaForms.add(
            'Error al enviar formulario Kiva: ${data.objProductoIdVer}',
          );
        }
      }
      if (hasAnySent &&
          errors.isEmpty &&
          unSentCedulas.isEmpty &&
          unSentKivaForms.isEmpty) {
        _safeEmit(
          OnEnviarSolicitudWhenIsdoneSuccess(
            unsentCedulas: unSentCedulas,
            solicitudesSent: solicitudesSent,
          ),
        );
      } else {
        _safeEmit(
          OnEnviarSolicitudWhenIsdonePendingVerification(
            unsentCedulas: unSentCedulas,
            solicitudesSent: solicitudesSent,
            unsentKivaForms: unSentKivaForms,
            errors: errors,
            msgError:
                'Algunas solicitudes tienen errores y no se pudieron procesar.',
          ),
        );
      }
    } catch (e, stackTrace) {
      _logger.e('Error crítico sincronizando solicitudes offline',
          error: e, stackTrace: stackTrace);
      _safeEmit(OnEnviarSolicitudWhenIsdoneError(msgError: e.toString()));
    } finally {
      _isSyncing = false;
    }
  }

  void resetState() {
    _safeEmit(EnviarSolicitudWhenIsdoneInitial());
  }

  /// Devuelve el mensaje de error si la cédula no se pudo enviar, o null.
  Future<String?> _sendCedulaImages({
    required String? cedula,
    required String tipoSolicitud,
    required String? numeroSolicitud,
  }) async {
    if (cedula == null || cedula.isEmpty) return null;
    final cedulaCliente = objectBoxService.getCedula(
      cedula: cedula,
      tipoSolicitud: tipoSolicitud,
    );
    if (cedulaCliente == null) return null;

    final frontal = cedulaCliente.imageFrontCedula;
    final trasera = cedulaCliente.imageBackCedula;
    if (frontal == null || trasera == null) {
      return 'La cédula $cedula no tiene ambas imágenes guardadas.';
    }

    final (isSent, _) =
        await repository.sendCedulaImageWhenSolicitudCreditoCreated(
      numeroSolicitud: int.tryParse(numeroSolicitud ?? '0') ?? 0,
      cedulaCliente: cedula,
      imagenFrontal: frontal,
      imagenTrasera: trasera,
    );
    return isSent
        ? null
        : 'Error al enviar la imagen de la cédula $cedula al expediente digital.';
  }

  ({
    String? cedula,
    String? uuid,
    String? nombreFormularioKiva,
    String? objProductoIdVer,
    String nombreCliente,
    String tipoSolicitud,
  }) _extractSyncData(dynamic solicitud) {
    return switch (solicitud) {
      ResponseLocalDb() => (
          cedula: solicitud.cedula,
          uuid: solicitud.uuid,
          nombreFormularioKiva: solicitud.nombreFormularioKiva,
          objProductoIdVer: solicitud.objProductoIdVer,
          nombreCliente:
              '${solicitud.nombre1} ${solicitud.nombre2} ${solicitud.apellido1} ${solicitud.apellido2}*',
          tipoSolicitud: 'NUEVA_MENOR',
        ),
      ReprestamoResponsesLocalDb() => (
          cedula: solicitud.cedula,
          uuid: solicitud.uuid,
          nombreFormularioKiva: solicitud.nombreFormularioKiva,
          objProductoIdVer: solicitud.objProductoIdVer,
          nombreCliente: '${solicitud.nombreCompletoCliente}*',
          tipoSolicitud: 'REPRESTAMO',
        ),
      AsalariadoResponsesLocalDb() => (
          cedula: solicitud.cedula,
          uuid: solicitud.uuid,
          nombreFormularioKiva: solicitud.nombreFormularioKiva,
          objProductoIdVer: solicitud.objProductoIdVer,
          nombreCliente:
              '${solicitud.nombre1} ${solicitud.nombre2} ${solicitud.apellido1} ${solicitud.apellido2}*',
          tipoSolicitud: 'ASALARIADO',
        ),
      _ => throw UnsupportedError(
          'Solicitud de tipo ${solicitud.runtimeType} no soportada en el envío automático.',
        ),
    };
  }

  Future<(bool, String, String?, String?, int?)> _sendSolicitud({
    required dynamic solicitud,
  }) async {
    return switch (solicitud) {
      ResponseLocalDb() => await repository.createSolicitudCreditoNuevaMenor(
          solicitudNuevaMenor: _mapToSolicitudNuevaMenor(solicitud),
        ),
      ReprestamoResponsesLocalDb() =>
        await repository.createSolicitudReprestamo(
          solicitudReprestamo: _mapToSolicitudReprestamo(solicitud),
        ),
      AsalariadoResponsesLocalDb() =>
        await repository.createSolicitudAsalariado(
          solicitudAsalariado: _mapToSolicitudAsalariado(solicitud),
        ),
      _ => throw UnsupportedError(
          'Error en envio Solicitud de tipo ${solicitud.runtimeType} no soportado en el envío automático.',
        )
    };
  }

  SolicitudNuevaMenor _mapToSolicitudNuevaMenor(ResponseLocalDb solicitud) {
    return SolicitudNuevaMenor(
      isOffline: solicitud.isDone,
      objOrigenSolicitudId: solicitud.objOrigenSolicitudId ?? '',
      nombre1: solicitud.nombre1 ?? '',
      nombre2: solicitud.nombre2 ?? '',
      apellido1: solicitud.apellido1 ?? '',
      apellido2: solicitud.apellido2 ?? '',
      cedula: solicitud.cedula ?? '',
      objPaisEmisorCedula: solicitud.objPaisEmisorCedula ?? '',
      fechaEmisionCedula: solicitud.fechaEmisionCedula ?? '',
      fechaVencimientoCedula: solicitud.fechaVencimientoCedula ?? '',
      fechaNacimiento: solicitud.fechaNacimiento ?? '',
      telefono: solicitud.telefono ?? '',
      celular: solicitud.celular ?? '',
      direccionCasa: solicitud.direccionCasa ?? '',
      barrioCasa: solicitud.barrioCasa ?? '',
      objMunicipioCasaId: solicitud.objMunicipioCasaId ?? '',
      objDepartamentoCasaId: solicitud.objDepartamentoCasaId ?? '',
      objPaisCasaId: solicitud.objPaisCasaId ?? '',
      profesion: solicitud.profesion ?? '',
      ocupacion: solicitud.ocupacion ?? '',
      nacionalidad: solicitud.nacionalidad ?? '',
      objCondicionCasaId: solicitud.objCondicionCasaId ?? '',
      anosResidirCasa: solicitud.anosResidirCasa ?? 0,
      email: solicitud.email ?? '',
      monto: solicitud.monto ?? 0,
      objMonedaId: solicitud.objMonedaId ?? '',
      objPropositoId: solicitud.objPropositoId ?? '',
      objFrecuenciaId: solicitud.objFrecuenciaId ?? '',
      cuota: solicitud.cuota ?? 0,
      objActividadId: solicitud.objActividadId ?? '',
      objActividadId1: solicitud.objActividadId1 ?? '',
      objActividadId2: solicitud.objActividadId2 ?? '',
      objSectorId: solicitud.objSectorId ?? '',
      nombreNegocio: solicitud.nombreNegocio ?? '',
      tiempoFuncionamientoNegocio: solicitud.tiempoFuncionamientoNegocio ?? '',
      direccionNegocio: solicitud.direccionNegocio ?? '',
      barrioNegocio: solicitud.barrioNegocio ?? '',
      objMunicipioNegocioId: solicitud.objMunicipioNegocioId ?? '',
      objCondicionNegocioId: solicitud.objCondicionNegocioId ?? '',
      horarioTrabajo: solicitud.horarioTrabajo ?? '',
      horarioVisita: solicitud.horarioVisita ?? '',
      personasACargo: solicitud.personasACargo ?? 0,
      objEstadoCivilId: solicitud.objEstadoCivilId ?? '',
      nombreConyugue: solicitud.nombreConyugue ?? '',
      trabajaConyugue: solicitud.trabajaConyugue ?? false,
      trabajoConyugue: solicitud.trabajoConyugue ?? '',
      direccionTrabajoConyugue: solicitud.direccionTrabajoConyugue ?? '',
      telefonoTrabajoConyugue: solicitud.telefonoTrabajoConyugue ?? '',
      beneficiarioSeguro: solicitud.beneficiarioSeguro ?? '',
      cedulaBeneficiarioSeguro: solicitud.cedulaBeneficiarioSeguro ?? '',
      objParentescoBeneficiarioSeguroId:
          solicitud.objParentescoBeneficiarioSeguroId ?? '',
      beneficiarioSeguro1: solicitud.beneficiarioSeguro1 ?? '',
      cedulaBeneficiarioSeguro1: solicitud.cedulaBeneficiarioSeguro1 ?? '',
      objParentescoBeneficiarioSeguroId1:
          solicitud.objParentescoBeneficiarioSeguroId1 ?? '',
      objEstadoSolicitudId: solicitud.objEstadoSolicitudId ?? '',
      objOficialCreditoId: solicitud.objOficialCreditoId ?? '',
      objProductoId: solicitud.objProductoId ?? '',
      observacion: solicitud.observacion ?? '',
      sucursal: solicitud.sucursal ?? '',
      ubicacionLongitud: solicitud.ubicacionLongitud ?? '',
      ubicacionLatitud: solicitud.ubicacionLatitud ?? '',
      ubicacionGradosLongitud: solicitud.ubicacionGradosLongitud ?? '',
      ubicacionGradosLatitud: solicitud.ubicacionGradosLatitud ?? '',
      objEscolaridadId: solicitud.objEscolaridadId ?? '',
      cantidadHijos: solicitud.cantidadHijos ?? 0,
      nombrePublico: solicitud.nombrePublico ?? '',
      objSexoId: solicitud.objSexoId ?? '',
      objPaisNacimientoId: solicitud.objPaisNacimientoId ?? '',
      nacionalidadConyugue: solicitud.nacionalidadConyugue ?? '',
      database: solicitud.database ?? '',
      ubicacion: solicitud.ubicacion ?? '',
      espeps: solicitud.espeps == 'input.yes'.tr(),
      nombreDeEntidadPeps: solicitud.nombreDeEntidadPeps ?? '',
      paisPeps: solicitud.paisPeps ?? '',
      periodoPeps: solicitud.periodoPeps ?? '',
      cargoOficialPeps: solicitud.cargoOficialPeps ?? '',
      tieneFamiliarPeps: solicitud.tieneFamiliarPeps == 'input.yes'.tr(),
      nombreFamiliarPeps2: solicitud.nombreFamiliarPeps2 ?? '',
      parentescoFamiliarPeps2: solicitud.parentescoFamiliarPeps2 ?? '',
      cargoFamiliarPeps2: solicitud.cargoFamiliarPeps2 ?? '',
      nombreEntidadPeps2: solicitud.nombreEntidadPeps2 ?? '',
      periodoPeps2: solicitud.periodoPeps2 ?? '',
      paisPeps2: solicitud.paisPeps2 ?? '',
      objRubroActividad: solicitud.objRubroActividad ?? '',
      objActividadPredominante: solicitud.objActividadPredominante ?? '',
      esFamiliarEmpleado: solicitud.esFamiliarEmpleado == 'input.yes'.tr(),
      nombreFamiliar: solicitud.nombreFamiliar ?? '',
      cedulaFamiliar: solicitud.cedulaFamiliar ?? '',
      objTipoDocumentoId: solicitud.objTipoDocumentoId ?? '',
      objRubroActividad2: solicitud.objRubroActividad2 ?? '',
      objRubroActividad3: solicitud.objRubroActividad3 ?? '',
      objRubroActividadPredominante:
          solicitud.objRubroActividadPredominante ?? '',
      tipoPersona: solicitud.tipoPersona ?? '',
      objTipoPersonaId: solicitud.objTipoPersonaId ?? '',
      telefonoBeneficiario: solicitud.telefonoBeneficiario ?? '',
      telefonoBeneficiarioSeguro1: solicitud.telefonoBeneficiarioSeguro1 ?? '',
      plazoSolicitud: solicitud.plazoSolicitud ?? 0,
      fechaPrimerPagoSolicitud: solicitud.fechaPrimerPagoSolicitud ?? '',
      historialCredito: [],
    );
  }

  SolicitudReprestamo _mapToSolicitudReprestamo(
      ReprestamoResponsesLocalDb solicitud) {
    return SolicitudReprestamo(
      isOffline: solicitud.isOffline,
      sucursal: solicitud.sucursal ?? '',
      ubicacion: solicitud.ubicacion ?? '',
      ubicacionLatitud: solicitud.ubicacionLatitud ?? '',
      ubicacionLongitud: solicitud.ubicacionLongitud ?? '',
      objProductoId: solicitud.objProductoId ?? '',
      username: solicitud.username ?? '',
      userIp: solicitud.userIp ?? '',
      database: solicitud.database ?? '',
      objOrigenSolicitudId: solicitud.objOrigenSolicitudId ?? '',
      cedula: solicitud.cedula ?? '',
      monto: solicitud.monto ?? 0,
      objMonedaId: solicitud.objMonedaId ?? '',
      objPropositoId: solicitud.objPropositoId ?? '',
      objFrecuenciaId: solicitud.objFrecuenciaId ?? '',
      cuota: solicitud.cuota ?? 0,
      objActividadId: solicitud.objActividadId ?? '',
      objActividadId1: solicitud.objActividadId1 ?? '',
      objActividadId2: solicitud.objActividadId2 ?? '',
      objSectorId: solicitud.objSectorId ?? '',
      beneficiarioSeguro: solicitud.beneficiarioSeguro ?? '',
      cedulaBeneficiarioSeguro: solicitud.cedulaBeneficiarioSeguro ?? '',
      objParentescoBeneficiarioSeguroId:
          solicitud.objParentescoBeneficiarioSeguroId ?? '',
      observacion: solicitud.observacion ?? '',
      esPeps: solicitud.esPeps ?? false,
      nombreDeEntidadPeps: solicitud.nombreDeEntidadPeps ?? '',
      paisPeps: solicitud.paisPeps ?? '',
      periodoPeps: solicitud.periodoPeps ?? '',
      cargoOficialPeps: solicitud.cargoOficialPeps ?? '',
      tieneFamiliarPeps: solicitud.tieneFamiliarPeps ?? false,
      nombreFamiliarPeps2: solicitud.nombreFamiliarPeps2 ?? '',
      parentescoFamiliarPeps2: solicitud.parentescoFamiliarPeps2 ?? '',
      cargoFamiliarPeps2: solicitud.cargoFamiliarPeps2 ?? '',
      nombreEntidadPeps2: solicitud.nombreEntidadPeps2 ?? '',
      periodoPeps2: solicitud.periodoPeps2 ?? '',
      paisPeps2: solicitud.paisPeps2 ?? '',
      objRubroActividad: solicitud.objRubroActividad ?? '',
      objActividadPredominante: solicitud.objActividadPredominante ?? '',
      objTipoDocumentoId: solicitud.objTipoDocumentoId ?? '',
      objRubroActividad2: solicitud.objRubroActividad2 ?? '',
      objRubroActividad3: solicitud.objRubroActividad3 ?? '',
      objRubroActividadPredominante:
          solicitud.objRubroActividadPredominante ?? '',
      tipoPersona: solicitud.tipoPersona ?? '',
      objTipoPersonaId: solicitud.objTipoPersonaId ?? '',
      telefonoBeneficiario: solicitud.telefonoBeneficiario ?? '',
      esFamiliarEmpleado: solicitud.esFamiliarEmpleado ?? false,
      nombreFamiliar: solicitud.nombreFamiliar ?? '',
      cedulaFamiliar: solicitud.cedulaFamiliar ?? '',
      plazoSolicitud: solicitud.plazoSolicitud ?? 0,
      celularReprestamo: solicitud.celularReprestamo ?? '',
      fechaPrimerPagoSolicitud:
          DateTime.tryParse(solicitud.fechaPrimerPagoSolicitud.toString()),
      historialCredito: [],
    );
  }

  SolicitudAsalariado _mapToSolicitudAsalariado(
    AsalariadoResponsesLocalDb solicitud,
  ) {
    return SolicitudAsalariado(
      isOffline: solicitud.isOffline,
      objOrigenSolicitudId: solicitud.objOrigenSolicitudId ?? '',
      database: solicitud.database ?? '',
      nombre1: solicitud.nombre1 ?? '',
      nombre2: solicitud.nombre2 ?? '',
      apellido1: solicitud.apellido1 ?? '',
      apellido2: solicitud.apellido2 ?? '',
      cedula: solicitud.cedula ?? '',
      objPaisEmisorCedula: solicitud.objPaisEmisorCedula ?? '',
      fechaEmisionCedula: solicitud.fechaEmisionCedula?.toUtc(),
      fechaVencimientoCedula: solicitud.fechaVencimientoCedula?.toUtc(),
      fechaNacimiento: solicitud.fechaNacimiento?.toUtc(),
      telefono: solicitud.telefono ?? '',
      celular: solicitud.celular ?? '',
      direccionCasa: solicitud.direccionCasa ?? '',
      barrioCasa: solicitud.barrioCasa ?? '',
      objMunicipioCasaId: solicitud.objMunicipioCasaId ?? '',
      objDepartamentoCasaId: solicitud.objDepartamentoCasaId ?? '',
      objPaisCasaId: solicitud.objPaisCasaId ?? '',
      profesion: solicitud.profesion ?? '',
      ocupacion: solicitud.ocupacion ?? '',
      nacionalidad: solicitud.nacionalidad ?? '',
      objCondicionCasaId: solicitud.objCondicionCasaId ?? '',
      anosResidirCasa: solicitud.anosResidirCasa ?? 0,
      email: solicitud.email ?? '',
      monto: solicitud.monto ?? 0,
      objMonedaId: solicitud.objMonedaId ?? '',
      objPropositoId: solicitud.objPropositoId ?? '',
      objFrecuenciaId: solicitud.objFrecuenciaId ?? '',
      cuota: solicitud.cuota ?? 0,
      objSectorId: solicitud.objSectorId ?? '',
      personasACargo: solicitud.personasACargo ?? 0,
      objEstadoCivilId: solicitud.objEstadoCivilId ?? '',
      nombreConyugue: solicitud.nombreConyugue ?? '',
      trabajaConyugue: solicitud.trabajaConyugue ?? false,
      trabajoConyugue: solicitud.trabajoConyugue ?? '',
      direccionTrabajoConyugue: solicitud.direccionTrabajoConyugue ?? '',
      telefonoTrabajoConyugue: solicitud.telefonoTrabajoConyugue ?? '',
      beneficiarioSeguro: solicitud.beneficiarioSeguro ?? '',
      cedulaBeneficiarioSeguro: solicitud.cedulaBeneficiarioSeguro ?? '',
      objParentescoBeneficiarioSeguroId:
          solicitud.objParentescoBeneficiarioSeguroId ?? '',
      objEstadoSolicitudId: solicitud.objEstadoSolicitudId ?? '',
      objOficialCreditoId: solicitud.objOficialCreditoId ?? '',
      objProductoId: solicitud.objProductoId ?? '',
      observacion: solicitud.observacion ?? '',
      sucursal: solicitud.sucursal ?? '',
      ubicacionLongitud: solicitud.ubicacionLongitud ?? '',
      ubicacionLatitud: solicitud.ubicacionLatitud ?? '',
      ubicacionGradosLongitud: solicitud.ubicacionGradosLongitud ?? '',
      ubicacionGradosLatitud: solicitud.ubicacionGradosLatitud ?? '',
      objEscolaridadId: solicitud.objEscolaridadId ?? '',
      cantidadHijos: solicitud.cantidadHijos ?? 0,
      nombrePublico: solicitud.nombrePublico ?? '',
      objSexoId: solicitud.objSexoId ?? '',
      objPaisNacimientoId: solicitud.objPaisNacimientoId ?? '',
      nacionalidadConyugue: solicitud.nacionalidadConyugue ?? '',
      ubicacion: solicitud.ubicacion ?? '',
      espeps: solicitud.espeps == 'input.yes'.tr(),
      nombreDeEntidadPeps: solicitud.nombreDeEntidadPeps ?? '',
      paisPeps: solicitud.paisPeps ?? '',
      periodoPeps: solicitud.periodoPeps ?? '',
      cargoOficialPeps: solicitud.cargoOficialPeps ?? '',
      tieneFamiliarPeps: solicitud.tieneFamiliarPeps == 'input.yes'.tr(),
      nombreFamiliarPeps2: solicitud.nombreFamiliarPeps2 ?? '',
      parentescoFamiliarPeps2: solicitud.parentescoFamiliarPeps2 ?? '',
      cargoFamiliarPeps2: solicitud.cargoFamiliarPeps2 ?? '',
      nombreEntidadPeps2: solicitud.nombreEntidadPeps2 ?? '',
      periodoPeps2: solicitud.periodoPeps2 ?? '',
      paisPeps2: solicitud.paisPeps2 ?? '',
      objRubroActividad: solicitud.objRubroActividad ?? '',
      objActividadPredominante: solicitud.objActividadPredominante ?? '',
      esFamiliarEmpleado: solicitud.esFamiliarEmpleado == 'input.yes'.tr(),
      nombreFamiliar: solicitud.nombreFamiliar ?? '',
      cedulaFamiliar: solicitud.cedulaFamiliar ?? '',
      objTipoDocumentoId: solicitud.objTipoDocumentoId ?? '',
      objRubroActividad2: solicitud.objRubroActividad2 ?? '',
      objRubroActividad3: solicitud.objRubroActividad3 ?? '',
      objRubroActividadPredominante:
          solicitud.objRubroActividadPredominante ?? '',
      tipoPersona: solicitud.tipoPersona ?? '',
      objTipoPersonaId: solicitud.objTipoPersonaId ?? '',
      telefonoBeneficiario: solicitud.telefonoBeneficiario ?? '',
      codigoRed: solicitud.codigoRed ?? '',
      plazoSolicitud: solicitud.plazoSolicitud ?? 0,
      fechaPrimerPagoSolicitud: solicitud.fechaPrimerPagoSolicitud?.toUtc(),
      nombreTrabajo: solicitud.nombreTrabajo ?? '',
      direccionTrabajo: solicitud.direccionTrabajo ?? '',
      barrioTrabajo: solicitud.barrioTrabajo ?? '',
      objActividadEconomicaId: solicitud.objActividadEconomicaId ?? '',
      objActividadEconomicaId1: solicitud.objActividadEconomicaId1 ?? '',
      objActividadEconomicaId2: solicitud.objActividadEconomicaId2 ?? '',
      cargo: solicitud.cargo ?? '',
      direccionFamiliarCercano: solicitud.direccionFamiliarCercano ?? '',
      duenoVivienda: solicitud.duenoVivienda ?? '',
      fechaVenceAvaluoAsalariado: solicitud.fechaVenceAvaluoAsalariado,
      fuenteOtrosIngresos: solicitud.fuenteOtrosIngresos ?? '',
      fuenteOtrosIngresosConyugue: solicitud.fuenteOtrosIngresosConyugue ?? '',
      lugarTrabajoAnterior: solicitud.lugarTrabajoAnterior ?? '',
      nombreFamiliarCercano: solicitud.nombreFamiliarCercano ?? '',
      objParentescoFamiliarCercanoId:
          solicitud.objParentescoFamiliarCercanoId ?? '',
      otrosIngresosConyugue: solicitud.otrosIngresosConyugue ?? 0,
      otrosIngresosCordoba: solicitud.otrosIngresosCordoba ?? 0,
      pagoAlquiler: solicitud.pagoAlquiler ?? 0,
      profesionConyugue: solicitud.profesionConyugue ?? '',
      salarioNetoCordoba: solicitud.salarioNetoCordoba ?? 0,
      sueldoMesConyugue: solicitud.sueldoMesConyugue ?? 0,
      telefonoFamiliarCercano: solicitud.telefonoFamiliarCercano ?? '',
      telefonoTrabajo: solicitud.telefonoTrabajo ?? '',
      tiempoLaborar: solicitud.tiempoLaborar ?? '',
      tiempoLaborarConyugue: solicitud.tiempoLaborarConyugue ?? '',
      totalIngresoMes: solicitud.totalIngresoMes ?? 0,
      totalIngresoMesConyugue: solicitud.totalIngresoMesConyugue ?? 0,
      historialCredito: [],
    );
  }
}
