import 'package:objectbox/objectbox.dart';

@Entity()
class CatalogoLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  String valor;
  String nombre;
  String type;
  double? interes;

  CatalogoLocalDb({
    required this.valor,
    required this.nombre,
    required this.type,
    this.interes,
  });
}
