// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisPasivoHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? nombreProveedores;
  int? monto;
  String? uuid;
  int? numeroSolicitud;
  AnalisisPasivoHnLocalDb({
    this.nombreProveedores,
    this.monto,
    this.uuid,
    this.numeroSolicitud,
  });
}
