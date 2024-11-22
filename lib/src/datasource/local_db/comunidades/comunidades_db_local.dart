import 'package:isar/isar.dart';

part 'comunidades_db_local.g.dart';

@Collection()
class ComunidadesLocalDb {
  Id id = Isar.autoIncrement;
  String? nombre;
  String? valor;
}
