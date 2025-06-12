import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asalariado/solicitud_asalariado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'enviar_solicitud_when_isdone_state.dart';

class EnviarSolicitudWhenIsdoneCubit
    extends Cubit<EnviarSolicitudWhenIsdoneState> {
  final ObjectBoxService objectBoxService;
  final SolicitudesCreditoRepository repository;
  EnviarSolicitudWhenIsdoneCubit(this.objectBoxService, this.repository)
      : super(EnviarSolicitudWhenIsdoneInitial());
  final _logger = Logger();

  void sendSolicitudWhenIsDone({required bool isConnected}) async {
    List<String> errors = [];
    List<String> solicitudesSent = [];
    (bool isSuccess, String errorMessage) result = (false, '');
    bool hasAnySent = false;
    emit(OnEnviarSolicitudWhenIsdoneLoading());
    try {
      final solicitudes = objectBoxService.sendSolicitudesWhenIsDone();
      if (solicitudes.isEmpty || !isConnected) {
        emit(EnviarSolicitudWhenIsdoneInitial());
        return;
      }
      await Future.delayed(const Duration(seconds: 3));
      for (var solicitud in solicitudes) {
        result = await _sendSolicitud(solicitud: solicitud);

        if (!result.$1) {
          objectBoxService.updateWhenSolicitdIsFailed(
            solicitudId: solicitud.id,
            errorMsg: result.$2,
          );

          errors.add('Solicitud ID ${solicitud.cedula}: ${result.$2}');

          continue;
        }
        if (solicitud is ResponseLocalDb && result.$1) {
          objectBoxService.removeSolicitudWhenisUploaded(
            solicitudId: solicitud.id,
          );
        }
        if (solicitud is ReprestamoResponsesLocalDb && result.$1) {
          objectBoxService.removeSolicitudReprestamoWhenisUploaded(
            solicitudId: solicitud.id,
          );
        }
        if (solicitud is AsalariadoResponsesLocalDb && result.$1) {
          objectBoxService.removeSolicitudAsalariadoWhenisUploaded(
            solicitudId: solicitud.id,
          );
        }
        solicitudesSent.add('Solicitud ID ${solicitud.cedula}');
        hasAnySent = true;
      }
      if (hasAnySent == true && errors.isEmpty) {
        emit(
          OnEnviarSolicitudWhenIsdoneSuccess(
            solicitudesSent: solicitudesSent,
          ),
        );
      } else {
        emit(
          OnEnviarSolicitudWhenIsdonePendingVerification(
            solicitudesSent: solicitudesSent,
            errors: errors,
            msgError:
                'Algunas solicitudes tienen errores y no se pudieron procesar.',
          ),
        );
      }
    } on TimeoutException catch (e) {
      _logger.e(e);
      emit(
        const OnEnviarSolicitudWhenIsdoneError(
          msgError: 'El servidor tardó demasiado en responder.',
        ),
      );
    } on SocketException catch (e) {
      _logger.e(e);
      emit(
        const OnEnviarSolicitudWhenIsdoneError(
          msgError: 'Error de conexion de red, Verifica tu red',
        ),
      );
    } catch (e) {
      _logger.e(e);
      emit(OnEnviarSolicitudWhenIsdoneError(msgError: e.toString()));
    }
  }

  void resetState() {
    emit(EnviarSolicitudWhenIsdoneInitial());
  }

  Future<(bool, String)> _sendSolicitud({required dynamic solicitud}) async {
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
          'Solicitud de tipo ${solicitud.runtimeType} no soportado en el envío automático.',
        )
    };
  }

  SolicitudNuevaMenor _mapToSolicitudNuevaMenor(ResponseLocalDb solicitud) {
    return SolicitudNuevaMenor(
      isOffline: solicitud.isDone ?? false,
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
      espeps: solicitud.espeps ?? false,
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
      esFamiliarEmpleado: solicitud.esFamiliarEmpleado ?? false,
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
    );
  }

  SolicitudReprestamo _mapToSolicitudReprestamo(
      ReprestamoResponsesLocalDb solicitud) {
    return SolicitudReprestamo(
      isOffline: solicitud.isOffline ?? false,
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
    );
  }

  SolicitudAsalariado _mapToSolicitudAsalariado(
    AsalariadoResponsesLocalDb solicitud,
  ) {
    return SolicitudAsalariado(
      isOffline: solicitud.isOffline ?? false,
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
      espeps: solicitud.espeps ?? false,
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
      esFamiliarEmpleado: solicitud.esFamiliarEmpleado ?? false,
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
    );
  }
}
