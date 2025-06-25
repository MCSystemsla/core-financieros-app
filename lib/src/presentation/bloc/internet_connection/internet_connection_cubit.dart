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
    try {
      emit(state.copyWith(connectionStatus: ConnectionStatus.checking));
      final isReachable = await _hasValidInternetAccess();

      await Future.delayed(const Duration(seconds: 5));

      if (!isReachable) {
        emit(state.copyWith(
          isConnected: false,
          connectionStatus: ConnectionStatus.disconnected,
        ));
        return;
      }
      emit(state.copyWith(
        isConnected: true,
        connectionStatus: ConnectionStatus.connected,
      ));
      return;
    } catch (e) {
      _logger.e('Error al verificar la conexión a Internet: $e');
      emit(state.copyWith(
        isConnected: false,
        connectionStatus: ConnectionStatus.disconnected,
      ));
    }
  }

  Future<bool> _hasValidInternetAccess() async {
    log('Checking internet access...');
    try {
      final response = await http
          .get(
            Uri.parse('https://www.google.com/generate_204'),
          )
          .timeout(const Duration(seconds: 5));
      log('HTTP response status code: ${response.statusCode}');
      return response.statusCode == 204;
    } catch (_) {
      return false;
    }
  }
}
