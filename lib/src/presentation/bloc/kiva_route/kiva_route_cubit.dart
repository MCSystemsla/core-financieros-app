import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kiva_route_state.dart';

class KivaRouteCubit extends Cubit<KivaRouteState> {
  KivaRouteCubit() : super(KivaRouteInitial());

  void setCurrentRouteProduct({
    required String route,
    required String solicitudId,
    required String nombre,
  }) {
    emit(state.copyWith(
      currentRoute: route,
      solicitudId: solicitudId,
      nombre: nombre,
    ));
    log('Solicitud ${state.solicitudId} - Route ${state.currentRoute}');
  }
}
