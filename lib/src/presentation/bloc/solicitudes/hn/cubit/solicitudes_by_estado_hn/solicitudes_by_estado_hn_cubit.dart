import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/filter_estados_credito/filter_estado_credito.dart';
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
    bool isLoadMore = false,
    FilterEstadosCredito filterEstadosCredito = FilterEstadosCredito.all,
    List<EstadoCredito> estadosCredito = const [
      EstadoCredito.registrada,
      EstadoCredito.asignada,
      EstadoCredito.enRevision,
      EstadoCredito.enComite
    ],
  }) async {
    if (isLoadMore) {
      if (state.isLoadingMore) return;
      emit(state.copyWith(isLoadingMore: true));
    } else {
      emit(state.copyWith(status: Status.inProgress));
    }

    try {
      final resp = await _repository.getSolicitudesByEstado(
        estadoCredito: estadoCredito,
        isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
        numeroSolicitud: state.numeroSolicitud,
        cedulaCliente: state.cedulaCliente,
        pagina: state.pagina,
        codigoGrupo: codigoGrupo,
        isCustomEstadoCredito: isCustomEstadoCredito,
        filterEstadosCredito: filterEstadosCredito,
        estadosCredito: estadosCredito,
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
        isLoadingMore: false,
      ));
    } on AppException catch (e) {
      _emitError(e.optionalMsg, isLoadMore: isLoadMore);
    } catch (e) {
      _emitError(e.toString(), isLoadMore: isLoadMore);
    }
  }

  void _emitError(String errorMsg, {required bool isLoadMore}) {
    // Al paginar no se destruye la lista ya cargada: solo se corta el load more
    // y se devuelve la pagina para poder reintentar.
    if (isLoadMore) {
      emit(state.copyWith(
        isLoadingMore: false,
        hasMore: false,
        pagina: state.pagina > 1 ? state.pagina - 1 : 1,
      ));
      return;
    }
    emit(state.copyWith(status: Status.error, errorMsg: errorMsg));
  }

  void cleanState() {
    emit(state.copyWith(
      isAsignadaToAsesorCredito: true,
      isNumeroSolicitudFilter: false,
      isCedulaSolicitudFilter: false,
      numeroSolicitud: '',
      cedulaCliente: '',
      solicitudes: [],
      isLoadingMore: false,
    ));
  }

  void onFieldChanged(SolicitudesByEstadoHnState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void changePage(int page) {
    emit(state.copyWith(pagina: page));
  }
}
