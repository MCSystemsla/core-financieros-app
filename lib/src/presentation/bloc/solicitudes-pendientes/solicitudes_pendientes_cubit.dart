import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'solicitudes_pendientes_state.dart';

class SolicitudesPendientesCubit extends Cubit<SolicitudesPendientesState> {
  final SolicitudesPendientesRepository solicitudesPendientesRepository;
  SolicitudesPendientesCubit(this.solicitudesPendientesRepository)
      : super(SolicitudesPendientesInitial());

  Future<void> getSolicitudesPendientes() async {
    emit(state.copyWith(status: Status.inProgress));
    await Future.delayed(const Duration(seconds: 2));
    try {
      final data =
          await solicitudesPendientesRepository.getSolicitudesPendientes();
      emit(
        state.copyWith(
          solicitudesPendienteResponse: data.solicitudes,
          filteredSolicitudes: data.solicitudes,
          status: Status.done,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> getSolicitudesPendientesSended() async {
    emit(state.copyWith(status: Status.inProgress));
    await Future.delayed(const Duration(seconds: 2));
    try {
      final data =
          await solicitudesPendientesRepository.getSolicitudesPendientes();
      emit(
        state.copyWith(
          solicitudesPendienteResponse: data.solicitudes,
          filteredSolicitudes: data.solicitudes,
          status: Status.done,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  void filterSolicitudes(String query) {
    final solicitudes = state.solicitudesPendienteResponse;

    if (query.isEmpty) {
      emit(state.copyWith(filteredSolicitudes: solicitudes));
      return;
    }

    final filtered = solicitudes.where((solicitud) {
      return solicitud.nombre.toLowerCase().contains(query.toLowerCase()) ||
          solicitud.numero.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(state.copyWith(filteredSolicitudes: filtered));
  }
}
