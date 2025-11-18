// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisInventarioHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  int? cantidad;
  String? articulo;
  double? costoCompra;
  int? precioVenta;
  double? costoVentaPorcentaje;
  int? total;
  int? numeroSolicitud;
  AnalisisInventarioHnLocalDb({
    this.cantidad,
    this.articulo,
    this.costoCompra,
    this.precioVenta,
    this.costoVentaPorcentaje,
    this.total,
    this.numeroSolicitud,
  });
}
