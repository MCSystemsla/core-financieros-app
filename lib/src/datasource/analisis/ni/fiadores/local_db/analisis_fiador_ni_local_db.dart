import 'package:objectbox/objectbox.dart';

/// Fiador NI guardado sin conexión, pendiente de enviar a
/// `POST /cartera/analisis-fiador/create`.
///
/// `payloadJson` es el body ya armado (`AnalisisFiadorNi.toJson()`), así que
/// al enviarlo no se recalcula nada.
@Entity()
class AnalisisFiadorNiLocalDb {
  @Id()
  int id = 0;
  @Unique()
  String uuid;
  @Index()
  int numeroSolicitud;
  String userId;
  String nombreCompleto;
  String cedula;
  @Property(type: PropertyType.date)
  DateTime fechaGuardado;
  String payloadJson;

  AnalisisFiadorNiLocalDb({
    required this.uuid,
    required this.numeroSolicitud,
    required this.userId,
    required this.nombreCompleto,
    required this.cedula,
    required this.fechaGuardado,
    required this.payloadJson,
  });
}
