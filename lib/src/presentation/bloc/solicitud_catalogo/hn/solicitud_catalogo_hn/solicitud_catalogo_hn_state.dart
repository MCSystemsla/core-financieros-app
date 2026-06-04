// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_catalogo_hn_cubit.dart';

class SolicitudCatalogoHnState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<String> unsyncedCatalogos;
  const SolicitudCatalogoHnState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.unsyncedCatalogos = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        unsyncedCatalogos,
      ];

  SolicitudCatalogoHnState copyWith({
    Status? status,
    String? errorMsg,
    List<String>? unsyncedCatalogos,
  }) {
    return SolicitudCatalogoHnState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      unsyncedCatalogos: unsyncedCatalogos ?? this.unsyncedCatalogos,
    );
  }
}

final class SolicitudCatalogoHnInitial extends SolicitudCatalogoHnState {}
