import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_create_service_schema.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'comite_create_servicios_state.dart';

class ComiteCreateServiciosCubit extends Cubit<ComiteCreateServiciosState> {
  final ComiteRepositoryHN _repository;
  ComiteCreateServiciosCubit(this._repository)
      : super(ComiteCreateServiciosInitial());

  Future<void> crearServicios({
    required int comiteId,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.crearServicios(
        data: ComiteCreateServiceSchema(
          comiteId: comiteId,
          servicios: state.servicios,
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

  void saveServicios({required ServicioData servicio}) {
    emit(
      state.copyWith(
        servicios: [
          ...state.servicios,
          servicio,
        ],
      ),
    );
  }

  void deleteServicios({required ServicioData servicio}) {
    emit(
      state.copyWith(
        servicios: state.servicios
            .where((e) => e.servicioId != servicio.servicioId)
            .toList(),
      ),
    );
  }
}
