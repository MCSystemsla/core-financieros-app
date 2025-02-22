import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses/departamentos_response.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'departamentos_state.dart';

class DepartamentosCubit extends Cubit<DepartamentosState> {
  final DepartamentoRepository departamentoRepository;
  DepartamentosCubit(this.departamentoRepository)
      : super(DepartamentosInitial());

  Future getDepartamentos() async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      final data = await departamentoRepository.getDepartamentos();
      emit(
        state.copyWith(
          departamentos: data.departamentos,
          status: Status.done,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
