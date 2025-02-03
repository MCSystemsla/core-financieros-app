import 'package:objectbox/objectbox.dart';

@Entity()
class CatalogoNacionalidadPaisDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  String valor;
  String nombre;
  String? relacion;

  CatalogoNacionalidadPaisDb({
    required this.valor,
    required this.nombre,
    this.relacion,
  });
}
