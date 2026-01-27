import 'package:objectbox/objectbox.dart';

@Entity()
class SignatureClientDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  String? typeSolicitud;
  String? cedula;
  String? imageSignature;
  SignatureClientDb({
    this.typeSolicitud,
    this.cedula,
    this.imageSignature,
  });
}
