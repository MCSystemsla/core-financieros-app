import 'dart:convert';

import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';

ComiteSolicitudesGrupalesOnComiteResponse
    comiteSolicitudesGrupalesOnComiteResponseFromJson(String str) =>
        ComiteSolicitudesGrupalesOnComiteResponse.fromJson(json.decode(str));

class ComiteSolicitudesGrupalesOnComiteResponse {
  final MetaDataPagination metaData;
  final List<ComiteGrupalResponseItem> data;

  ComiteSolicitudesGrupalesOnComiteResponse({
    required this.metaData,
    required this.data,
  });

  factory ComiteSolicitudesGrupalesOnComiteResponse.fromJson(
          Map<String, dynamic> json) =>
      ComiteSolicitudesGrupalesOnComiteResponse(
        metaData: MetaDataPagination.fromJson(json['metaData']),
        data: List<ComiteGrupalResponseItem>.from(
            json['data'].map((x) => ComiteGrupalResponseItem.fromJson(x))),
      );
}

class ComiteGrupalResponseItem {
  final int id;
  final int nivelComite;
  final String nombre;
  final DateTime fechaSolicitud;
  final int monto;
  final String estado;
  final String numero;
  final String moneda;
  final String cedula;
  final String tipoSolicitud;
  final String nombrePromotor;
  final int promotorId;
  final int cicloGrupoId;
  final String nombreGrupo;
  final String acta;
  final String solicitud;

  ComiteGrupalResponseItem({
    required this.id,
    required this.nivelComite,
    required this.nombre,
    required this.fechaSolicitud,
    required this.monto,
    required this.estado,
    required this.numero,
    required this.moneda,
    required this.cedula,
    required this.tipoSolicitud,
    required this.nombrePromotor,
    required this.promotorId,
    required this.cicloGrupoId,
    required this.nombreGrupo,
    required this.acta,
    required this.solicitud,
  });

  factory ComiteGrupalResponseItem.fromJson(Map<String, dynamic> json) =>
      ComiteGrupalResponseItem(
        id: json['ID'],
        nivelComite: json['NivelComite'],
        nombre: json['Nombre'],
        fechaSolicitud: DateTime.parse(json['FechaSolicitud']),
        monto: json['Monto'],
        estado: json['Estado'],
        numero: json['Numero'],
        moneda: json['Moneda'],
        cedula: json['Cedula'],
        tipoSolicitud: json['TipoSolicitud'],
        nombrePromotor: json['NombrePromotor'],
        promotorId: json['PromotorID'],
        cicloGrupoId: json['CicloGrupoID'],
        nombreGrupo: json['NombreGrupo'],
        acta: json['Acta'],
        solicitud: json['Solicitud'],
      );
}
