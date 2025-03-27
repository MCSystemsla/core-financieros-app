import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
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
    emit(OnEnviarSolicitudWhenIsdoneLoading());
    try {
      final solicitudes = objectBoxService.sendSolicitudWhenIsDone();
      if (solicitudes.isEmpty || !isConnected) {
        emit(EnviarSolicitudWhenIsdoneInitial());
        return;
      }
      await Future.delayed(const Duration(seconds: 5));
      for (var solicitud in solicitudes) {
        try {
          final (isOk, msg) = await repository.createSolicitudCreditoNuevaMenor(
            solicitudNuevaMenor: SolicitudNuevaMenor(
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
              tiempoFuncionamientoNegocio:
                  solicitud.tiempoFuncionamientoNegocio ?? '',
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
              direccionTrabajoConyugue:
                  solicitud.direccionTrabajoConyugue ?? '',
              telefonoTrabajoConyugue: solicitud.telefonoTrabajoConyugue ?? '',
              beneficiarioSeguro: solicitud.beneficiarioSeguro ?? '',
              cedulaBeneficiarioSeguro:
                  solicitud.cedulaBeneficiarioSeguro ?? '',
              objParentescoBeneficiarioSeguroId:
                  solicitud.objParentescoBeneficiarioSeguroId ?? '',
              beneficiarioSeguro1: solicitud.beneficiarioSeguro1 ?? '',
              cedulaBeneficiarioSeguro1:
                  solicitud.cedulaBeneficiarioSeguro1 ?? '',
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
              objActividadPredominante:
                  solicitud.objActividadPredominante ?? '',
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
              telefonoBeneficiarioSeguro1:
                  solicitud.telefonoBeneficiarioSeguro1 ?? '',
              plazoSolicitud: solicitud.plazoSolicitud ?? 0,
              fechaPrimerPagoSolicitud:
                  solicitud.fechaPrimerPagoSolicitud ?? '',
            ),
          );
          if (!isOk) {
            emit(OnEnviarSolicitudWhenIsdoneError(
                msgError:
                    'Error en Solicitud de ${solicitud.nombre1} ${solicitud.apellido1}: $msg'));
            return;
          }
          objectBoxService.removeSolicitudWhenisUploaded(
            solicitudId: solicitud.id,
          );
        } catch (e) {
          _logger.e(e);
          emit(OnEnviarSolicitudWhenIsdoneError(msgError: e.toString()));
        }
      }
      emit(const OnEnviarSolicitudWhenIsdoneSuccess());
    } catch (e) {
      _logger.e(e);
      emit(OnEnviarSolicitudWhenIsdoneError(msgError: e.toString()));
    }
  }
}
