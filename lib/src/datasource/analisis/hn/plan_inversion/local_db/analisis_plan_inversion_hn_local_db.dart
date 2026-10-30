import 'package:objectbox/objectbox.dart';

/// Borrador del plan de inversión HN de una solicitud, guardado en el teléfono
/// hasta que se envía con éxito a `createAnalisisPlanInversion`.
///
/// Hay como máximo uno por `numeroSolicitud` + `userId`. `itemsJson` es la
/// lista de artículos (`PlanInversion.toLocalJson()`), con su `uuid`.
@Entity()
class AnalisisPlanInversionHnLocalDb {
  @Id()
  int id = 0;
  @Index()
  int numeroSolicitud;
  String userId;
  @Property(type: PropertyType.date)
  DateTime fechaActualizacion;
  String itemsJson;

  AnalisisPlanInversionHnLocalDb({
    required this.numeroSolicitud,
    required this.userId,
    required this.fechaActualizacion,
    required this.itemsJson,
  });
}
