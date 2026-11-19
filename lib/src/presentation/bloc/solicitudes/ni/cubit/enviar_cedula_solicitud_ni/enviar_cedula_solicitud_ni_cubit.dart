import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'enviar_cedula_solicitud_ni_state.dart';

/// Reenvía las fotos de la cédula del cliente al expediente digital de una
/// solicitud NI ya creada en el servidor (`/solicitudes/registrar-cedula`).
class EnviarCedulaSolicitudNiCubit extends Cubit<EnviarCedulaSolicitudNiState> {
  final SolicitudesCreditoRepository repository;
  EnviarCedulaSolicitudNiCubit(this.repository)
      : super(const EnviarCedulaSolicitudNiState());

  Future<void> enviarCedulaSolicitud({
    required String numeroSolicitud,
    required String cedulaCliente,
    required String? imagenFrontal,
    required String? imagenTrasera,
  }) async {
    if (state.status == Status.inProgress) return;
    // Sin este paso, un segundo error igual al anterior no cambia el estado
    // y el listener no vuelve a mostrar el mensaje.
    emit(state.copyWith(status: Status.notStarted));

    final numero = int.tryParse(numeroSolicitud);
    if (numero == null || numero <= 0) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: 'La solicitud no tiene un número válido.',
      ));
      return;
    }
    if (imagenFrontal == null ||
        imagenFrontal.isEmpty ||
        imagenTrasera == null ||
        imagenTrasera.isEmpty) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: 'La cédula no tiene ambas fotos guardadas en el teléfono.',
      ));
      return;
    }

    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) =
          await repository.sendCedulaImageWhenSolicitudCreditoCreated(
        numeroSolicitud: numero,
        cedulaCliente: cedulaCliente,
        imagenFrontal: imagenFrontal,
        imagenTrasera: imagenTrasera,
      );
      if (isClosed) return;
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: msg));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
