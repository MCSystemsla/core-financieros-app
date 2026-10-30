import 'package:objectbox/objectbox.dart';

/// Borrador de análisis HN de una solicitud creada offline que todavía no
/// tiene número.
///
/// Sus datos (análisis, plan de inversión, fiadores, imágenes y ubicación) se
/// guardan en las tablas de siempre con `numeroSolicitud` = [numeroProvisional].
/// Hay como máximo uno por `userId` + `cedula` + `tipoSolicitud`. Al vincularlo
/// con la solicitud AUT, sus datos pasan al número real y la fila se borra.
@Entity()
class AnalisisBorradorSinNumeroHnLocalDb {
  @Id()
  int id = 0;
  @Index()
  String solicitudLocalUuid;
  String userId;
  String cedula;
  String tipoSolicitud;
  double monto;
  String nombreCompleto;
  @Property(type: PropertyType.date)
  DateTime fechaCreacion;

  AnalisisBorradorSinNumeroHnLocalDb({
    required this.solicitudLocalUuid,
    required this.userId,
    required this.cedula,
    required this.tipoSolicitud,
    required this.monto,
    required this.nombreCompleto,
    required this.fechaCreacion,
  });

  /// Número que usan los datos del borrador mientras no hay número real.
  int get numeroProvisional => -id;
}
