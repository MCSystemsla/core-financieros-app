import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:equatable/equatable.dart';

part 'solicitudes_pendientes_state.dart';

class SolicitudesPendientesCubit extends Cubit<SolicitudesPendientesState> {
  final SolicitudesPendientesRepository solicitudesPendientesRepository;
  SolicitudesPendientesCubit(this.solicitudesPendientesRepository)
      : super(SolicitudesPendientesInitial());

  getSolicitudesPendientes() async {
    try {
      emit(OnSolicitudesPendientesLoading());
      final data =
          await solicitudesPendientesRepository.getSolicitudesPendientes();
      emit(OnSolicitudesPendientesSuccess(
        solicitudesPendienteResponse: data,
      ));
    } catch (e) {
      emit(OnSolicitudesPendientesError());
    }
  }
}
