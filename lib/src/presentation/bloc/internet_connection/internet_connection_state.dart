// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_connection_cubit.dart';

class InternetConnectionState extends Equatable {
  final bool isConnected;
  const InternetConnectionState({
    this.isConnected = false,
  });

  @override
  List<Object> get props => [isConnected];

  InternetConnectionState copyWith({
    bool? isConnected,
  }) {
    return InternetConnectionState(
      isConnected: isConnected ?? this.isConnected,
    );
  }
}

final class InternetConnectionInitial extends InternetConnectionState {}
