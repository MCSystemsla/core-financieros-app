import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kiva_route_state.dart';

class KivaRouteCubit extends Cubit<KivaRouteState> {
  KivaRouteCubit() : super(KivaRouteInitial());

  void setCurrentRouteProduct({
    int? tableRowId,
    required String route,
    required String solicitudId,
    required String nombre,
    required String motivoAnterior,
    required String tipoSolicitud,
    required String numero,
    required int cantidadHijos,
    required String cedula,
    required String nombreFormularioKiva,
  }) {
    emit(state.copyWith(
      currentRoute: route,
      solicitudId: solicitudId,
      nombre: nombre,
      motivoAnterior: motivoAnterior,
      tipoSolicitud: tipoSolicitud,
      numero: numero,
      cantidadHijos: cantidadHijos,
      cedula: cedula,
      nombreFormularioKiva: nombreFormularioKiva,
    ));
    log('Solicitud ${state.solicitudId} - Route ${state.currentRoute}');
    log('CEDULA ${state.cedula} - Route ${state.currentRoute}');
    log('Nombre formulario Kiva${state.nombreFormularioKiva} - Route ${state.currentRoute}');
  }
}
