import 'package:objectbox/objectbox.dart';

/// Fiador HN guardado sin conexión, pendiente de enviar.
///
/// `payloadJson` es el body ya armado (`AnalisisFiadoresHn.toJson()`), así
/// que al enviarlo no se recalcula nada. Las fotos de la cédula y la firma
/// son copias en `fiadores_hn/<uuid>/`. `fiadorId` queda vacío hasta que el
/// backend crea el fiador; con él, el reintento empieza en la firma.
@Entity()
class AnalisisFiadorHnLocalDb {
  @Id()
  int id = 0;
  @Unique()
  String uuid;
  @Index()
  int numeroSolicitud;
  String userId;
  String tipoFiadorCodigo;
  String nombreCompleto;
  String cedula;
  @Property(type: PropertyType.date)
  DateTime fechaGuardado;
  String payloadJson;
  String cedulaFrontPath;
  String cedulaBackPath;
  String firmaPath;
  String fiadorId;

  AnalisisFiadorHnLocalDb({
    required this.uuid,
    required this.numeroSolicitud,
    required this.userId,
    required this.tipoFiadorCodigo,
    required this.nombreCompleto,
    required this.cedula,
    required this.fechaGuardado,
    required this.payloadJson,
    required this.cedulaFrontPath,
    required this.cedulaBackPath,
    required this.firmaPath,
    this.fiadorId = '',
  });
}
