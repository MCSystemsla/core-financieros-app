import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';
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
  ///
  /// También lee el historial de `GET /cartera/analisis-fiador/fiador-solicitud`
  /// (SPEC 10), que usa `MonedaCodigo`/`FrecuenciaCodigo` y trae los nombres.
  factory HistorialCredito.fromJson(Map<String, dynamic> json) {
    int integer(String key) => parseNum(json[key])?.toInt() ?? 0;
    String str(String key) => json[key]?.toString() ?? '';

    return HistorialCredito(
      id: parseNum(json['ID'])?.toInt(),
      uuid: const Uuid().v4(),
      entidad: str('Entidad'),
      monto: integer('Monto'),
      tipoMonedaCodigo: json['TipoMonedaCodigo'] != null
          ? str('TipoMonedaCodigo')
          : str('MonedaCodigo'),
      tipoFrecuenciaCodigo: json['TipoFrecuenciaCodigo'] != null
          ? str('TipoFrecuenciaCodigo')
          : str('FrecuenciaCodigo'),
      cuota: integer('Cuota'),
      saldo: integer('Saldo'),
      estadoCodigo: str('EstadoCodigo'),
      monedaNombre: str('MonedaNombre'),
      frecuenciaNombre: str('FrecuenciaNombre'),
      estadoNombre: str('EstadoNombre'),
      fechaDesembolso: parseDate(json['FechaDesembolso']) ?? DateTime.now(),
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
