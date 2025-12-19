// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_user_location_cubit.dart';

class AnalisisUserLocationState extends Equatable {
  final Status status;
  final String errorMsg;
  final String placeAddress;
  const AnalisisUserLocationState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.placeAddress = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        placeAddress,
      ];

  AnalisisUserLocationState copyWith({
    Status? status,
    String? errorMsg,
    String? placeAddress,
  }) {
    return AnalisisUserLocationState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      placeAddress: placeAddress ?? this.placeAddress,
    );
  }
}

final class AnalisisUserLocationInitial extends AnalisisUserLocationState {}
