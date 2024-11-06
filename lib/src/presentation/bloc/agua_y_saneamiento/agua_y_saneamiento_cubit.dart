import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/agua_y_saneamiento_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'agua_y_saneamiento_state.dart';

class AguaYSaneamientoCubit extends Cubit<AguaYSaneamientoState> {
  final ResponsesRepository repository;
  AguaYSaneamientoCubit(this.repository) : super(AguaYSaneamientoInitial());
  void saveAnswers({
    int? solicitudNuevamenorId,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    String? objOrigenCatalogoValorId,
    String? personasCargo,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    String? motivacionCredito,
    String? importanciaMejorarCondiciones,
    bool? cumpliriaPropuesta,
    String? explicacionCumpliriaPropuesta,
    String? motivoPrestamo,
    String? mejoraCalidadVida,
    String? siguienteProyectoCalidadVida,
    String? metasProximas,
    String? otrosDatosCliente,
  }) {
    emit(
      state.copyWith(
        tiempoActividad: tiempoActividad,
        otrosIngresos: otrosIngresos,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        objOrigenCatalogoValorId: objOrigenCatalogoValorId,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        motivacionCredito: motivacionCredito,
        importanciaMejorarCondiciones: importanciaMejorarCondiciones,
        cumpliriaPropuesta: cumpliriaPropuesta,
        explicacionCumpliriaPropuesta: explicacionCumpliriaPropuesta,
        motivoPrestamo: motivoPrestamo,
        mejoraCalidadVida: mejoraCalidadVida,
        siguienteProyectoCalidadVida: siguienteProyectoCalidadVida,
        metasProximas: metasProximas,
        otrosDatosCliente: otrosDatosCliente,
        solicitudNuevamenorId: solicitudNuevamenorId,
      ),
    );
  }

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await repository.aguaYSaneamientoAnswer(
        aguaSaneamientoModel: AguaSaneamientoModel(
          database: state.database,
          objSolicitudNuevamenorId: state.solicitudNuevamenorId,
          tieneTrabajo: state.tieneTrabajo,
          trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
          tiempoActividad: state.tiempoActividad,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          objOrigenCatalogoValorId: state.objOrigenCatalogoValorId,
          personasCargo: state.personasCargo,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          motivacionCredito: state.motivacionCredito,
          importanciaMejorarCondiciones: state.importanciaMejorarCondiciones,
          cumpliriaPropuesta: state.cumpliriaPropuesta,
          explicacionCumpliriaPropuesta: state.explicacionCumpliriaPropuesta,
          motivoPrestamo: state.motivoPrestamo,
          mejoraCalidadVida: state.mejoraCalidadVida,
          siguienteProyectoCalidadVida: state.siguienteProyectoCalidadVida,
          metasProximas: state.metasProximas,
          otrosDatosCliente: state.otrosDatosCliente,
        ),
      );
      if (!resp) {
        emit(state.copyWith(status: Status.error));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
