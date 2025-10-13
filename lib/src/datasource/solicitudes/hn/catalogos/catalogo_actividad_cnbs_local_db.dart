import 'package:objectbox/objectbox.dart';

@Entity()
class CatalogoActividadCnbsLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  String valor;
  String nombre;
  bool? isApnfd = false;
  String? isApnfdString;

  CatalogoActividadCnbsLocalDb({
    required this.valor,
    required this.nombre,
    this.isApnfd = false,
    this.isApnfdString,
  });
}
