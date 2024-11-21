import 'package:isar/isar.dart';

part 'departamentos_db_local.g.dart';

@Collection()
class DepartamentosDbLocal {
  Id id = Isar.autoIncrement;
  String? nombre;
  String? valor;
}
