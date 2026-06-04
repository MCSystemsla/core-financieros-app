import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'enviar_cedula_solicitud_hn_state.dart';

class EnviarCedulaSolicitudHnCubit extends Cubit<EnviarCedulaSolicitudHnState> {
  final SolicitudesCreditoHnRepository repository;
  EnviarCedulaSolicitudHnCubit(this.repository)
      : super(EnviarCedulaSolicitudHnInitial());

  Future<void> enviarCedulaSolicitud({
    required String numeroSolicitud,
    required String cedulaCliente,
    required String imagenFrontal,
    required String imagenTrasera,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) =
          await repository.sendCedulaImageWhenSolicitudCreditoCreated(
        numeroSolicitud: int.tryParse(numeroSolicitud) ?? 0,
        cedulaCliente: cedulaCliente,
        imagenFrontal: imagenFrontal,
        imagenTrasera: imagenTrasera,
      );
      if (!isOk) {
        emit(state.copyWith(
          status: Status.error,
          errorMsg: msg,
        ));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
