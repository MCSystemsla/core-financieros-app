import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/grupo_activo_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'grupos_activos_state.dart';

class GruposActivosCubit extends Cubit<GruposActivosState> {
  final SolicitudesCreditoHnRepository _repository;
  GruposActivosCubit(this._repository) : super(GruposActivosInitial());

  Future<void> getGruposActivos() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getGruposActivos(
        grupoCodigo: state.grupoCodigo,
        grupoNombre: state.grupoNombre,
      );
      emit(state.copyWith(status: Status.done, gruposActivos: resp.data));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> createGrupoCredito({required String nombre}) async {
    emit(state.copyWith(createStatus: Status.inProgress));
    try {
      await _repository.crearGrupoCredito(nombre: nombre);
      emit(state.copyWith(createStatus: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(createStatus: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(createStatus: Status.error, errorMsg: e.toString()));
    }
  }

  void onFieldChanged(GruposActivosState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void cleanState() {
    emit(
      state.copyWith(
        isGrupoCodigoFilter: false,
        isGrupoNombreFilter: false,
        grupoCodigo: '',
        grupoNombre: '',
      ),
    );
  }
}
