// ignore_for_file: unrelated_type_equality_checks, prefer_single_quotes

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());

  Future<void> getInternetStatusConnection() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    emit(state.copyWith(isConnected: isConnected));

    // Si hay red (Wi-Fi o datos móviles), verificar acceso a internet

    // if (isConnected) {
    //   if (connectivityResult == ConnectivityResult.mobile) {
    //     log("Conectado a internet mediante datos móviles.");
    //     emit(state.copyWith(isConnected: isConnected));
    //   } else if (connectivityResult == ConnectivityResult.wifi) {
    //     log("Conectado a internet mediante Wi-Fi.");
    //     emit(state.copyWith(isConnected: isConnected));
    //   }
    // } else {
    //   log("Red activa, pero sin conexión a internet.");
    // }

    // log('No hay conexion');
  }
}
