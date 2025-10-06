import 'package:objectbox/objectbox.dart';

@Entity()
class CatalogoParentesco {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  String valor;
  String nombre;
  String type;

  CatalogoParentesco({
    required this.valor,
    required this.nombre,
    required this.type,
  });
}
