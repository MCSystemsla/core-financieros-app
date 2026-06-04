import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/signature/nueva/solicitud_nueva_signature_hn.dart';
import 'package:equatable/equatable.dart';

part 'enviar_firma_digital_solicitud_hn_state.dart';

class EnviarFirmaDigitalSolicitudHnCubit
    extends Cubit<EnviarFirmaDigitalSolicitudHnState> {
  final SolicitudesCreditoHnRepository repository;
  EnviarFirmaDigitalSolicitudHnCubit(this.repository)
      : super(EnviarFirmaDigitalSolicitudHnInitial());

  Future<void> enviarFirmaDigital({
    required String numeroSolicitud,
    required String cedulaCliente,
    required String firmaCliente,
    required String tipoSolicitud,
    required ClientSignatureStatus clientSignatureStatus,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) =
          await repository.sendClientSignatureWhenSolicitudCreditoCreated(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
        documentoCliente: cedulaCliente,
        clientSignatureStatus: clientSignatureStatus,
        firmaCliente: firmaCliente,
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
