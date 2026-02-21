// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AnalisisListDataHn {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? idAnalisis;
  String? numero;
  int? objTipoSolicitudId;
  int? objEstadoSolicitudId;
  String? monto;
  String? sucursal;
  String? observacion;
  double? cuota;
  String? nombreCompleto;
  String? estado;
  String? tipoSolicitud;
  String? nombrePromotor;
  DateTime? fechaSolicitud;
  String? cedulaCliente;
  String? tipoPersonaCodigo;
  bool esSolicitudGrupal = false;

  AnalisisListDataHn({
    this.idAnalisis,
    this.numero,
    this.objTipoSolicitudId,
    this.objEstadoSolicitudId,
    this.monto,
    this.sucursal,
    this.observacion,
    this.cuota,
    this.nombreCompleto,
    this.estado,
    this.tipoSolicitud,
    this.nombrePromotor,
    this.fechaSolicitud,
    this.cedulaCliente,
    this.tipoPersonaCodigo,
    this.esSolicitudGrupal = false,
  });
}
