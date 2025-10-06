import 'package:objectbox/objectbox.dart';

@Entity()
class CatalogoFrecuenciaPagoDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;

  String valor;
  String nombre;
  String meses;

  CatalogoFrecuenciaPagoDb({
    required this.valor,
    required this.nombre,
    required this.meses,
  });
}
