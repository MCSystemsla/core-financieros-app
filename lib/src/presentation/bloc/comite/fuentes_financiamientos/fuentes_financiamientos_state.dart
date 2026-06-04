// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fuentes_financiamientos_cubit.dart';

class FuentesFinanciamientosState extends Equatable {
  final List<ComiteFuenteFinanciamientoData> data;
  final String errorMsg;
  final Status status;
  const FuentesFinanciamientosState({
    this.data = const [],
    this.errorMsg = '',
    this.status = Status.notStarted,
  });

  @override
  List<Object> get props => [
        data,
        errorMsg,
        status,
      ];

  FuentesFinanciamientosState copyWith({
    List<ComiteFuenteFinanciamientoData>? data,
    String? errorMsg,
    Status? status,
  }) {
    return FuentesFinanciamientosState(
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
    );
  }
}

final class FuentesFinanciamientosInitial extends FuentesFinanciamientosState {}
