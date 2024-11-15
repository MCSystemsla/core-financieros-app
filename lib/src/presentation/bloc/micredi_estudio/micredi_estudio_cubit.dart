import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/micredi_estudio_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'micredi_estudio_state.dart';

class MicrediEstudioCubit extends Cubit<MicrediEstudioState> {
  final ResponsesRepository repository;
  MicrediEstudioCubit(this.repository) : super(MicrediEstudioInitial());

  Future<void> sendAnswers() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, message) = await repository.miCrediEstudioAnswer(
        miCrediEstudioModel: MiCrediEstudioModel(
          database: LocalStorage().database,
          objSolicitudNuevamenorId: state.objSolicitudNuevamenorId,
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
          carrera: state.carrera,
          tiempoCarrera: state.tiempoCarrera,
          universidad: state.universidad,
          motivoCarrera: state.motivoCarrera,
          relizandoProfesionalmente: state.relizandoProfesionalmente,
          explicacionRelizandoProfesionalmente:
              state.explicacionRelizandoProfesionalmente,
          quienApoya: state.quienApoya,
          ocupacionPadres: state.ocupacionPadres,
          motivoPrestamo: state.motivoPrestamo,
          comoAyudaCrecer: state.comoAyudaCrecer,
          optarOtroEstudio: state.optarOtroEstudio,
          cualEstudio: state.cualEstudio,
          planFuturo: state.planFuturo,
          aspiraLaboralmente: state.aspiraLaboralmente,
          otrosDatosCliente: state.otrosDatosCliente,
        ),
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMsg: message));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void saveAnswers({
    Status? status,
    String? database,
    int? objSolicitudNuevamenorId,
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
    String? carrera,
    int? tiempoCarrera,
    String? universidad,
    String? motivoCarrera,
    bool? relizandoProfesionalmente,
    String? explicacionRelizandoProfesionalmente,
    String? quienApoya,
    String? ocupacionPadres,
    String? motivoPrestamo,
    String? comoAyudaCrecer,
    bool? optarOtroEstudio,
    String? cualEstudio,
    String? planFuturo,
    String? aspiraLaboralmente,
    String? otrosDatosCliente,
  }) {
    emit(
      state.copyWith(
        tieneTrabajo: tieneTrabajo,
        trabajoNegocioDescripcion: trabajoNegocioDescripcion,
        tiempoActividad: tiempoActividad,
        otrosIngresos: otrosIngresos,
        otrosIngresosDescripcion: otrosIngresosDescripcion,
        objOrigenCatalogoValorId: objOrigenCatalogoValorId,
        personasCargo: personasCargo,
        numeroHijos: numeroHijos,
        edadHijos: edadHijos,
        tipoEstudioHijos: tipoEstudioHijos,
        carrera: carrera,
        tiempoCarrera: tiempoCarrera,
        universidad: universidad,
        motivoCarrera: motivoCarrera,
        relizandoProfesionalmente: relizandoProfesionalmente,
        explicacionRelizandoProfesionalmente:
            explicacionRelizandoProfesionalmente,
        quienApoya: quienApoya,
        ocupacionPadres: ocupacionPadres,
        motivoPrestamo: motivoPrestamo,
        comoAyudaCrecer: comoAyudaCrecer,
        optarOtroEstudio: optarOtroEstudio,
        cualEstudio: cualEstudio,
        planFuturo: planFuturo,
        aspiraLaboralmente: aspiraLaboralmente,
        otrosDatosCliente: otrosDatosCliente,
        objSolicitudNuevamenorId: objSolicitudNuevamenorId,
      ),
    );
  }
}
