import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'mejora_vivienda_state.dart';

class MejoraViviendaCubit extends Cubit<MejoraViviendaState> {
  final ResponsesRepository repository;
  MejoraViviendaCubit(this.repository) : super(MejoraViviendaInitial());
  final _logger = Logger();
  Future<void> sendAnswers() async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      await repository.mejoraViviendaAnswer(
          mejoraVivienda: MejoraViviendaAnswer(
        solicitudNuevamenorId: state.solicitudNuevamenorId!,
        username: state.username!,
        tieneTrabajo: state.tieneTrabajo!,
        database: state.database!,
        trabajoNegocioDescripcion: state.trabajoNegocioDescripcion!,
        tiempoActividad: state.tiempoActividad!,
        otrosIngresos: state.otrosIngresos!,
        otrosIngresosDescripcion: state.otrosIngresosDescripcion!,
        objOrigenCatalogoValorId: state.objOrigenCatalogoValorId!,
        objTipoComunidadId: state.objTipoComunidadId!,
        necesidadesComunidad: state.necesidadesComunidad!,
        personasCargo: state.personasCargo!,
        numeroHijos: state.numeroHijos!,
        edadHijos: state.edadHijos!,
        tipoEstudioHijos: state.tipoEstudioHijos!,
        motivoPrestamo: state.motivoPrestamo!,
        comoAyudara: state.comoAyudara!,
        planesFuturo: state.planesFuturo!,
        otrosDatosCliente: state.otrosDatosCliente!,
      ));
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
      _logger.e(e);
    }
  }
}
