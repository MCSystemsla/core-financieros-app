// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class UbicacionClienteHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  double? longitude;
  double? latitude;
  String? tipoUbicacionCodigo;
  String? tipoUbicacionNombre;
  String? referenciaAdicional;
  String? numeroSolicitud;
  DateTime? createdAt = DateTime.now();

  UbicacionClienteHnLocalDb({
    this.longitude,
    this.latitude,
    this.tipoUbicacionCodigo,
    this.tipoUbicacionNombre,
    this.referenciaAdicional,
    this.numeroSolicitud,
    this.createdAt,
  });
}
