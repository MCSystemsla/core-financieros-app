// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisCicloComprasSemanalesHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  int? numerSolicitud;
  String? semanaDelMes;
  int? cantidadCompra;
  int? totalComprasMensualSemanal;
  String? valorizacion;
  AnalisisCicloComprasSemanalesHnLocalDb({
    this.uuid,
    this.numerSolicitud,
    this.semanaDelMes,
    this.cantidadCompra,
    this.totalComprasMensualSemanal,
    this.valorizacion,
  });
}
