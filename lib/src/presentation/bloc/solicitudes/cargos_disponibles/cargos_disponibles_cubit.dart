import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/cargos_disponible_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'cargos_disponibles_state.dart';

class CargosDisponiblesCubit extends Cubit<CargosDisponiblesState> {
  final SolicitudesCreditoHnRepository _repository;
  CargosDisponiblesCubit(this._repository) : super(CargosDisponiblesInitial());

  void getCargosDisponibles({
    required int? grupoCodigo,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data = await _repository.getCargosDisponibles(
        grupoCodigo: grupoCodigo,
      );
      emit(state.copyWith(status: Status.done, data: data.data));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
