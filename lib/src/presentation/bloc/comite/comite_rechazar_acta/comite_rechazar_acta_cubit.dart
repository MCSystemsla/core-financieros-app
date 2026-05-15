import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_rechazar_acta.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'comite_rechazar_acta_state.dart';

class ComiteRechazarActaCubit extends Cubit<ComiteRechazarActaState> {
  final ComiteRepositoryHN _repository;
  ComiteRechazarActaCubit(this._repository)
      : super(ComiteRechazarActaInitial());

  void rechazarActa({
    required int numeroSolicitud,
    required String tipoSolicitud,
    required String observacion,
    String? motivoRechazoSauidCodigo,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final msg = await _repository.rechazarActa(
        data: ComiteRechazarActa(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitud,
          motivoRechazoSauidCodigo: motivoRechazoSauidCodigo ?? '',
          observacion: observacion,
        ),
      );
      emit(state.copyWith(status: Status.done, successMessage: msg));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
