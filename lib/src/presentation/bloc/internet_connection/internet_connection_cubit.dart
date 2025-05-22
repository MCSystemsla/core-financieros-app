import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_connection_state.dart';

/// Cubit para gestionar el estado de la conexión a Internet.

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());

  /// Verifica el estado de la conexión a Internet.
  Future<void> getInternetStatusConnection() async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.checking));
    await Future.delayed(const Duration(seconds: 5));
    final isConnected = await InternetConnectionChecker().hasConnection;

    final connectivityResult = await Connectivity().checkConnectivity();

    if (isConnected) {
      if (_isValidPhoneConnection(connections: connectivityResult)) {
        emit(state.copyWith(
          isConnected: isConnected,
          connectionStatus: ConnectionStatus.connected,
        ));
        return;
      }
    }

    // Si no hay conexión o es una red inválida, actualiza el estado
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(state.copyWith(
        isConnected: false,
        connectionStatus: ConnectionStatus.disconnected,
      ));
    }
  }

  /// Verifica si una dirección IP pertenece a una red válida.
  ///
  /// Se considera válida si la IP comienza con:
  /// - `172.17.5.`
  /// - `10.212.134.`
  /// - `172.16`
  ///

  // bool _isValidNetwork({String? wifiIp}) {
  //   if (wifiIp == null) return false;
  //   return wifiIp.startsWith('172.17.5.') ||
  //       wifiIp.startsWith('10.212.134.') ||
  //       wifiIp.startsWith('172.16');
  // }

  bool _isValidPhoneConnection({
    required List<ConnectivityResult> connections,
  }) {
    return connections.contains(ConnectivityResult.wifi) ||
        connections.contains(ConnectivityResult.mobile) ||
        connections.contains(ConnectivityResult.vpn);
  }
}
