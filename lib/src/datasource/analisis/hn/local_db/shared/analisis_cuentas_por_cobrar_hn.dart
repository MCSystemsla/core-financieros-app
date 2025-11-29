// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisCuentasPorCobrarHn {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? nombre;
  int? montoCredito;
  int? abonoCredito;
  String? frecuenciaAbonoCodigo;
  int? totalMensualCredito;
  String? uuid;
  int? numeroSolicitud;
  bool isReprestamoForm = false;
  AnalisisCuentasPorCobrarHn({
    this.nombre,
    this.montoCredito,
    this.abonoCredito,
    this.frecuenciaAbonoCodigo,
    this.totalMensualCredito,
    this.uuid,
    this.numeroSolicitud,
    this.isReprestamoForm = false,
  });
}
