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

  Future<void> comiteAprobacion({
    required String monto,
    required double porcentajeComision,
    required double montoSeguro,
    required double tasaInteresCorriente,
    required double tasaInteresMoratorio,
    required double montoSinComision,
    required double seguoMemorialMensual,
    required double porcentajeSaldoDeudorAprobado,
    required double montoTelemedicinaAprobada,
    required double seguroMapfre,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    final montoInt = double.tryParse(monto) ?? 0;
    final nuevaMenorMil = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'MENORMIL');
    final nuevaMenorMilMonto = int.tryParse(nuevaMenorMil!.valor) ?? 0;
    final isMenorMil = montoInt <= nuevaMenorMilMonto;
    try {
      final msg = await _repository.crearAprobacion(
          data: ComiteAprobacion(
        numeroSolicitud: state.numeroSolicitud,
        observacion: state.observacion,
        formaPagoCodigo: state.fromaPagoCodigo,
        tipoSolicitudCodigo: state.tipoSolicitudCodigo,
        productoCodigo: state.productoCodigo,
        isMenorMil: isMenorMil,
        modificaActa: ModificaActa(
          monto: state.monto,
          montoSeguro: montoSeguro,
          porcentajeComision: porcentajeComision,
          plazo: state.plazo,
          sectorCodigo: state.sectorCodigo,
          actividadCodigo: state.actividadCodigo,
          fuenteFinanciamientoCodigo: state.fuenteFinanciamientoCodigo,
          tasaInteresCorriente: tasaInteresCorriente,
          tasaInteresMoratorio: tasaInteresMoratorio,
          monedaDesembolsoCodigo: state.monedaDesembolsoCodigo,
          tipoDesembolsoCodigo: state.tipoDesembolsoCodigo,
          promotorId: state.promotorId,
          esReestructurado: state.esReestructurado,
          comisionFinanciada: state.comisionFinanciada,
          cuotaNivelada: state.cuotaNivelada,
          montoSinComision: montoSinComision,
          periodoGracia: state.periodoGracia,
          esRetencion: state.esRetencion,
          seguroMemorialMensual: seguoMemorialMensual,
          porcentajeSaldoDeudorAprobado: porcentajeSaldoDeudorAprobado,
          montoTelemedicinaAprobada: montoTelemedicinaAprobada,
          porcentajeAgricolaAprobado: state.porcentajeAgricolaAprobado,
          tasaMillarSeguroMapfre: seguroMapfre,
          numeroBienAdj: state.numeroBienAdj,
          tipoCreditoNombre: state.tipoCreditoNombre,
          tipoProgramaCodigo: state.tipoProgramaCodigo,
        ),
        insertaAprobacion: InsertaAprobacion(
          estadoSolicitudCodigo: state.estadoSolicitudCodigo,
          periodicidadPrinicipalCodigo: state.periodicidadPrinicipalCodigo,
          periodicidadInteresCodigo: state.periodicidadInteresCodigo,
          alVencimiento: state.alVencimiento,
          tipoComiteAprobacionCodigo: state.tipoComiteAprobacionCodigo,
          aprobacionDigital: state.aprobacionDigital,
          esRecalculado: state.esRecalculado,
        ),
      ));
      emit(state.copyWith(status: Status.done, respMsg: msg));
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
