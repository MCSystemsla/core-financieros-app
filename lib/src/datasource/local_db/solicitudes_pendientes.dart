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
  String? cedula;

  /// El asesor terminó el formulario (firmó). No significa que el backend lo
  /// haya recibido: para eso está [formSended].
  bool? isSended = false;
  String? nombreFormulario;
  DateTime? dateSended;
  bool imagesSended = false;

  /// `true` solo cuando el backend aceptó las respuestas del formulario Kiva.
  /// `false`: pendiente de enviar. `null`: fila anterior a este campo (estado
  /// desconocido, se trata como antes).
  bool? formSended;
  DateTime? formSendedAt;

  /// Datos para reenviar un Kiva que falló en la sincronización automática de
  /// solicitudes sin número: el uuid local de la solicitud (el formulario lo
  /// guarda en `solicitudCreditoId`) y el id del tipo de solicitud.
  String? solicitudCreditoUuid;
  int? tipoSolicitudId;
}
