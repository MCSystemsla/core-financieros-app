import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:network_info_plus/network_info_plus.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());

  Future<void> getInternetStatusConnection() async {
    const isInProdMode = bool.fromEnvironment('isProdMode');
    if (!isInProdMode) {
      emit(
        state.copyWith(
          currentIp: 'DEVMODE',
          isConnected: true,
          isCorrectNetwork: true,
        ),
      );
    }

    final isConnected = await InternetConnectionChecker().hasConnection;
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
