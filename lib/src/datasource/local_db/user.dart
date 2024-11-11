import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  String? solicitudId;
  String? nombre;
  String? estado;
  String? moneda;
  double? monto;
  String? producto;
  DateTime? fecha;
  String? numero;
}
