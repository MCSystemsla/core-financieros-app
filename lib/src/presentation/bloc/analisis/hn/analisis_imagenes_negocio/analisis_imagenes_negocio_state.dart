// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_imagenes_negocio_cubit.dart';

class AnalisisImagenesNegocioState extends Equatable {
  final Status status;
  final String errorMsg;
  final int numeroSolicitud;
  final String cedulaCliente;
  final String imagenNegocio;
  final String imagenNegocio2;
  final String imagenNegocio3;
  const AnalisisImagenesNegocioState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.numeroSolicitud = 0,
    this.cedulaCliente = '',
    this.imagenNegocio = '',
    this.imagenNegocio2 = '',
    this.imagenNegocio3 = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        numeroSolicitud,
        cedulaCliente,
        imagenNegocio,
        imagenNegocio2,
        imagenNegocio3,
      ];

  AnalisisImagenesNegocioState copyWith({
    Status? status,
    String? errorMsg,
    int? numeroSolicitud,
    String? cedulaCliente,
    String? imagenNegocio,
    String? imagenNegocio2,
    String? imagenNegocio3,
  }) {
    return AnalisisImagenesNegocioState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      cedulaCliente: cedulaCliente ?? this.cedulaCliente,
      imagenNegocio: imagenNegocio ?? this.imagenNegocio,
      imagenNegocio2: imagenNegocio2 ?? this.imagenNegocio2,
      imagenNegocio3: imagenNegocio3 ?? this.imagenNegocio3,
    );
  }
}

final class AnalisisImagenesNegocioInitial
    extends AnalisisImagenesNegocioState {}
