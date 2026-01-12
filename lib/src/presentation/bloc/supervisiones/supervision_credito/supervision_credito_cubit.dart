import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_credito.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'supervision_credito_state.dart';

class SupervisionCreditoCubit extends Cubit<SupervisionCreditoState> {
  final SupervisionesRepositoryHn _repository;
  SupervisionCreditoCubit(this._repository)
      : super(SupervisionCreditoInitial());

  Future<void> createSupervisionCredito() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createSupervisionCredito(
        createSupervisionCredito: CreateSupervisionCredito(
          numeroSolicitud: state.numeroSolicitud,
          razonCuota: state.razonCuota,
          endeudamientoFuturo: state.endeudamientoFuturo,
          documentos: state.documentos,
          ingresosFueraNegocio: state.ingresosFueraNegocio,
          garantiaDictamenLegal: state.garantiaDictamenLegal,
          referenciaComunidadBuena: state.referenciaComunidadBuena,
          referenciaComunidadMala: state.referenciaComunidadMala,
          buroCreditoBueno: state.buroCreditoBueno,
          buroCreditoRegular: state.buroCreditoRegular,
          buroCreditoMalas: state.buroCreditoMalas,
          tasa: state.tasa,
          planInversionObservacion: state.planInversionObservacion,
          monto: state.monto,
          plazo: state.plazo,
          productoCodigo: state.productoCodigo,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }
}
