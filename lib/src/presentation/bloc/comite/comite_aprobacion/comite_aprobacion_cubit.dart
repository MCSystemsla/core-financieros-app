import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_aprobacion.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'comite_aprobacion_state.dart';

class ComiteAprobacionCubit extends Cubit<ComiteAprobacionState> {
  final ComiteRepositoryHN _repository;
  ComiteAprobacionCubit(this._repository) : super(ComiteAprobacionInitial());

  Future<void> comiteAprobacion({required String monto}) async {
    emit(state.copyWith(status: Status.inProgress));
    final montoInt = double.tryParse(monto) ?? 0;
    final nuevaMenorMil = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'MENORMIL');
    final nuevaMenorMilMonto = int.tryParse(nuevaMenorMil!.valor) ?? 0;
    final isMenorMil = montoInt <= nuevaMenorMilMonto;
    try {
      await _repository.crearAprobacion(
        data: ComiteAprobacion(
          isMenorMil: isMenorMil,
          esRecalculado: state.esRecalculado,
          alVencimiento: state.alVencimiento,
          aprobacionDigital: state.aprobacionDigital,
          numeroSolicitud: state.numeroSolicitud,
          tipoSolicitudCodigo: state.tipoSolicitudCodigo,
          estadoSolicitudCodigo: state.estadoSolicitudCodigo,
          fromaPagoCodigo: state.fromaPagoCodigo,
          periodicidadPrinicipalCodigo: state.periodicidadPrinicipalCodigo,
          periodicidadInteresCodigo: state.periodicidadInteresCodigo,
          fechaAprobacion: DateTime.tryParse(state.fechaAprobacion),
          observacion: state.observacion,
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

  void onFieldChanged(ComiteAprobacionState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void setNumeroSolicitudAndTipoSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) {
    emit(
      state.copyWith(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitudCodigo: tipoSolicitud,
      ),
    );
  }
}
