import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/forms/kiva_request_not_saved_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:equatable/equatable.dart';

part 'no_images_kivas_on_history_state.dart';

class NoImagesKivasOnHistoryCubit extends Cubit<NoImagesKivasOnHistoryState> {
  NoImagesKivasOnHistoryCubit(this._repository)
      : super(NoImagesKivasOnHistoryInitial());

  final ResponsesRepository _repository;

  void getNoImagesKivasOnHistory() async {
    try {
      final data = await _repository.getNoImagesKivasOnHistory();
      if (data.data!.isNotEmpty) {
        emit(OnNoImagesKivasOnHistoryHaveRequestPending(data: data));
        return;
      }
      emit(OnNoImagesKivasOnHistoryNoHaveRequestPending());
    } on AppException catch (e) {
      emit(OnNoImagesKivasOnHistoryError(errorMsg: e.optionalMsg));
    } catch (e) {
      emit(OnNoImagesKivasOnHistoryError(errorMsg: e.toString()));
    }
  }
}
