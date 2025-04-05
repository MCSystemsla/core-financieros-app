import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_represtamo_state.dart';

class SolicitudReprestamoCubit extends Cubit<SolicitudReprestamoState> {
  final SolicitudesCreditoRepository _solicitudesCreditoRepository;
  SolicitudReprestamoCubit(this._solicitudesCreditoRepository)
      : super(SolicitudReprestamoInitial());

  Future<void> createSolicitudReprestamo() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, _) =
          await _solicitudesCreditoRepository.createSolicitudReprestamo(
        solicitudReprestamo: SolicitudReprestamo(
          database: state.database,
          fecha: DateTime.parse(state.fecha),
          objOrigenSolicitudId: state.objOrigenSolicitudId,
          objClienteId: state.objClienteId,
          monto: state.monto,
          objMonedaId: state.objMonedaId,
          objPropositoId: state.objPropositoId,
          objFrecuenciaId: state.objFrecuenciaId,
          cuota: state.cuota,
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
          ubicacionGradosLongitud: state.ubicacionGradosLongitud,
          ubicacionGradosLatitud: state.ubicacionGradosLatitud,
          sucursal: state.sucursal,
          usuarioCreacion: state.usuarioCreacion,
          fechaCreacion: DateTime.parse(state.fechaCreacion),
          maquinaCreacion: state.maquinaCreacion,
          usuarioModificacion: state.usuarioModificacion,
          fechaModificacion: DateTime.parse(state.fechaModificacion),
          maquinaModificacion: state.maquinaModificacion,
          fechaAprobacion: DateTime.parse(state.fechaAprobacion),
          usuarioAprobacion: state.usuarioAprobacion,
          fechaARevision: DateTime.parse(state.fechaARevision),
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
          objPremioSolicitudId: state.objPremioSolicitudId,
          telefonoBeneficiario: state.telefonoBeneficiario,
          objMotivoRechazoSauid: state.objMotivoRechazoSauid,
          objCategoriaRechazoSauId: state.objCategoriaRechazoSauId,
          celularRepresntamo: state.celularRepresntamo,
          estadoSms: state.estadoSms,
          referenciaSms: state.referenciaSms,
          esFamiliarEmpleado: state.esFamiliarEmpleado,
          nombreFamiliar: state.nombreFamiliar,
          cedulaFamiliar: state.cedulaFamiliar,
          cargaAnalisisAutomatico: state.cargaAnalisisAutomatico,
          objMotivoRevisionId: state.objMotivoRevisionId,
          plazoSolicitud: state.plazoSolicitud,
          celularReprestamo: state.celularReprestamo,
          fechaPrimerPagoSolicitud:
              DateTime.parse(state.fechaPrimerPagoSolicitud),
        ),
      );
      if (!isOk) {
        emit(
          state.copyWith(),
        );
      }
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
