import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_coordinador.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'supervision_coordinador_state.dart';

class SupervisionCoordinadorCubit extends Cubit<SupervisionCoordinadorState> {
  final SupervisionesRepositoryHn _repository;
  SupervisionCoordinadorCubit(this._repository)
      : super(SupervisionCoordinadorInitial());

  Future<void> createSupervisonCoordinador(
      {required String tipoSolicitud}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createSupervisionCoordinador(
        createSupervisionCoordinador: CreateSupervisionCoordinador(
          tipoSolicitud: tipoSolicitud,
          database: state.database,
          numeroSolicitud: state.numeroSolicitud,
          buroCreditoBueno: state.buroCreditoBueno,
          buroCreditoRegular: state.buroCreditoRegular,
          buroCreditoMalas: state.buroCreditoMalas,
          referenciaComunidadBuena: state.referenciaComunidadBuena,
          referenciaComunidadMala: state.referenciaComunidadMala,
          referenciaComunidadRegular: state.referenciaComunidadRegular,
          referenciaComunidadBuena2: state.referenciaComunidadBuena2,
          referenciaComunidadMala2: state.referenciaComunidadMala2,
          referenciaComunidadRegular2: state.referenciaComunidadRegular2,
          tipoViviendaAlquilada: state.tipoViviendaAlquilada,
          tipoViviendaPropia: state.tipoViviendaPropia,
          tipoViviendaFamiliar: state.tipoViviendaFamiliar,
          conocimientoNegocioAlto: state.conocimientoNegocioAlto,
          conocimientoNegocioMedio: state.conocimientoNegocioMedio,
          conocimientoNegocioBajo: state.conocimientoNegocioBajo,
          nivelVentasAcordeSi: state.nivelVentasAcordeSi,
          nivelVentasAcordeNo: state.nivelVentasAcordeNo,
          nivelVentasAcordeNa: state.nivelVentasAcordeNa,
          costoVentaAdecuadoSi: state.costoVentaAdecuadoSi,
          costoVentaAdecuadoNo: state.costoVentaAdecuadoNo,
          costoVentaAdecuadoNa: state.costoVentaAdecuadoNa,
          realidadClienteSi: state.realidadClienteSi,
          realidadClienteNo: state.realidadClienteNo,
          realidadClienteNa: state.realidadClienteNa,
          razonCuotaSi: state.razonCuotaSi,
          razonCuotaNo: state.razonCuotaNo,
          razonCuotaNa: state.razonCuotaNa,
          razonCuotaMonto: state.razonCuotaMonto,
          razonEndeudamientoSi: state.razonEndeudamientoSi,
          razonEndeudamientoNo: state.razonEndeudamientoNo,
          razonEndeudamientoNa: state.razonEndeudamientoNa,
          garantiaRevisadaSi: state.garantiaRevisadaSi,
          garantiaRevisadaNo: state.garantiaRevisadaNo,
          garantiaRevisadaNa: state.garantiaRevisadaNa,
          fiadorRevisadoSi: state.fiadorRevisadoSi,
          fiadorRevisadoNo: state.fiadorRevisadoNo,
          fiadorRevisadoNa: state.fiadorRevisadoNa,
          monto: state.monto,
          plazo: state.plazo,
          productoCodigo: state.productoCodigo,
          frecuenciaCodigo: state.frecuenciaCodigo,
          infoSocioEconomica: state.infoSocioEconomica,
          infoFinanciera: state.infoFinanciera,
          recomendacionFinal: state.recomendacionFinal,
          nombreRefComunidad1: state.nombreRefComunidad1,
          direccionRefComunidad1: state.direccionRefComunidad1,
          nombreRefComunidad2: state.nombreRefComunidad2,
          direccionRefComunidad2: state.direccionRefComunidad2,
          tiempoNegocio: state.tiempoNegocio,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMsg: e.optionalMsg,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }

  void onFieldChanged(SupervisionCoordinadorState Function() copyWithFn) {
    emit(copyWithFn());
    // autoSaveHelper.trigger();
  }

  void setDataFromSolicitud({required int numeroSolicitud}) {
    emit(
      state.copyWith(
        numeroSolicitud: numeroSolicitud,
      ),
    );
  }
}
