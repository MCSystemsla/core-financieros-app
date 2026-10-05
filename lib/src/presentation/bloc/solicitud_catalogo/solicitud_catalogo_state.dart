part of 'solicitud_catalogo_cubit.dart';

sealed class SolicitudCatalogoState extends Equatable {
  const SolicitudCatalogoState();

  @override
  List<Object> get props => [];
}

final class SolicitudCatalogoInitial extends SolicitudCatalogoState {}

final class SolicitudCatalogoLoading extends SolicitudCatalogoState {}

final class SolicitudCatalogoSuccess extends SolicitudCatalogoState {
  /// Códigos de catálogo que fallaron sin abortar la sincronización.
  final List<String> unsyncedCatalogos;

  const SolicitudCatalogoSuccess({this.unsyncedCatalogos = const []});

  @override
  List<Object> get props => [unsyncedCatalogos];
}

final class SolicitudCatalogoError extends SolicitudCatalogoState {
  final String error;

  const SolicitudCatalogoError({required this.error});

  @override
  List<Object> get props => [error];
}
