// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisActivoHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? nombreActivo;
  int? monto;
  String? uuid;
  int? numeroSolicitud;
  AnalisisActivoHnLocalDb({
    this.nombreActivo,
    this.monto,
    this.uuid,
    this.numeroSolicitud,
  });
}
