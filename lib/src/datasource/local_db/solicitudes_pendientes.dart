import 'package:isar/isar.dart';

part 'solicitudes_pendientes.g.dart';

@Collection()
class SolicitudesPendientes {
  Id id = Isar.autoIncrement;
  String? solicitudId;
  String? nombre;
  String? estado;
  String? moneda;
  double? monto;
  String? producto;
  DateTime? fecha;
  String? numero;
  String? sucursal;
  int? idAsesor;
  String? tipoSolicitud;
  String? motivoAnterior;
  int? cantidadHijos;
}
