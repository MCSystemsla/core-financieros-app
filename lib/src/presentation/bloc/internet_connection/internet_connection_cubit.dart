import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:network_info_plus/network_info_plus.dart';

part 'internet_connection_state.dart';

/// Cubit para gestionar el estado de la conexión a Internet.

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  InternetConnectionCubit() : super(InternetConnectionInitial()) {
    startMonitoring();
  }

  void startMonitoring() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      getInternetStatusConnection();
    });
  }

  /// Verifica el estado de la conexión a Internet.
  ///
  /// - En modo desarrollo (`isProdMode == false`), simula una conexión válida.
  /// - En producción (`isProdMode == true`), revisa si hay acceso a Internet y que este en modo Produccion,
  ///   el tipo de conectividad y si la red es válida.
  Future<void> getInternetStatusConnection() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    const isInProdMode = bool.fromEnvironment('isProdMode');
    if (!isInProdMode) {
      emit(
        state.copyWith(
          currentIp: 'DEVMODE',
          isConnected: isConnected,
          isCorrectNetwork: true,
        ),
      );
    }

    final connectivityResult = await Connectivity().checkConnectivity();
    final info = NetworkInfo();

    if (isConnected && isInProdMode) {
      if (_isValidPhoneConnection(connections: connectivityResult)) {
        final wifiIp = await info.getWifiIP();

        emit(state.copyWith(
          isConnected: true,
          isCorrectNetwork: wifiIp != null && _isValidNetwork(wifiIp: wifiIp),
          currentIp: wifiIp ?? 'Unknown IP',
        ));
        return;
      }
    }

    // Si no hay conexión o es una red inválida, actualiza el estado
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(state.copyWith(isConnected: false, isCorrectNetwork: false));
    }
  }

  /// Verifica si una dirección IP pertenece a una red válida.
  ///
  /// Se considera válida si la IP comienza con:
  /// - `172.17.5.`
  /// - `10.212.134.`
  /// - `172.16`
  ///

  bool _isValidNetwork({String? wifiIp}) {
    if (wifiIp == null) return false;
    return wifiIp.startsWith('172.17.5.') ||
        wifiIp.startsWith('10.212.134.') ||
        wifiIp.startsWith('172.16');
  }

  bool _isValidPhoneConnection({
    required List<ConnectivityResult> connections,
  }) {
    return connections.contains(ConnectivityResult.wifi) ||
        connections.contains(ConnectivityResult.mobile) ||
        connections.contains(ConnectivityResult.vpn);
  }
}
