import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_aprobacion.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'comite_aprobacion_state.dart';

class ComiteAprobacionCubit extends Cubit<ComiteAprobacionState> {
  final ComiteRepositoryHN _repository;
  ComiteAprobacionCubit(this._repository) : super(ComiteAprobacionInitial());

  Future<void> comiteAprobacion() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.crearAprobacion(
        data: ComiteAprobacion(
          isMenorMil: state.isMenorMil,
          esRecalculado: state.esRecalculado,
          alVencimiento: state.alVencimiento,
          estadoSolicitudCodigo: state.estadoSolicitudCodigo,
          database: state.database,
          numeroSolicitud: state.numeroSolicitud,
          fromaPagoCodigo: state.fromaPagoCodigo,
          periodicidadPrinicipalCodigo: state.periodicidadPrinicipalCodigo,
          periodicidadInteresCodigo: state.periodicidadInteresCodigo,
          tipoSolicitudCodigo: state.tipoSolicitudCodigo,
          fechaAprobacion: DateTime.parse(state.fechaAprobacion),
          observacion: state.observacion,
          aprobacionDigital: state.aprobacionDigital,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
