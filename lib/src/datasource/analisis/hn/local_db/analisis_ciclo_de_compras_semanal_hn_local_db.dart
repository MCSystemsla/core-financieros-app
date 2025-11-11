// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisCicloDeComprasSemanalHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? semanaDelMes;
  int? cantidadCompra;
  int? totalComprasMensualSemanal;
  String? valorizacion;
  String? uuid;
  String? typeFormAnalisis;
}
