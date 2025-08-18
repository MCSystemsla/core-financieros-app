import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
part 'internet_connection_state.dart';

/// Cubit para gestionar el estado de la conexión a Internet.
class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());
  final _logger = Logger();

  Future<void> getInternetStatusConnection() async {
    emit(state.copyWith(connectionStatus: ConnectionStatus.checking));
    final isReachable = await _hasValidInternetAccess();
    try {
      await Future.delayed(const Duration(seconds: 3));

      if (!isReachable) {
        emit(state.copyWith(
          isConnected: false,
          connectionStatus: ConnectionStatus.disconnected,
          lastCheck: DateTime.now().toIso8601String(),
        ));
        return;
      }
      emit(state.copyWith(
        isConnected: true,
        connectionStatus: ConnectionStatus.connected,
        lastCheck: DateTime.now().toIso8601String(),
      ));
      return;
    } catch (e) {
      _logger.e('Error al verificar la conexión a Internet: $e');
      emit(state.copyWith(
        isConnected: false,
        connectionStatus: ConnectionStatus.disconnected,
        lastCheck: DateTime.now().toIso8601String(),
      ));
    }
  }

  Future<bool> _hasValidInternetAccess() async {
    log('Checking internet access...');
    try {
      final response = await http
          .get(
            Uri.parse('https://clients3.google.com/generate_204'),
          )
          .timeout(const Duration(seconds: 15));
      log('HTTP response status code: ${response.statusCode}');
      return response.statusCode == 204;
    } catch (_) {
      return false;
    }
  }

  void makeToOfflineMode() {
    emit(
      state.copyWith(
        connectionStatus: ConnectionStatus.handleOfflineActivation,
        isConnected: false,
        lastCheck: DateTime.now().toIso8601String(),
      ),
    );
  }
}
