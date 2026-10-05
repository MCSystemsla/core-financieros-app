class HistorialCredito {
  final int? id;
  final String uuid;
  final String entidad;
  final int monto;
  final String tipoMonedaCodigo;
  final String tipoFrecuenciaCodigo;
  final int cuota;
  final int saldo;
  final String estadoCodigo;
  final DateTime fechaDesembolso;
  final String monedaNombre;
  final String frecuenciaNombre;
  final String estadoNombre;

  HistorialCredito({
    this.id,
    this.monedaNombre = '',
    this.frecuenciaNombre = '',
    this.estadoNombre = '',
    required this.entidad,
    required this.monto,
    required this.tipoMonedaCodigo,
    required this.tipoFrecuenciaCodigo,
    required this.cuota,
    required this.saldo,
    required this.estadoCodigo,
    required this.uuid,
    required this.fechaDesembolso,
  });

  Map<String, dynamic> toJson() => {
        if (id != null) 'ID': id,
        'Entidad': entidad,
        'Monto': monto,
        'TipoMonedaCodigo': tipoMonedaCodigo,
        'TipoFrecuenciaCodigo': tipoFrecuenciaCodigo,
        'Cuota': cuota,
        'Saldo': saldo,
        'EstadoCodigo': estadoCodigo,
        'FechaDesembolso': fechaDesembolso.toUtc().toIso8601String(),
      };
}
