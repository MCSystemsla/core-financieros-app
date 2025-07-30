import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_nueva_by_estado_state.dart';

class SolicitudNuevaByEstadoCubit extends Cubit<SolicitudNuevaByEstadoState> {
  final SolicitudesCreditoRepository _solicitudNuevaByEstadoRepository;
  SolicitudNuevaByEstadoCubit(this._solicitudNuevaByEstadoRepository)
      : super(SolicitudNuevaByEstadoInitial());

  Future<void> getSolicitudesByEstado({
    EstadoCredito estadoCredito = EstadoCredito.registrada,
    bool isAsignadaToAsesorCredito = false,
    bool isNumeroSolicitudFilter = false,
    bool isCedulaSolicitudFilter = false,
    String? numeroSolicitud,
    String? cedulaCliente,
  }) async {
    emit(OnSolicitudNuevaByEstadoLoading());
    try {
      final (isOk, data) =
          await _solicitudNuevaByEstadoRepository.getSolicitudesCreditoByEstado(
        estadoCredito: estadoCredito,
        isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
        numeroSolicitud: numeroSolicitud,
        cedulaCliente: cedulaCliente,
      );

      emit(OnSolicitudNuevaByEstadoSuccess(
        solicitudByEstado: data,
        estadoCredito: estadoCredito,
        isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
        isNumeroSolicitudFilter: isNumeroSolicitudFilter,
        isCedulaSolicitudFilter: isCedulaSolicitudFilter,
        numeroSolicitud: numeroSolicitud,
        cedulaCliente: cedulaCliente,
      ));
    } on AppException catch (e) {
      emit(OnSolicitudNuevaByEstadoError(errorMsg: e.optionalMsg));
    } catch (e) {
      log(e.toString());
      emit(OnSolicitudNuevaByEstadoError(errorMsg: e.toString()));
    }
  }
}
