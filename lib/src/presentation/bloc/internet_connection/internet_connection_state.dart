// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_connection_cubit.dart';

enum ConnectionStatus { checking, connected, disconnected }

class InternetConnectionState extends Equatable {
  final bool isConnected;
  final String currentIp;
  final ConnectionStatus connectionStatus;
  const InternetConnectionState({
    this.isConnected = false,
    this.currentIp = 'N/A',
    this.connectionStatus = ConnectionStatus.checking,
  });

  @override
  List<Object> get props => [
        isConnected,
        currentIp,
        connectionStatus,
      ];

  InternetConnectionState copyWith({
    bool? isConnected,
    String? currentIp,
    ConnectionStatus? connectionStatus,
  }) {
    return InternetConnectionState(
      isConnected: isConnected ?? this.isConnected,
      currentIp: currentIp ?? this.currentIp,
      connectionStatus: connectionStatus ?? this.connectionStatus,
    );
  }
}

final class InternetConnectionInitial extends InternetConnectionState {}
