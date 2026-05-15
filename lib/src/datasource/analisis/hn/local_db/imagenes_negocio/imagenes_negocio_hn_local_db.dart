// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class ImagenesNegocioHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? numeroSolicitud;
  String? pathFoto1;
  String? pathFoto2;
  String? pathFoto3;

  ImagenesNegocioHnLocalDb({
    this.numeroSolicitud,
    this.pathFoto1,
    this.pathFoto2,
    this.pathFoto3,
  });
}
