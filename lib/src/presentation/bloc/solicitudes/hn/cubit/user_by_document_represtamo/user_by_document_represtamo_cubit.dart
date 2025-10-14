import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'user_by_document_represtamo_state.dart';

class UserByDocumentReprestamoCubit
    extends Cubit<UserByDocumentReprestamoState> {
  final SolicitudesCreditoHnRepository _repository;
  UserByDocumentReprestamoCubit(this._repository)
      : super(UserByDocumentReprestamoInitial());
  Future<void> getUserByDocument({
    required String cedula,
    required String nombre,
    required String tipoDocumentoCodigo,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getUserByDocumentReprestamo(
        cedula: cedula,
        nombre: nombre,
        tipoDocumentoCodigo: tipoDocumentoCodigo,
      );

      emit(state.copyWith(
        status: Status.done,
        id: resp.data.id,
        nombreCompleto: resp.data.nombreCompleto,
        cedula: resp.data.cedula,
        tipoDocumento: resp.data.tipoDocumento,
        tipoPersona: resp.data.tipoPersona,
        paisEmisorCedula: resp.data.paisEmisorCedula,
        fechaVencimientoCedula:
            resp.data.fechaVencimientoCedula.toUtc().toIso8601String(),
        fechaEmisionCedula:
            resp.data.fechaEmisionCedula.toUtc().toIso8601String(),
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
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
}
