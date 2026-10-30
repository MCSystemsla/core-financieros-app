import 'dart:convert';

import 'package:uuid/uuid.dart';

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

  /// Inverso de [toLocalJson]. Si falta el `uuid`, genera uno nuevo.
  factory PlanInversion.fromJson(Map<String, dynamic> json) => PlanInversion(
        uuid: (json['uuid'] as String?) ?? const Uuid().v4(),
        cantidad: (json['Cantidad'] as num?)?.toInt() ?? 0,
        descripcion: (json['Descripcion'] as String?) ?? '',
        precioUnitario: (json['PrecioUnitario'] as num?)?.toDouble() ?? 0.0,
        total: (json['Total'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'Cantidad': cantidad,
        'Descripcion': descripcion,
        'PrecioUnitario': precioUnitario,
        'Total': total,
      };

  /// Para el borrador local: [toJson] más el `uuid`, que el backend no recibe.
  Map<String, dynamic> toLocalJson() => {
        ...toJson(),
        'uuid': uuid,
      };
}
