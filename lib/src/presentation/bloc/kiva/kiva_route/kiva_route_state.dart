// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'kiva_route_cubit.dart';

class KivaRouteState extends Equatable {
  final String currentRoute;
  final String solicitudId;
  final String nombre;
  final String motivoAnterior;
  final String tipoSolicitud;
  final String numero;
  final int cantidadHijos;
  const KivaRouteState({
    this.currentRoute = '',
    this.solicitudId = '',
    this.nombre = '',
    this.motivoAnterior = '',
    this.tipoSolicitud = '',
    this.numero = '',
    this.cantidadHijos = 0,
  });

  @override
  List<Object> get props => [
        currentRoute,
        solicitudId,
        nombre,
        motivoAnterior,
        tipoSolicitud,
        numero,
        cantidadHijos
      ];

  KivaRouteState copyWith({
    String? currentRoute,
    String? solicitudId,
    String? nombre,
    String? motivoAnterior,
    String? tipoSolicitud,
    String? numero,
    int? cantidadHijos,
  }) {
    return KivaRouteState(
      currentRoute: currentRoute ?? this.currentRoute,
      solicitudId: solicitudId ?? this.solicitudId,
      nombre: nombre ?? this.nombre,
      motivoAnterior: motivoAnterior ?? this.motivoAnterior,
      tipoSolicitud: tipoSolicitud ?? this.tipoSolicitud,
      numero: numero ?? this.numero,
      cantidadHijos: cantidadHijos ?? this.cantidadHijos,
    );
  }
}

final class KivaRouteInitial extends KivaRouteState {}
