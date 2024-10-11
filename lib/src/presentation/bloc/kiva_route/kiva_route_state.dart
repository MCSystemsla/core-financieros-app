// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'kiva_route_cubit.dart';

class KivaRouteState extends Equatable {
  final String currentRoute;
  const KivaRouteState({
    this.currentRoute = '',
  });

  @override
  List<Object> get props => [currentRoute];

  KivaRouteState copyWith({
    String? currentRoute,
  }) {
    return KivaRouteState(
      currentRoute: currentRoute ?? this.currentRoute,
    );
  }
}

final class KivaRouteInitial extends KivaRouteState {}
