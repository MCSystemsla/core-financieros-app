import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

part 'internet_connection_state.dart';

/// Cubit para gestionar el estado de la conexión a Internet.

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());
  final _logger = Logger();

  /// Verifica el estado de la conexión a Internet.
  Future<void> getInternetStatusConnection() async {
    try {
      emit(state.copyWith(connectionStatus: ConnectionStatus.checking));
      final isConnected = await InternetConnectionChecker().hasConnection;

      final connectivityResult = await Connectivity().checkConnectivity();
      await Future.delayed(const Duration(seconds: 5));

      if (!isConnected) {
        emit(state.copyWith(
          isConnected: false,
          connectionStatus: ConnectionStatus.disconnected,
        ));
        return;
      }

      if (_isValidPhoneConnection(connections: connectivityResult)) {
        emit(state.copyWith(
          isConnected: true,
          connectionStatus: ConnectionStatus.connected,
        ));
        return;
      }

      // Si no hay conexión o es una red inválida, actualiza el estado
      // Si la red no es válida
      emit(state.copyWith(
        isConnected: false,
        connectionStatus: ConnectionStatus.disconnected,
      ));
    } catch (e) {
      _logger.e('Error al verificar la conexión a Internet: $e');
      emit(state.copyWith(
        isConnected: false,
        connectionStatus: ConnectionStatus.disconnected,
      ));
    }
  }

  bool _isValidPhoneConnection({
    required List<ConnectivityResult> connections,
  }) {
    return connections.contains(ConnectivityResult.wifi) ||
        connections.contains(ConnectivityResult.mobile);
  }
}
