import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'desvincular_fiador_hn_state.dart';

class DesvincularFiadorHnCubit extends Cubit<DesvincularFiadorHnState> {
  final AnalisisRepositoryHn _repository;

  DesvincularFiadorHnCubit(this._repository)
      : super(const DesvincularFiadorHnState());

  Future<void> desvincular({
    required int numeroSolicitud,
    required int fiadorId,
    required String motivo,
  }) async {
    if (state.status == Status.inProgress) return;
    emit(state.copyWith(status: Status.inProgress, errorMsg: ''));
    try {
      final mensaje = await _repository.desvincularFiador(
        numeroSolicitud: numeroSolicitud,
        fiadorId: fiadorId,
        motivo: motivo,
      );
      if (isClosed) return;
      emit(state.copyWith(status: Status.done, mensaje: mensaje));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: Status.error, errorMsg: _mensaje(e)));
    }
  }

  String _mensaje(Object e) {
    if (e is AppException) {
      final msg = e.optionalMsg;
      if (msg.isNotEmpty) return msg;
    }
    return e.toString();
  }
}
