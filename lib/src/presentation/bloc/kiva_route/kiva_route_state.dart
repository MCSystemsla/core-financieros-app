// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'kiva_route_cubit.dart';

class KivaRouteState extends Equatable {
  final String currentRoute;
  final String solicitudId;
  final String nombre;
  const KivaRouteState({
    this.currentRoute = '',
    this.solicitudId = '',
    this.nombre = '',
  });

  @override
  List<Object> get props => [currentRoute, solicitudId, nombre];

  KivaRouteState copyWith({
    String? currentRoute,
    String? solicitudId,
    String? nombre,
  }) {
    return KivaRouteState(
      currentRoute: currentRoute ?? this.currentRoute,
      solicitudId: solicitudId ?? this.solicitudId,
      nombre: nombre ?? this.nombre,
    );
  }
}

final class KivaRouteInitial extends KivaRouteState {}
