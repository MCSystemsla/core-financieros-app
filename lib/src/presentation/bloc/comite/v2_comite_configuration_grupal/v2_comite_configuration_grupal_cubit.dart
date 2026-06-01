import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_create_configuration_grupal.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'v2_comite_configuration_grupal_state.dart';

class V2ComiteConfigurationGrupalCubit
    extends Cubit<V2ComiteConfigurationGrupalState> {
  final ComiteRepositoryHN _repository;
  V2ComiteConfigurationGrupalCubit(this._repository)
      : super(V2ComiteConfigurationGrupalInitial());

  Future<void> crearConfigurationGrupal({required int cicloGrupoId}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.crearConfigurationGrupal(
        data: ComiteCreateConfigurationGrupal(
          cicloGrupoId: cicloGrupoId,
          productoCodigo: state.productoCodigo,
          monedaCodigo: state.monedaCodigo,
          tipoDesembolsoCodigo: state.tipoDesembolsoCodigo,
          formaDePagoCodigo: state.formaDePagoCodigo,
          periodicidadPrincipalCodigo: state.periodicidadPrincipalCodigo,
          periodicidadInteresCodigo: state.periodicidadInteresCodigo,
          tipoProgramaCodigo: state.tipoProgramaCodigo,
          fuenteFinanciamientoCodigo: state.fuenteFinanciamientoCodigo,
          tipoCreditoNombre: state.tipoCreditoNombre,
          periodoGracia: state.periodoGracia,
          plazo: state.plazo,
          observacion: state.observacion,
          fechaPrimerPago: DateTime.parse(state.fechaPrimerPago),
          tasaInteresCorriente: state.tasaInteresCorriente,
          tasaInteresMoratorio: state.tasaInteresMoratorio,
        ),
      );
      emit(state.copyWith(status: Status.done, dataAreLoaded: true));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> getConfigurationGrupal({required int cicloGrupoId}) async {
    emit(state.copyWith(getConfigurationStatus: Status.inProgress));
    try {
      final data = await _repository.obtenerConfigurationGrupal(
        cicloGrupoId: cicloGrupoId,
      );
      emit(
        state.copyWith(
          getConfigurationStatus: Status.done,
          productoCodigo: data.data.productoCodigo,
          monedaCodigo: data.data.monedaCodigo,
          tipoDesembolsoCodigo: data.data.tipoDesembolsoCodigo,
          formaDePagoCodigo: data.data.formaDePagoCodigo,
          periodicidadPrincipalCodigo: data.data.periodicidadPrincipalCodigo,
          periodicidadInteresCodigo: data.data.periodicidadInteresCodigo,
          tipoProgramaCodigo: data.data.tipoProgramaCodigo,
          fuenteFinanciamientoCodigo: data.data.fuenteFinanciamientoCodigo,
          tipoCreditoNombre: data.data.tipoCreditoNombre,
          periodoGracia: data.data.periodoGracia,
          plazo: data.data.plazo,
          observacion: data.data.observacion,
          fechaPrimerPago: data.data.fechaPrimerPago?.toIso8601String(),
          productoNombre: data.data.nombreProducto,
          monedaNombre: data.data.monedaNombre,
          tipoDesembolsoNombre: data.data.tipoDesembolsoNombre,
          formaDePagoNombre: data.data.formaDePagoNombre,
          periodicidadPrincipalNombre: data.data.periodicidadPrincipalNombre,
          periodicidadInteresNombre: data.data.periodicidadInteresNombre,
          tipoProgramaNombre: data.data.tipoProgramaNombre,
          fuenteFinanciamientoNombre: data.data.fuenteFinanciamientoNombre,
          tasaInteresCorriente: data.data.tasaInteresCorriente,
          tasaInteresMoratorio: data.data.tasaInteresMoratorio,
          dataAreLoaded: data.data.dataAreLoaded,
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(
        getConfigurationStatus: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        getConfigurationStatus: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  void onFieldChanged(V2ComiteConfigurationGrupalState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
