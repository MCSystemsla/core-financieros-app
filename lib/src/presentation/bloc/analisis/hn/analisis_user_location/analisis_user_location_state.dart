// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_user_location_cubit.dart';

class AnalisisUserLocationState extends Equatable {
  final Status status;
  final Status statusCreation;
  final String errorMsg;
  final String placeAddress;
  const AnalisisUserLocationState({
    this.status = Status.notStarted,
    this.statusCreation = Status.notStarted,
    this.errorMsg = '',
    this.placeAddress = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        placeAddress,
        statusCreation,
      ];

  AnalisisUserLocationState copyWith({
    Status? status,
    Status? statusCreation,
    String? errorMsg,
    String? placeAddress,
  }) {
    return AnalisisUserLocationState(
      status: status ?? this.status,
      statusCreation: statusCreation ?? this.statusCreation,
      errorMsg: errorMsg ?? this.errorMsg,
      placeAddress: placeAddress ?? this.placeAddress,
    );
  }
}

final class AnalisisUserLocationInitial extends AnalisisUserLocationState {}
