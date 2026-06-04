// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tipos_credito_cubit.dart';

class TiposCreditoState extends Equatable {
  final List<TipoCreditoData> data;
  final String errorMsg;
  final Status status;
  const TiposCreditoState({
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

  TiposCreditoState copyWith({
    List<TipoCreditoData>? data,
    String? errorMsg,
    Status? status,
  }) {
    return TiposCreditoState(
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
    );
  }
}

final class TiposCreditoInitial extends TiposCreditoState {}
