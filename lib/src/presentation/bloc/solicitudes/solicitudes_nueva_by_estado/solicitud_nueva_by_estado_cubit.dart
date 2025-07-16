import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_nueva_by_estado_state.dart';

class SolicitudNuevaByEstadoCubit extends Cubit<SolicitudNuevaByEstadoState> {
  final SolicitudesCreditoRepository _solicitudNuevaByEstadoRepository;
  SolicitudNuevaByEstadoCubit(this._solicitudNuevaByEstadoRepository)
      : super(SolicitudNuevaByEstadoInitial());

  Future<void> getSolicitudNuevaByEstado({required TypeForm typeForm}) async {
    emit(OnSolicitudNuevaByEstadoLoading());
    try {
      final (isOk, data) = await _solicitudNuevaByEstadoRepository
          .getSolicitudesEstadoByTypeForm(
        estadoCredito: EstadoCredito.registrada,
        typeForm: typeForm,
      );

      emit(OnSolicitudNuevaByEstadoSuccess(solicitudByEstado: data));
    } on AppException catch (e) {
      emit(OnSolicitudNuevaByEstadoError(errorMsg: e.optionalMsg));
    } catch (e) {
      log(e.toString());
      emit(OnSolicitudNuevaByEstadoError(errorMsg: e.toString()));
    }
  }
}
