import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_solicitudes_state.dart';

class AnalisisSolicitudesCubit extends Cubit<AnalisisSolicitudesState> {
  AnalisisSolicitudesCubit(this._repository)
      : super(AnalisisSolicitudesInitial());
  final SolicitudesCreditoRepository _repository;

  Future<void> getSolicitudesByEstado() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (_, solicitudes) = await _repository.getSolicitudesCreditoByEstado(
        estadoCredito: EstadoCredito.asignada,
        isAsignadaToAsesorCredito: true,
        cedulaCliente: null,
        pagina: null,
        numeroSolicitud: null,
      );
      emit(state.copyWith(status: Status.done, data: solicitudes.data));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    }
    (e) {
      emit(state.copyWith());
    };
  }
}
