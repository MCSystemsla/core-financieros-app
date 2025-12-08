// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_solicitud_cubit.dart';

class ComiteSolicitudState extends Equatable {
  final Status status;
  final String errorMsg;
  final ComiteSolicitudResponse data;
  const ComiteSolicitudState({
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.data = const ComiteSolicitudResponse(
      data: ComiteSolicitudData(
        actaNumero: 0,
        numeroSolicitud: '',
        nombreCompletoCliente: '',
        tasaInteresCorriente: 0,
        tasaInteresMoratorio: 0,
        plazoSolicitud: 0,
        monto: 0,
        tasaComision: 0,
        montoSinComision: 0,
        monedaCodigo: '',
        tipoDesembolsoCodigo: '',
        estadoComiteCodigo: '',
        formaDePagoCodigo: '',
        periodicidadCodigo: '',
        sectorCodigo: '',
        actividadCodigo: '',
        nombrePromotor: '',
        fuenteFinanciamientoCodigo: '',
        periodoGracia: 0,
        tipoCreditoNombre: '',
        tipoProgramaCodigo: '',
        observacion: '',
        tasaSaldoDeudor: 0,
      ),
    ),
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        data,
      ];

  ComiteSolicitudState copyWith({
    Status? status,
    String? errorMsg,
    ComiteSolicitudResponse? data,
  }) {
    return ComiteSolicitudState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      data: data ?? this.data,
    );
  }
}

final class ComiteSolicitudInitial extends ComiteSolicitudState {}
