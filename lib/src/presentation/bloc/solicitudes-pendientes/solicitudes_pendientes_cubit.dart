import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'solicitudes_pendientes_state.dart';

class SolicitudesPendientesCubit extends Cubit<SolicitudesPendientesState> {
  final SolicitudesPendientesRepository solicitudesPendientesRepository;
  SolicitudesPendientesCubit(this.solicitudesPendientesRepository)
      : super(SolicitudesPendientesInitial());

  getSolicitudesPendientes() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data =
          await solicitudesPendientesRepository.getSolicitudesPendientes();
      emit(state.copyWith(
          solicitudesPendienteResponse: data.solicitudes, status: Status.done));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: Status.error));
    }
  }
}
