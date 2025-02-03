import 'package:objectbox/objectbox.dart';

@Entity()
class DepartmentsLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  String valor;
  String nombre;

  DepartmentsLocalDb({
    required this.valor,
    required this.nombre,
  });
}
