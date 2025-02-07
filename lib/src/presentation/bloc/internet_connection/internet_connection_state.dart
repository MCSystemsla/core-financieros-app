// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_connection_cubit.dart';

class InternetConnectionState extends Equatable {
  final bool isConnected;
  final bool isCorrectNetwork;
  final String currentIp;
  const InternetConnectionState({
    this.isConnected = false,
    this.isCorrectNetwork = false,
    this.currentIp = 'N/A',
  });

  @override
  List<Object> get props => [isConnected, isCorrectNetwork, currentIp];

  InternetConnectionState copyWith({
    bool? isConnected,
    bool? isCorrectNetwork,
    String? currentIp,
  }) {
    return InternetConnectionState(
      isConnected: isConnected ?? this.isConnected,
      isCorrectNetwork: isCorrectNetwork ?? this.isCorrectNetwork,
      currentIp: currentIp ?? this.currentIp,
    );
  }
}

final class InternetConnectionInitial extends InternetConnectionState {}
