import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_imagenes_negocio_state.dart';

class AnalisisImagenesNegocioCubit extends Cubit<AnalisisImagenesNegocioState> {
  final AnalisisRepositoryHn _repository;
  AnalisisImagenesNegocioCubit(this._repository)
      : super(AnalisisImagenesNegocioInitial());

  Future<void> createAnalisisFotoNegocio({
    required int numeroSolicitud,
    required String cedulaCliente,
    required String imagenNegocio,
    required String imagenNegocio2,
    required String imagenNegocio3,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) = await _repository.createAnalisisFotoNegocio(
        numeroSolicitud: numeroSolicitud,
        cedulaCliente: cedulaCliente,
        imagenNegocio: imagenNegocio,
        imagenNegocio2: imagenNegocio2,
        imagenNegocio3: imagenNegocio3,
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: msg));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
