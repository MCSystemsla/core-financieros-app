import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/migrantes_ecomicos.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'migrantes_economicos_state.dart';

class MigrantesEconomicosCubit extends Cubit<MigrantesEconomicosState> {
  final ResponsesRepository _responsesRepository;
  MigrantesEconomicosCubit(this._responsesRepository)
      : super(MigrantesEconomicosInitial());

  void sendMigrantesEconomicos() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isok, msg) = await _responsesRepository.migrantesEconomicos(
        migrantesEconmicos: MigrantesEconomicos(
          database: LocalStorage().database,
          objSolicitudNuevamenorId: state.objSolicitudNuevamenorId,
          tieneTrabajo: state.tieneTrabajo,
          trabajoNegocioDescripcion: state.trabajoNegocioDescripcion,
          tiempoActividad: state.tiempoActividad,
          otrosIngresos: state.otrosIngresos,
          otrosIngresosDescripcion: state.otrosIngresosDescripcion,
          personasCargo: state.personasCargo,
          objOrigenUbicacionGeograficaId: state.objOrigenUbicacionGeograficaId,
          motivoDejarPais: state.motivoDejarPais,
          situacionMigratoria: state.situacionMigratoria,
          dedicabaPaisOrigen: state.dedicabaPaisOrigen,
          vivePaisActual: state.vivePaisActual,
          numeroHijos: state.numeroHijos,
          edadHijos: state.edadHijos,
          tipoEstudioHijos: state.tipoEstudioHijos,
          enviaRemesas: state.enviaRemesas,
          enviaRemesasExplicacion: state.enviaRemesasExplicacion,
          quienApoya: state.quienApoya,
          fortalecerIngresos: state.fortalecerIngresos,
          fortalecerIngresosExplicacion: state.fortalecerIngresosExplicacion,
          metasFuturo: state.metasFuturo,
          motivoPrestamo: state.motivoPrestamo,
          ayudaMejorarCondiciones: state.ayudaMejorarCondiciones,
          ayudaMejorarCondicionesExplicacion:
              state.ayudaMejorarCondicionesExplicacion,
          propositosProximos: state.propositosProximos,
          piensaRegresar: state.piensaRegresar,
          otrosDatosCliente: state.otrosDatosCliente,
        ),
      );
      if (!isok) {
        emit(state.copyWith(status: Status.error, errorMsg: msg));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void saveAnswers({
    int? objSolicitudNuevamenorId,
    bool? tieneTrabajo,
    String? trabajoNegocioDescripcion,
    int? tiempoActividad,
    bool? otrosIngresos,
    String? otrosIngresosDescripcion,
    int? personasCargo,
    String? objOrigenUbicacionGeograficaId,
    String? motivoDejarPais,
    String? situacionMigratoria,
    String? dedicabaPaisOrigen,
    String? vivePaisActual,
    int? numeroHijos,
    String? edadHijos,
    String? tipoEstudioHijos,
    bool? enviaRemesas,
    String? enviaRemesasExplicacion,
    String? quienApoya,
    bool? fortalecerIngresos,
    String? fortalecerIngresosExplicacion,
    String? metasFuturo,
    String? motivoPrestamo,
    bool? ayudaMejorarCondiciones,
    String? ayudaMejorarCondicionesExplicacion,
    String? propositosProximos,
    String? piensaRegresar,
    String? otrosDatosCliente,
  }) {
    emit(state.copyWith(
      objSolicitudNuevamenorId: objSolicitudNuevamenorId,
      tieneTrabajo: tieneTrabajo,
      trabajoNegocioDescripcion: trabajoNegocioDescripcion,
      tiempoActividad: tiempoActividad,
      otrosIngresos: otrosIngresos,
      otrosIngresosDescripcion: otrosIngresosDescripcion,
      personasCargo: personasCargo,
      objOrigenUbicacionGeograficaId: objOrigenUbicacionGeograficaId,
      motivoDejarPais: motivoDejarPais,
      situacionMigratoria: situacionMigratoria,
      dedicabaPaisOrigen: dedicabaPaisOrigen,
      vivePaisActual: vivePaisActual,
      numeroHijos: numeroHijos,
      edadHijos: edadHijos,
      tipoEstudioHijos: tipoEstudioHijos,
      enviaRemesas: enviaRemesas,
      enviaRemesasExplicacion: enviaRemesasExplicacion,
      quienApoya: quienApoya,
      fortalecerIngresos: fortalecerIngresos,
      fortalecerIngresosExplicacion: fortalecerIngresosExplicacion,
      metasFuturo: metasFuturo,
      motivoPrestamo: motivoPrestamo,
      ayudaMejorarCondiciones: ayudaMejorarCondiciones,
      ayudaMejorarCondicionesExplicacion: ayudaMejorarCondicionesExplicacion,
      propositosProximos: propositosProximos,
      piensaRegresar: piensaRegresar,
      otrosDatosCliente: otrosDatosCliente,
    ));
  }
}
