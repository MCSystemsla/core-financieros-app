import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';

part 'solicitudes_by_asesor_state.dart';

class SolicitudesByAsesorCubit extends Cubit<SolicitudesByAsesorState> {
  SolicitudesByAsesorCubit(this._repository)
      : super(SolicitudesByAsesorInitial());
  final SolicitudesCreditoRepository _repository;

  Future<void> getSolicitudesByAsesor() async {
    emit(OnSolicitudesByAsesorLoading());
    try {
      final (_, data) = await _repository.getSolicitudesByAsesor();
      emit(OnSolicitudesByAsesorSuccess(solicitudes: data));
    } on AppException catch (e) {
      OnSolicitudesByAsesorError(errorMsg: e.optionalMsg);
    } catch (e) {
      OnSolicitudesByAsesorError(errorMsg: e.toString());
    }
  }
}
