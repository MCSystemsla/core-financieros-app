// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_create_servicios_cubit.dart';

class ComiteCreateServiciosState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<ServicioData> servicios;
  const ComiteCreateServiciosState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.servicios = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        servicios,
      ];

  ComiteCreateServiciosState copyWith({
    Status? status,
    String? errorMsg,
    List<ServicioData>? servicios,
  }) {
    return ComiteCreateServiciosState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      servicios: servicios ?? this.servicios,
    );
  }
}

final class ComiteCreateServiciosInitial extends ComiteCreateServiciosState {}
