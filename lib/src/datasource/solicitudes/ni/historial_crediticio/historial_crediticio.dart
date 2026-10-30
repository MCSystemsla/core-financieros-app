import 'package:uuid/uuid.dart';

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

  /// Inverso de [toJson]. Genera un `uuid` nuevo porque [toJson] no lo manda.
  factory HistorialCredito.fromJson(Map<String, dynamic> json) {
    int integer(String key) => (json[key] as num?)?.toInt() ?? 0;
    final fechaDesembolso = json['FechaDesembolso'] as String?;

    return HistorialCredito(
      id: (json['ID'] as num?)?.toInt(),
      uuid: const Uuid().v4(),
      entidad: json['Entidad'] as String? ?? '',
      monto: integer('Monto'),
      tipoMonedaCodigo: json['TipoMonedaCodigo'] as String? ?? '',
      tipoFrecuenciaCodigo: json['TipoFrecuenciaCodigo'] as String? ?? '',
      cuota: integer('Cuota'),
      saldo: integer('Saldo'),
      estadoCodigo: json['EstadoCodigo'] as String? ?? '',
      fechaDesembolso: fechaDesembolso == null
          ? DateTime.now()
          : DateTime.parse(fechaDesembolso),
    );
  }

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
