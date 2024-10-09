import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recurrente_mejora_vivienda_state.dart';

class RecurrenteMejoraViviendaCubit
    extends Cubit<RecurrenteMejoraViviendaState> {
  RecurrenteMejoraViviendaCubit(this.repository)
      : super(RecurrenteMejoraViviendaInitial());

  final ResponsesRepository repository;

  Future<void> sendAnswers({
    required MejoraViviendaRecurrente mejoraViviendaRecurrente,
  }) async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      await repository.mejoraViviendaRecurrenteAnswer(
        mejoraViviendaRecurrente: mejoraViviendaRecurrente,
      );
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> saveAnswers1() async {}
  Future<void> saveAnswers2() async {}
}
