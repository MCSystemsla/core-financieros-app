// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_fiador_aval_cubit.dart';

class AnalisisFiadorAvalState extends Equatable {
  final Status status;
  final String errorMsg;
  final bool tieneFiador;
  final bool tieneAval;
  final bool tieneConyugue;
  final bool tieneCodeudor;
  const AnalisisFiadorAvalState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.tieneFiador = false,
    this.tieneAval = false,
    this.tieneConyugue = false,
    this.tieneCodeudor = false,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        tieneFiador,
        tieneAval,
        tieneConyugue,
        tieneCodeudor,
      ];

  AnalisisFiadorAvalState copyWith({
    Status? status,
    String? errorMsg,
    bool? tieneFiador,
    bool? tieneAval,
    bool? tieneConyugue,
    bool? tieneCodeudor,
  }) {
    return AnalisisFiadorAvalState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      tieneFiador: tieneFiador ?? this.tieneFiador,
      tieneAval: tieneAval ?? this.tieneAval,
      tieneConyugue: tieneConyugue ?? this.tieneConyugue,
      tieneCodeudor: tieneCodeudor ?? this.tieneCodeudor,
    );
  }
}

final class AnalisisFiadorAvalInitial extends AnalisisFiadorAvalState {}
