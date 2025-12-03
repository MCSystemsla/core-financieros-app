// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_articulo_cubit.dart';

class AnalisisArticuloState extends Equatable {
  final Status statusCreate;
  final Status status;
  final String errorMsg;
  final List<AnalisisGarantiaData> analisisGarantiaArticuloHn;
  const AnalisisArticuloState({
    this.status = Status.notStarted,
    this.statusCreate = Status.notStarted,
    this.errorMsg = '',
    this.analisisGarantiaArticuloHn = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        analisisGarantiaArticuloHn,
        statusCreate,
      ];

  AnalisisArticuloState copyWith({
    Status? statusCreate,
    Status? status,
    String? errorMsg,
    List<AnalisisGarantiaData>? analisisGarantiaArticuloHn,
  }) {
    return AnalisisArticuloState(
      statusCreate: statusCreate ?? this.statusCreate,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      analisisGarantiaArticuloHn:
          analisisGarantiaArticuloHn ?? this.analisisGarantiaArticuloHn,
    );
  }
}

final class AnalisisArticuloInitial extends AnalisisArticuloState {}
