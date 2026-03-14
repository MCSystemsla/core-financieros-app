import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'solicitudes_by_estado_hn_state.dart';

class SolicitudesByEstadoHnCubit extends Cubit<SolicitudesByEstadoHnState> {
  final SolicitudesCreditoHnRepository _repository;
  SolicitudesByEstadoHnCubit(this._repository)
      : super(SolicitudesByEstadoHnInitial());

  Future<void> getSolicitudesByEstado({
    bool isAsignadaToAsesorCredito = false,
    EstadoCredito estadoCredito = EstadoCredito.registrada,
    int? codigoGrupo,
    bool isCustomEstadoCredito = false,
  }) async {
    emit(state.copyWith(status: Status.inProgress));

    try {
      final resp = await _repository.getSolicitudesByEstado(
        estadoCredito: estadoCredito,
        isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
        numeroSolicitud: state.numeroSolicitud,
        cedulaCliente: state.cedulaCliente,
        pagina: state.pagina,
        codigoGrupo: codigoGrupo,
        isCustomEstadoCredito: isCustomEstadoCredito,
      );
      final hasUserAppliedFilter =
          state.isNumeroSolicitudFilter || state.isCedulaSolicitudFilter;
      emit(state.copyWith(
        status: Status.done,
        solicitudes: hasUserAppliedFilter
            ? resp.data
            : [...state.solicitudes, ...resp.data],
        hasMore: resp.metaDataPagination.hasMore,
        isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
        pagina: resp.metaDataPagination.paginaActual,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void cleanState() {
    emit(state.copyWith(
      isAsignadaToAsesorCredito: true,
      isNumeroSolicitudFilter: false,
      isCedulaSolicitudFilter: false,
      numeroSolicitud: '',
      cedulaCliente: '',
      solicitudes: [],
    ));
  }

  void onFieldChanged(SolicitudesByEstadoHnState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void changePage(int page) {
    emit(state.copyWith(pagina: page));
  }
}
