import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitudes_on_comite_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'comite_solicitudes_state.dart';

class ComiteSolicitudesCubit extends Cubit<ComiteSolicitudesState> {
  final ComiteRepositoryHN _repository;
  ComiteSolicitudesCubit(this._repository) : super(ComiteSolicitudesInitial());

  Future<void> getComiteSolicitudes() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final data = await _repository.obtenerSolicitudesEnComite(
        documentoCliente: state.cedulaClienteFilter,
        numeroSolicitud: state.numeroSolicitudFilter,
        nombrePromotor: state.nombrePromotorFilter,
        numeroActa: state.numeroActaFilter,
      );
      emit(state.copyWith(
        status: Status.done,
        data: data.data,
      ));
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

  void onFieldChanged(ComiteSolicitudesState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void cleanState() {
    emit(
      state.copyWith(
        isNumeroSolicitudFilter: false,
        isCedulaSolicitudFilter: false,
        numeroSolicitudFilter: 0,
        cedulaClienteFilter: '',
        numeroActaFilter: 0,
        isNumeroActaFilter: false,
        isNombrePromotorFilter: false,
        nombrePromotorFilter: '',
      ),
    );
  }
}
