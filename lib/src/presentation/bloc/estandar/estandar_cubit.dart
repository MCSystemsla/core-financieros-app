import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/estandar_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'estandar_state.dart';

class EstandarCubit extends Cubit<EstandarState> {
  final ResponsesRepository repository;
  EstandarCubit(this.repository) : super(EstandarInitial());
  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOK, message) = await repository.estandar(
        estandarModel: EstandarModel(
          database: LocalStorage().database,
          objSolicitudNuevamenorId: state.objSolicitudNuevamenorId,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          objOrigenCatalogoValorId: state.objOrigenCatalogoValorId,
          personasCargo: state.personasCargo,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          inicioNegocio: DateTime.tryParse(state.inicioNegocio)!,
          apoyanNegocio: state.apoyanNegocio,
          cuantosApoyan: state.cuantosApoyan,
          publicitarNegocio: state.publicitarNegocio,
          negocioProximosAnios: state.negocioProximosAnios,
          motivoPrestamo: state.motivoPrestamo,
          comoMejoraVida: state.comoMejoraVida,
          planesFuturo: state.planesFuturo,
          otrosDatosCliente: state.otrosDatosCliente,
        ),
      );
      if (!isOK) {
        emit(state.copyWith(status: Status.error, errorMsg: message));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void saveAnswers({
    String? database,
    int? objSolicitudNuevamenorId,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objOrigenCatalogoValorId,
    int? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? inicioNegocio,
    bool? apoyanNegocio,
    String? cuantosApoyan,
    String? publicitarNegocio,
    String? negocioProximosAnios,
    String? motivoPrestamo,
    String? comoMejoraVida,
    String? planesFuturo,
    String? otrosDatosCliente,
  }) {
    emit(
      state.copyWith(
        database: database,
        objSolicitudNuevamenorId: objSolicitudNuevamenorId,
        otrosIngresos: otrosIngresos,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        objOrigenCatalogoValorId: objOrigenCatalogoValorId,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        inicioNegocio: inicioNegocio,
        apoyanNegocio: apoyanNegocio,
        cuantosApoyan: cuantosApoyan,
        publicitarNegocio: publicitarNegocio,
        negocioProximosAnios: negocioProximosAnios,
        motivoPrestamo: motivoPrestamo,
        comoMejoraVida: comoMejoraVida,
        planesFuturo: planesFuturo,
        otrosDatosCliente: otrosDatosCliente,
      ),
    );
  }
}
