/// Solicitud NI creada offline, todavía sin número, cuyo producto lleva
/// formulario Kiva (SPEC 09).
class KivaSolicitudModel {
  final String uuid;
  final String nombre;
  final String nombreFormularioKiva;
  final int cantidadHijos;
  final String cedula;

  /// Mismos valores que `toTypeFormId()`: `NUEVAMENOR`, `ASAL` o `REPRESTAMO`.
  final String tipoSolicitud;

  /// `true` si ya hay un formulario Kiva local con `solicitudCreditoId == uuid`.
  final bool kivaLlenado;

  KivaSolicitudModel({
    required this.uuid,
    required this.nombre,
    required this.nombreFormularioKiva,
    required this.cantidadHijos,
    this.cedula = '',
    this.tipoSolicitud = '',
    this.kivaLlenado = false,
  });

  KivaSolicitudModel copyWith({bool? kivaLlenado}) {
    return KivaSolicitudModel(
      uuid: uuid,
      nombre: nombre,
      nombreFormularioKiva: nombreFormularioKiva,
      cantidadHijos: cantidadHijos,
      cedula: cedula,
      tipoSolicitud: tipoSolicitud,
      kivaLlenado: kivaLlenado ?? this.kivaLlenado,
    );
  }
}
