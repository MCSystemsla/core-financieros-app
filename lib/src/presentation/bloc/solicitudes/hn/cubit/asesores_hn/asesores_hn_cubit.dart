import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/asesor/asesor.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:equatable/equatable.dart';

part 'asesores_hn_state.dart';

class AsesoresHnCubit extends Cubit<AsesoresHnState> {
  final SolicitudesCreditoHnRepository _repository;
  AsesoresHnCubit(this._repository) : super(AsesoresHnInitial());

  Future<void> getAsesores() async {
    emit(OnAsesoresHnLoading());
    try {
      final (isOk, resp) = await _repository.getAsesores();
      emit(OnAsesoresHnSuccess(asesor: resp));
    } on AppException catch (e) {
      emit(OnAsesoresHnError(errorMsg: e.optionalMsg));
    } catch (e) {
      emit(OnAsesoresHnError(errorMsg: e.toString()));
    }
  }
}
