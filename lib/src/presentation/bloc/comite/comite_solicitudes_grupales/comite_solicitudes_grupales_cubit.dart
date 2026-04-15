import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitudes_grupales_on_comite_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/order_type/order_type.dart';
import 'package:equatable/equatable.dart';

part 'comite_solicitudes_grupales_state.dart';

class ComiteSolicitudesGrupalesCubit
    extends Cubit<ComiteSolicitudesGrupalesState> {
  final ComiteRepositoryHN _repository;
  ComiteSolicitudesGrupalesCubit(this._repository)
      : super(ComiteSolicitudesGrupalesInitial());

  Future<void> getSolicitudesGrupalesOnComite({
    required int grupoId,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.obtenerSolicitudesGrupalesEnComite(
        numeroSolicitud: state.numeroSolicitud,
        documentoCliente: state.documentoCliente,
        nombrePromotor: state.nombrePromotor,
        numeroActa: state.numeroActa,
        orderType: state.orderType,
        grupoId: grupoId,
      );
      emit(state.copyWith(
        status: Status.done,
        data: resp.data,
        montoTotalGrupo: resp.montoTotalGrupo,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
