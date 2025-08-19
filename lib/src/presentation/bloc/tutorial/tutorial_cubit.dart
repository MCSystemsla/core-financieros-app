import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/tutorial/tutorial_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'tutorial_state.dart';

class TutorialCubit extends Cubit<TutorialState> {
  TutorialCubit(this._repository) : super(TutorialInitial());
  final AuthRepository _repository;

  Future<void> getTutorials() async {
    emit(OnTutorialStateLoading());
    try {
      final tutorialResponse = await _repository.getTutorials();
      emit(OnTutorialStateSuccess(tutorialResponse: tutorialResponse));
    } on AppException catch (e) {
      emit(OnTutorialStateError(errorMsg: e.optionalMsg));
    } catch (e) {
      emit(OnTutorialStateError(errorMsg: e.toString()));
    }
  }
}
