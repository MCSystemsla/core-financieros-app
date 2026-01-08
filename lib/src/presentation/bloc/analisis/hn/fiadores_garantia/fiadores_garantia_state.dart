// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fiadores_garantia_cubit.dart';

class FiadoresGarantiaState extends Equatable {
  final Status status;
  final List<FiadorGarantia> data;
  final String errorMsg;
  const FiadoresGarantiaState({
    this.status = Status.notStarted,
    this.data = const [],
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        data,
        errorMsg,
      ];

  FiadoresGarantiaState copyWith({
    Status? status,
    List<FiadorGarantia>? data,
    String? errorMsg,
  }) {
    return FiadoresGarantiaState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class FiadoresGarantiaInitial extends FiadoresGarantiaState {}
