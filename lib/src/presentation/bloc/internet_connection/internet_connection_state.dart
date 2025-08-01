// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_connection_cubit.dart';

enum ConnectionStatus {
  checking,
  connected,
  disconnected,
  unKnown,
  handleOfflineActivation
}

class InternetConnectionState extends Equatable {
  final bool isConnected;
  final ConnectionStatus connectionStatus;
  final String lastCheck;
  const InternetConnectionState({
    this.isConnected = false,
    this.connectionStatus = ConnectionStatus.unKnown,
    this.lastCheck = '',
  });

  @override
  List<Object> get props => [
        isConnected,
        connectionStatus,
        lastCheck,
      ];

  InternetConnectionState copyWith({
    bool? isConnected,
    ConnectionStatus? connectionStatus,
    String? lastCheck,
  }) {
    return InternetConnectionState(
      isConnected: isConnected ?? this.isConnected,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      lastCheck: lastCheck ?? this.lastCheck,
    );
  }
}

final class InternetConnectionInitial extends InternetConnectionState {}
