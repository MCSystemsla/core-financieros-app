import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'represta_user_by_cedula_state.dart';

class ReprestaUserByCedulaCubit extends Cubit<ReprestaUserByCedulaState> {
  final SolicitudesCreditoRepository _repository;
  ReprestaUserByCedulaCubit(this._repository)
      : super(ReprestaUserByCedulaInitial());

  Future<void> getUserReprestamoByCedula({required String cedula}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getUserReprestamoByCedula(cedula: cedula);
      emit(state.copyWith(
        id: resp.id ?? '',
        nombreCompleto: resp.nombreCompleto ?? '',
        cedula: resp.cedula,
        tipoDocumento: resp.tipoDocumento ?? '',
        tipoPersona: resp.tipoPersona ?? '',
        paisEmisorDocumento: resp.paisEmisorDocumento ?? '',
        fechaVencimientoDocumento:
            resp.fechaVencimientoDocumento?.toUtc().toIso8601String() ?? '',
        fechaEmisionDocumento:
            resp.fechaEmisionDocumento?.toUtc().toIso8601String(),
        status: Status.done,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(errorMsg: e.optionalMsg, status: Status.error));
    } catch (e) {
      emit(state.copyWith(errorMsg: e.toString(), status: Status.error));
    }
  }
}
