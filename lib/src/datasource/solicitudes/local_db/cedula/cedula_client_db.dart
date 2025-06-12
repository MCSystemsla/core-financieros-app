import 'package:objectbox/objectbox.dart';

@Entity()
class CedulaClientDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  String? typeSolicitud;
  String? cedula;
  String? imageFrontCedula;
  String? imageBackCedula;
  CedulaClientDb({
    this.typeSolicitud,
    this.cedula,
    this.imageFrontCedula,
    this.imageBackCedula,
  });
}
