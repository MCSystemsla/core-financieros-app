import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/informacion_peps/informacion_peps_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'informacion_peps_hn_state.dart';

class InformacionPepsHnCubit extends Cubit<InformacionPepsHnState> {
  final SolicitudesCreditoHnRepository _repository;
  InformacionPepsHnCubit(this._repository) : super(InformacionPepsHnInitial());

  Future<void> createInformacionPeps() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.enviarInformacionPeps(
        informacionPeps: PepsInformacionHn(
          familiaresPeps: state.familiaresPeps,
          detallePeps: state.detallePeps,
          relacionPeps: state.relacionPeps,
          informacionPeps: InformacionPeps(
            negocioProveedores: state.negocioProveedores,
            numeroSolicitud: state.numeroSolicitud,
            servicioCredito: state.servicioCredito,
            servicioCuentaAhorro: state.servicioCuentaAhorro,
            servicioDpf: state.servicioDpf,
            servicioRemesa: state.servicioRemesa,
            servicioOtros: state.servicioOtros,
            negocioPorcentajeAccion: state.negocioPorcentajeAccion,
            negocioCantidadSucursal: state.negocioCantidadSucursal,
            negocioCiudadSucursales: state.negocioCiudadSucursales,
            negocioEsProveedorEstado: state.negocioEsProveedorEstado,
            negocioAdquirienteInstitucion: state.negocioAdquirienteInstitucion,
            pagoEfectivoDolar: state.pagoEfectivoDolar,
            pagoEfectivoLempira: state.pagoEfectivoLempira,
            pagoCheque: state.pagoCheque,
            pagoTctd: state.pagoTctd,
            pagoDepositoCuenta: state.pagoDepositoCuenta,
            pagoOtrosBancos: state.pagoOtrosBancos,
            manejaBienesPublicos: state.manejaBienesPublicos,
            descripcionBienesPublicos: state.descripcionBienesPublicos,
          ),
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void onFieldChanged(InformacionPepsHnState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void setNumeroSolicitud(int numeroSolicitud) {
    emit(state.copyWith(numeroSolicitud: numeroSolicitud));
  }

  void addDetallePep(DetallePep detallePep) {
    emit(state.copyWith(detallePeps: [...state.detallePeps, detallePep]));
  }

  void deleteDetallePep(String referenciaTemporal) {
    emit(state.copyWith(
      detallePeps: state.detallePeps
          .where((detalle) => detalle.familiarReferencia != referenciaTemporal)
          .toList(),
    ));
  }

  void updateDetallePep(DetallePep detallePep) {
    emit(state.copyWith(
      detallePeps: state.detallePeps
          .map(
            (detalle) =>
                detalle.familiarReferencia == detallePep.familiarReferencia
                    ? detallePep
                    : detalle,
          )
          .toList(),
    ));
  }

  void addFamiliarPep(FamiliaresPep familiarPep) {
    emit(
        state.copyWith(familiaresPeps: [...state.familiaresPeps, familiarPep]));
  }

  void deleteFamiliarPep(String referenciaTemporal) {
    emit(state.copyWith(
      familiaresPeps: state.familiaresPeps
          .where(
              (familiar) => familiar.referenciaTemporal != referenciaTemporal)
          .toList(),
    ));
  }

  void updateFamiliarPep(
      String referenciaTemporal, FamiliaresPep updatedFamiliar) {
    emit(state.copyWith(
      familiaresPeps: state.familiaresPeps
          .map((familiar) => familiar.referenciaTemporal == referenciaTemporal
              ? updatedFamiliar
              : familiar)
          .toList(),
    ));
  }

  void addRelacionPep(RelacionPep relacionPep) {
    emit(state.copyWith(relacionPeps: [...state.relacionPeps, relacionPep]));
  }

  void deleteRelacionPep(String uuid) {
    emit(state.copyWith(
      relacionPeps: state.relacionPeps
          .where((relacion) => relacion.uuid != uuid)
          .toList(),
    ));
  }

  void updateRelacionPep(RelacionPep relacionPep) {
    emit(state.copyWith(
      relacionPeps: state.relacionPeps
          .map((e) => e.uuid == relacionPep.uuid ? relacionPep : e)
          .toList(),
    ));
  }
}
