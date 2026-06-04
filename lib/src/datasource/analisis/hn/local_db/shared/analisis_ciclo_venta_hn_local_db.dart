// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisCicloVentaHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? dia;
  int? venta;
  String? valorizacion;
  String? mes;
  String? semana;
  String? uuid;
  String? typeFormAnalisis;
  int? numeroSolicitud;

  AnalisisCicloVentaHnLocalDb({
    this.dia,
    this.venta,
    this.valorizacion,
    this.mes,
    this.uuid,
    this.typeFormAnalisis,
    this.numeroSolicitud,
    this.semana,
  });
}
