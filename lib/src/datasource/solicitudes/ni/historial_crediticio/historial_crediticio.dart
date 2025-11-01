class HistorialCredito {
  final String uuid;
  final String entidad;
  final int monto;
  final String tipoMonedaCodigo;
  final String tipoFrecuenciaCodigo;
  final int cuota;
  final int saldo;
  final String estadoCodigo;

  HistorialCredito({
    required this.entidad,
    required this.monto,
    required this.tipoMonedaCodigo,
    required this.tipoFrecuenciaCodigo,
    required this.cuota,
    required this.saldo,
    required this.estadoCodigo,
    required this.uuid,
  });

  Map<String, dynamic> toJson() => {
        'Entidad': entidad,
        'Monto': monto,
        'TipoMonedaCodigo': tipoMonedaCodigo,
        'TipoFrecuenciaCodigo': tipoFrecuenciaCodigo,
        'Cuota': cuota,
        'Saldo': saldo,
        'EstadoCodigo': estadoCodigo,
      };
}
