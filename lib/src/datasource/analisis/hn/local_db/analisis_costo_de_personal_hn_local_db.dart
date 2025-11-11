// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisCostoDePersonalHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  int? numeroEmpleado;
  String? lugarProceso;
  bool? permanente;
  bool? temporal;
  String? formaDePago;
  int? salarioMensual;
  String? uuid;
  AnalisisCostoDePersonalHnLocalDb({
    this.numeroEmpleado,
    this.lugarProceso,
    this.permanente,
    this.temporal,
    this.formaDePago,
    this.salarioMensual,
    this.uuid,
  });
}
