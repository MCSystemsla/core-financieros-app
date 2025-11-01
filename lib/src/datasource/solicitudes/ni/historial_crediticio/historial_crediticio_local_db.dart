// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class HistorialCrediticioLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  String? entidad;
  int? monto;
  String? tipoMonedaCodigo;
  String? tipoFrecuenciaCodigo;
  int? cuota;
  int? saldo;
  String? estadoCodigo;
  HistorialCrediticioLocalDb({
    this.uuid,
    this.entidad,
    this.monto,
    this.tipoMonedaCodigo,
    this.tipoFrecuenciaCodigo,
    this.cuota,
    this.saldo,
    this.estadoCodigo,
  });
}
