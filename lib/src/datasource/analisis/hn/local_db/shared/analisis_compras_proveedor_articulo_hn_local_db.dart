// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisComprasProveedorArticuloHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? proveedorArticulo;
  String? frecuenciaCompraContadoCodigo;
  int? montoCompraContado;
  String? frecuenciaCompraCreditoCodigo;
  int? montoCompraCredito;
  int? totalCompraMensual;
  String? uuid;
  int? numeroSolicitud;
  AnalisisComprasProveedorArticuloHnLocalDb({
    this.proveedorArticulo,
    this.frecuenciaCompraContadoCodigo,
    this.montoCompraContado,
    this.frecuenciaCompraCreditoCodigo,
    this.montoCompraCredito,
    this.totalCompraMensual,
    this.uuid,
    this.numeroSolicitud,
  });
}
