// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'kiva_route_cubit.dart';

class KivaRouteState extends Equatable {
  final String currentRoute;
  final String solicitudId;
  const KivaRouteState({
    this.currentRoute = '',
    this.solicitudId = '',
  });

  @override
  List<Object> get props => [currentRoute, solicitudId];

  KivaRouteState copyWith({
    String? currentRoute,
    String? solicitudId,
  }) {
    return KivaRouteState(
      currentRoute: currentRoute ?? this.currentRoute,
      solicitudId: solicitudId ?? this.solicitudId,
    );
  }
}

final class KivaRouteInitial extends KivaRouteState {}
