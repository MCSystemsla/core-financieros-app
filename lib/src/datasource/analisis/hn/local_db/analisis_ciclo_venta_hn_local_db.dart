// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisCicloVentaHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? dia;
  int? venta;
  String? valorizacion;
  int? totalVentasDiaria;
  String? mes;
  String? uuid;
  String? typeFormAnalisis;

  AnalisisCicloVentaHnLocalDb({
    this.dia,
    this.venta,
    this.valorizacion,
    this.totalVentasDiaria,
    this.mes,
    this.uuid,
    this.typeFormAnalisis,
  });
}
