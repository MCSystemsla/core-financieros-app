// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/informacion_peps/informacion_peps_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/solicitud_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/solicitudes_grupales_asignar_promotor_to_solicitud.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/solicitudes_grupales_autorizacion.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/solicitud_nueva_menor_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/rechazar_solicitud/rechazar_solicitud_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/solicitud_represtamo_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/filter_estados_credito/filter_estado_credito.dart';

class CrearSolciitudAsalariadoHNEndpoint extends Endpoint {
  final SolicitudAsalariadoHn solicitud;

  CrearSolciitudAsalariadoHNEndpoint({
    required this.solicitud,
  });
  @override
  Method get method => Method.post;

  @override
  // * Version 1.0
  // String get path => '/cartera/solicitud-asalariado/crear';
  String get path => '/cartera/solicitud-asalariado/crear/v2';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitud.toJson();
}

class CrearSolciitudNuevaMenorHNEndpoint extends Endpoint {
  final SolicitudNuevaMenorHn solicitud;

  CrearSolciitudNuevaMenorHNEndpoint({
    required this.solicitud,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/solicitud-nueva-menor/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitud.toJson();
}

class CreateSolicitudReprestamoHNEndpoint extends Endpoint {
  final SolicitudReprestamoHn solicitud;

  CreateSolicitudReprestamoHNEndpoint({
    required this.solicitud,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/solicitud-represtamo/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitud.toJson();
}

class GetCatalogoHNByCodigoEndpoint extends Endpoint {
  final String codigo;
  GetCatalogoHNByCodigoEndpoint({required this.codigo});
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/general';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'codigo': codigo,
      };
}

class GetProductosHNEndpoint extends Endpoint {
  GetProductosHNEndpoint();
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/producto';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class GetCatalogosUbicacionesHNEndpoint extends Endpoint {
  final String codigo;
  GetCatalogosUbicacionesHNEndpoint({required this.codigo});
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/ubicacion';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'codigo': codigo,
      };
}

class GetCatalogosFrecuenciaDePagoEndpoint extends Endpoint {
  GetCatalogosFrecuenciaDePagoEndpoint();
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/frecuencia-pago';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class GetParametroByCodigoEndpoint extends Endpoint {
  final String nombre;
  GetParametroByCodigoEndpoint({required this.nombre});
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/obtener-parametro';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
      };
}

class ObtenerAutoCompletadoNuevaMenorEndpoint extends Endpoint {
  final String nombre;
  final String cedula;
  final String tipoDocumentoCodigo;
  ObtenerAutoCompletadoNuevaMenorEndpoint({
    required this.nombre,
    required this.cedula,
    required this.tipoDocumentoCodigo,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitud-nueva-menor/obtener-auto-completado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
        'cedula': cedula,
        'tipoDocumentoCodigo': tipoDocumentoCodigo,
      };
}

class ObtenerAutoCompletadoReprestamoEndpoint extends Endpoint {
  final String nombre;
  final String cedula;
  final String tipoDocumentoCodigo;
  ObtenerAutoCompletadoReprestamoEndpoint({
    required this.nombre,
    required this.cedula,
    required this.tipoDocumentoCodigo,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitud-represtamo/obtener-auto-completado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
        'cedula': cedula,
        'tipoDocumentoCodigo': tipoDocumentoCodigo,
      };
}

class ObtenerAutoCompletadoAsalariadoEndpoint extends Endpoint {
  final String nombre;
  final String cedula;
  final String tipoDocumentoCodigo;
  ObtenerAutoCompletadoAsalariadoEndpoint({
    required this.nombre,
    required this.cedula,
    required this.tipoDocumentoCodigo,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitud-asalariado/obtener-auto-completado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
        'cedula': cedula,
        'tipoDocumentoCodigo': tipoDocumentoCodigo,
      };
}

class GetSolicitudesByEstadoEndpoint extends Endpoint {
  final EstadoCredito estadoCredito;
  final bool isAsignadaToAsesorCredito;
  final String? numeroSolicitud;
  final String? cedulaCliente;
  final int? pagina;
  final int? codigoGrupo;
  final int? usuarioId;
  final bool isCustomEstadoCredito;
  final FilterEstadosCredito filterEstadosCredito;
  final List<EstadoCredito> estadosCredito;
  GetSolicitudesByEstadoEndpoint({
    required this.estadoCredito,
    required this.isAsignadaToAsesorCredito,
    this.numeroSolicitud,
    this.cedulaCliente,
    this.pagina,
    this.codigoGrupo,
    this.usuarioId,
    this.isCustomEstadoCredito = false,
    this.filterEstadosCredito = FilterEstadosCredito.all,
    this.estadosCredito = const [
      EstadoCredito.registrada,
      EstadoCredito.asignada,
      EstadoCredito.enRevision,
      EstadoCredito.enComite
    ],
  });
  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/cartera/solicitudes/general/obtener-solicitud-por-estado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'EstadoSolicitudCodigo': isCustomEstadoCredito
            ? estadosCredito.map((e) => e.codigo).join(',')
            : estadoCredito.codigo,
        'OficialCreditoAsignado': isAsignadaToAsesorCredito.toString(),
        if (numeroSolicitud != null && numeroSolicitud!.isNotEmpty)
          'Numero': numeroSolicitud,
        if (cedulaCliente != null && cedulaCliente!.isNotEmpty)
          'Cedula': cedulaCliente,
        if (pagina != null) 'Pagina': pagina.toString(),
        if (codigoGrupo != null) 'GrupoCodigo': codigoGrupo.toString(),
        if (usuarioId != null) 'OficialCreditoCodigo': usuarioId.toString(),
        'TipoSolicitudFiltro': filterEstadosCredito.codigo,
      };
}

class GetUsuarioIdSolicitudesByEstadoEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitudes/general/asesor-by-user-id';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class AsignSolicitudToAsesorAsalariadoHNEndpoint extends Endpoint {
  final int idSolicitud;
  final int idPromotor;

  AsignSolicitudToAsesorAsalariadoHNEndpoint({
    required this.idSolicitud,
    required this.idPromotor,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitud-asalariado/asignar-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'idSolicitud': idSolicitud,
        'idPromotor': idPromotor,
      };
}

class AsignSolicitudToAsesorNuevaMenorHNEndpoint extends Endpoint {
  final int idSolicitud;
  final int idPromotor;

  AsignSolicitudToAsesorNuevaMenorHNEndpoint({
    required this.idSolicitud,
    required this.idPromotor,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitud-nueva-menor/asignar-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'idSolicitud': idSolicitud,
        'idPromotor': idPromotor,
      };
}

class AsignSolicitudToAsesorReprestamoHNEndpoint extends Endpoint {
  final int idSolicitud;
  final int idPromotor;

  AsignSolicitudToAsesorReprestamoHNEndpoint({
    required this.idSolicitud,
    required this.idPromotor,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitud-represtamo/asignar-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'idSolicitud': idSolicitud,
        'idPromotor': idPromotor,
      };
}

class GetAsesoresHNEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitudes/general/obtener-asesores';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class ActividadesEconomicasAliasFilteredEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/ahorro/herramientas/actividades-economicas-alias/get-filtered';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
}

class AutorizarSolicitudCreditoHNEndpoint extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;
  AutorizarSolicitudCreditoHNEndpoint({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitudes/general/autorizar-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud,
        'TipoSolicitud': tipoSolicitud,
      };
}

class SolciitudGrupalGruposActivos extends Endpoint {
  final String? grupoCodigo;
  final String? grupoNombre;

  SolciitudGrupalGruposActivos({
    this.grupoCodigo,
    this.grupoNombre,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/grupales/grupos-activos';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        if (grupoCodigo != null && grupoCodigo!.isNotEmpty)
          'GrupoCodigo': grupoCodigo,
        if (grupoNombre != null && grupoNombre!.isNotEmpty)
          'NombreGrupo': grupoNombre,
      };
}

class SolicitudesGrupalCreateGrupoCreditoEndpoint extends Endpoint {
  final String nombre;

  SolicitudesGrupalCreateGrupoCreditoEndpoint({required this.nombre});
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/grupales/crear-grupo';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'Nombre': nombre,
      };
}

class SolicitudesGrupalesGetCargosDisponiblesEndpoint extends Endpoint {
  final int? grupoCodigo;

  SolicitudesGrupalesGetCargosDisponiblesEndpoint({this.grupoCodigo});
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/grupales/cargos-disponibles';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        if (grupoCodigo != null && grupoCodigo != 0)
          'grupoCodigo': grupoCodigo.toString(),
      };
}

class SolicitudesGrupalesAsignarPromotorEndpoint extends Endpoint {
  final SolicitudGrupalesAsignarSolicitudToPromotor data;
  SolicitudesGrupalesAsignarPromotorEndpoint({
    required this.data,
  });
  @override
  Method get method => Method.post;

  @override
  String get path =>
      '/cartera/solicitudes/general/asignar-solicitudes-promotor';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => data.toJson();
}

class SolicitudesGrupalesAutorizarEndpoint extends Endpoint {
  final SolicitudGrupalesAutorizarSolicitudToPromotor data;
  SolicitudesGrupalesAutorizarEndpoint({
    required this.data,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitudes/general/autorizar/bulk';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => data.toJson();
}

class UserHaveCedulaEndpoint extends Endpoint {
  final String documentoCliente;

  UserHaveCedulaEndpoint({
    required this.documentoCliente,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitudes/general/cedula/foto/existe';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'DocumentoCliente': documentoCliente,
        'database': LocalStorage().database,
      };
}

class UpdateSolicitudNuevaMenorEndpoint extends Endpoint {
  final SolicitudNuevaMenorHn solicitudNuevaMenorHn;
  final int idSolicitud;
  UpdateSolicitudNuevaMenorEndpoint({
    required this.solicitudNuevaMenorHn,
    required this.idSolicitud,
  });

  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitud-nueva-menor/actualizar';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        ...solicitudNuevaMenorHn.toJson(),
        'ID': idSolicitud,
      };
}

class UpdateSolicitudAsalariadoEndpoint extends Endpoint {
  final SolicitudAsalariadoHn solicitudAsalariadoHn;
  final int idSolicitud;
  UpdateSolicitudAsalariadoEndpoint({
    required this.solicitudAsalariadoHn,
    required this.idSolicitud,
  });

  @override
  Method get method => Method.patch;

  @override
  // String get path => '/cartera/solicitud-asalariado/actualizar';
  String get path => '/cartera/solicitud-asalariado/actualizar/V2';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        ...solicitudAsalariadoHn.toJson(),
        'ID': idSolicitud,
      };
}

class UpdateSolicitudReprestamoEndpoint extends Endpoint {
  final SolicitudReprestamoHn solicitudReprestamoHn;
  final String tipoSolicitud;
  final int idSolicitud;
  UpdateSolicitudReprestamoEndpoint({
    required this.solicitudReprestamoHn,
    required this.tipoSolicitud,
    required this.idSolicitud,
  });

  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitud-represtamo/actualizar';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        ...solicitudReprestamoHn.toJson(),
        'TipoSolicitud': tipoSolicitud,
        'SolicitudID': idSolicitud,
      };
}

class GetSolicitudDataNuevaEndpoint extends Endpoint {
  final String tipoSolicitud;
  final int idSolicitud;
  GetSolicitudDataNuevaEndpoint({
    required this.tipoSolicitud,
    required this.idSolicitud,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitudes/general/solicitud-data-by-id';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'TipoSolicitud': tipoSolicitud,
        'SolicitudID': idSolicitud.toString(),
      };
}

class RechazarSolicitudHnEndpoint extends Endpoint {
  final RechazarSolicitudHn data;
  RechazarSolicitudHnEndpoint({required this.data});

  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitudes/general/rechazar-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => data.toJson();
}

class CambiarGrupoNombreEndpoint extends Endpoint {
  final String nombreGrupo;
  final int codigoGrupo;
  CambiarGrupoNombreEndpoint({
    required this.nombreGrupo,
    required this.codigoGrupo,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/grupales/actualizar-grupo';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'Nombre': nombreGrupo,
        'CodigoGrupo': codigoGrupo.toString(),
      };
}

class InformacionPepsEndpointHN extends Endpoint {
  final PepsInformacionHn pepsInformacionHn;
  InformacionPepsEndpointHN({
    required this.pepsInformacionHn,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/peps/informacion';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => pepsInformacionHn.toJson();
}
