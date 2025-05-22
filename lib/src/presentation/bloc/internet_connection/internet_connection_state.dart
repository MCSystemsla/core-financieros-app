// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_connection_cubit.dart';

enum ConnectionStatus { checking, connected, disconnected, unKnown }

class InternetConnectionState extends Equatable {
  final bool isConnected;
  final ConnectionStatus connectionStatus;
  const InternetConnectionState({
    this.isConnected = false,
    this.connectionStatus = ConnectionStatus.unKnown,
  });

  @override
  List<Object> get props => [
        isConnected,
        connectionStatus,
      ];

  InternetConnectionState copyWith({
    bool? isConnected,
    ConnectionStatus? connectionStatus,
  }) {
    return InternetConnectionState(
      isConnected: isConnected ?? this.isConnected,
      connectionStatus: connectionStatus ?? this.connectionStatus,
    );
  }
}

final class InternetConnectionInitial extends InternetConnectionState {}
