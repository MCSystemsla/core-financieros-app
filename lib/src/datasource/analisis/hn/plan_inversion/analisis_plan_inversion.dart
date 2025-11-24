import 'dart:convert';

String analisisPlanDeInversionToJson(AnalisisPlanDeInversion data) =>
    json.encode(data.toJson());

class AnalisisPlanDeInversion {
  final int numeroSolicitud;
  final String database;
  final List<PlanInversion> planInversion;

  AnalisisPlanDeInversion({
    required this.numeroSolicitud,
    required this.database,
    required this.planInversion,
  });

  Map<String, dynamic> toJson() => {
        'NumeroSolicitud': numeroSolicitud,
        'database': database,
        'PlanInversion':
            List<dynamic>.from(planInversion.map((x) => x.toJson())),
      };
}

class PlanInversion {
  final String uuid;
  final int cantidad;
  final String descripcion;
  final double precioUnitario;
  final int total;

  PlanInversion({
    required this.cantidad,
    required this.descripcion,
    required this.precioUnitario,
    required this.total,
    required this.uuid,
  });

  Map<String, dynamic> toJson() => {
        'Cantidad': cantidad,
        'Descripcion': descripcion,
        'PrecioUnitario': precioUnitario,
        'Total': total,
      };
}
