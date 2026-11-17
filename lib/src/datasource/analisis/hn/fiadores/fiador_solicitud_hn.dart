import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_hn.dart';

/// Fiador con vínculo activo en una solicitud HN, tal como lo devuelve
/// `GET /cartera/analisis-fiador/fiador-solicitud` (SPEC 10).
///
/// Los campos usan los mismos nombres que el body de
/// `POST /cartera/analisis-fiador/create`, así que se leen con
/// [AnalisisFiadoresHn.fromJson]. Cada catálogo trae además `...Nombre`, que se
/// lee del JSON crudo con [nombre].
class FiadorSolicitudHn {
  final int idFiador;
  final AnalisisFiadoresHn fiador;
  final Map<String, dynamic> raw;

  const FiadorSolicitudHn({
    required this.idFiador,
    required this.fiador,
    required this.raw,
  });

  factory FiadorSolicitudHn.fromJson(Map<String, dynamic> json) {
    return FiadorSolicitudHn(
      idFiador: parseNum(json['IdFiador'])?.toInt() ?? 0,
      fiador: AnalisisFiadoresHn.fromJson(json),
      raw: json,
    );
  }

  /// Nombre del catálogo `campo`, p. ej. `nombre('Municipio')` lee
  /// `MunicipioNombre`. Devuelve `''` si no viene.
  String nombre(String campo) => raw['${campo}Nombre']?.toString() ?? '';

  /// `Nombre1 Nombre2 Apellido1 Apellido2`, sin espacios dobles.
  String get nombreCompleto => [
        fiador.nombre1,
        fiador.nombre2,
        fiador.apellido1,
        fiador.apellido2,
      ].map((e) => e.trim()).where((e) => e.isNotEmpty).join(' ');

  String get tipoFiadorNombre => nombre('TipoFiador');
}
