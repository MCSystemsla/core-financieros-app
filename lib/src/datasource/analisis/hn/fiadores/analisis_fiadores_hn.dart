import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';

String analisisFiadoresHnToJson(AnalisisFiadoresHn data) =>
    json.encode(data.toJson());

class AnalisisFiadoresHn {
  final String database;
  final int numeroSolicitud;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final DateTime? fechaNacimiento;
  final String cedula;
  final String telefono;
  final String celular;
  final String direccion;
  final String barrioCasa;
  final String municipioCodigo;
  final String departamentoCodigo;
  final String paisCodigo;
  final String email;
  final String sexoCodigo;
  final String estadoCivilCodigo;
  final String relacionClienteCodigo;
  final bool esAsalariado;
  final String empresa;
  final String cargo;
  final String tiempoLaborar;
  final bool esEmpresario;
  final String actividadCodigo;
  final String tiempoActividad;
  final String direccionTrabajo;
  final String barrioTrabajo;
  final String telefonoTrabajo;
  final String lugarTrabajoAnterior;
  final int personasACargo;
  final int cantidadDependientes;
  final bool tieneDocumentosDomicilio;
  final String tipoDomicilioCodigo;
  final String duenoVivienda;
  final int pagoAlquiler;
  final int profesion;
  final int anosVivirDomicilio;
  final String nombreFamiliarCercano;
  final String parentescoFamiliarCercanoCodigo;
  final String direccionFamiliarCercano;
  final String telefonoFamiliarCercano;
  final double salarioNetoCordoba;
  final double otrosIngresosCordoba;
  final double totalIngresosFamiliares;
  final int ventaNegocio;
  final int costoVenta;
  final int gastosOperativos;
  final int gananciaNegocio;
  final int otrosIngresos;
  final String fuenteOtrosIngresos;
  final double consumoFamiliar;
  final int saldoDisponible;
  final bool activo;
  final String sucursal;
  final String usuarioCreacion;
  final String maquinaCreacion;
  final String tipoDocumentoCodigo;
  final bool esFirmaDigitalFiador;
  final String rtn;
  final String aldeaCodigo;
  final String caserioCasa;
  final String tipoFiadorCodigo;
  final String escolaridadCodigo;
  final String ocupacionCodigo;
  final String profesionCodigo;
  final String paisNacimientoCodigo;
  final DateTime? fechaEmisionCedula;
  final DateTime? fechaVencimientoCedula;
  final String nacionalidad1Codigo;
  final String nacionalidad2Codigo;
  final String nacionalidad3Codigo;
  final int cantidadHijos;
  final String tipoViviendaCodigo;
  final String tipoPersonaCnbsCodigo;
  final String estatusCodigo;
  final String tipoClienteCodigo;
  final String actividadEconomicaCnbs1Codigo;
  final String actividadEconomicaDescripcion1;
  final String actividadEconomicaCnbs2Codigo;
  final String actividadEconomicaDescripcion2;
  final String actividadEconomicaCnbs3Codigo;
  final String actividadEconomicaDescripcion3;
  final bool ejerceApnfd;
  final String nombreNegocio;
  final int tiempoNegocio;
  final String nivelAproximadoIngresosCodigo;
  final String puesto;
  final String condicionLocalCodigo;
  final String horarioVisita;
  final String horarioTrabajo;
  final String paisOcupacionCodigo;
  final String departamentoOcupacionCodigo;
  final String municipioOcupacionCodigo;
  final String aldeaOcupacionCodigo;
  final String caserioOcupacion;
  final String celularOcupacion;
  final List<HistorialCredito> historialCredito;

  AnalisisFiadoresHn({
    required this.database,
    required this.numeroSolicitud,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
    this.fechaNacimiento,
    required this.cedula,
    required this.telefono,
    required this.celular,
    required this.direccion,
    required this.barrioCasa,
    required this.municipioCodigo,
    required this.departamentoCodigo,
    required this.paisCodigo,
    required this.email,
    required this.sexoCodigo,
    required this.estadoCivilCodigo,
    required this.relacionClienteCodigo,
    required this.esAsalariado,
    required this.empresa,
    required this.cargo,
    required this.tiempoLaborar,
    required this.esEmpresario,
    required this.actividadCodigo,
    required this.tiempoActividad,
    required this.direccionTrabajo,
    required this.barrioTrabajo,
    required this.telefonoTrabajo,
    required this.lugarTrabajoAnterior,
    required this.personasACargo,
    required this.cantidadDependientes,
    required this.tieneDocumentosDomicilio,
    required this.tipoDomicilioCodigo,
    required this.duenoVivienda,
    required this.pagoAlquiler,
    required this.profesion,
    required this.anosVivirDomicilio,
    required this.nombreFamiliarCercano,
    required this.parentescoFamiliarCercanoCodigo,
    required this.direccionFamiliarCercano,
    required this.telefonoFamiliarCercano,
    required this.salarioNetoCordoba,
    required this.otrosIngresosCordoba,
    required this.totalIngresosFamiliares,
    required this.ventaNegocio,
    required this.costoVenta,
    required this.gastosOperativos,
    required this.gananciaNegocio,
    required this.otrosIngresos,
    required this.fuenteOtrosIngresos,
    required this.consumoFamiliar,
    required this.saldoDisponible,
    required this.activo,
    required this.sucursal,
    required this.usuarioCreacion,
    required this.maquinaCreacion,
    required this.tipoDocumentoCodigo,
    required this.esFirmaDigitalFiador,
    required this.rtn,
    required this.aldeaCodigo,
    required this.caserioCasa,
    required this.tipoFiadorCodigo,
    required this.escolaridadCodigo,
    required this.ocupacionCodigo,
    required this.profesionCodigo,
    required this.paisNacimientoCodigo,
    this.fechaEmisionCedula,
    this.fechaVencimientoCedula,
    required this.nacionalidad1Codigo,
    required this.nacionalidad2Codigo,
    required this.nacionalidad3Codigo,
    required this.cantidadHijos,
    required this.tipoViviendaCodigo,
    required this.tipoPersonaCnbsCodigo,
    required this.estatusCodigo,
    required this.tipoClienteCodigo,
    required this.actividadEconomicaCnbs1Codigo,
    required this.actividadEconomicaDescripcion1,
    required this.actividadEconomicaCnbs2Codigo,
    required this.actividadEconomicaDescripcion2,
    required this.actividadEconomicaCnbs3Codigo,
    required this.actividadEconomicaDescripcion3,
    required this.ejerceApnfd,
    required this.nombreNegocio,
    required this.tiempoNegocio,
    required this.nivelAproximadoIngresosCodigo,
    required this.puesto,
    required this.condicionLocalCodigo,
    required this.horarioVisita,
    required this.horarioTrabajo,
    required this.paisOcupacionCodigo,
    required this.departamentoOcupacionCodigo,
    required this.municipioOcupacionCodigo,
    required this.aldeaOcupacionCodigo,
    required this.caserioOcupacion,
    required this.celularOcupacion,
    required this.historialCredito,
  });

  /// Inverso de [toJson], para reconstruir un fiador pendiente guardado en
  /// local. [toJson] descarta `null` y `''`, así que las llaves ausentes toman
  /// `''`/`0`/`false`/`null`/`[]`.
  factory AnalisisFiadoresHn.fromJson(Map<String, dynamic> json) {
    String str(String key) => json[key] as String? ?? '';
    int integer(String key) => (json[key] as num?)?.toInt() ?? 0;
    double dbl(String key) => (json[key] as num?)?.toDouble() ?? 0;
    bool boolean(String key) => json[key] as bool? ?? false;
    DateTime? date(String key) {
      final value = json[key] as String?;
      return value == null ? null : DateTime.parse(value);
    }

    return AnalisisFiadoresHn(
      database: str('database'),
      numeroSolicitud: integer('NumeroSolicitud'),
      nombre1: str('Nombre1'),
      nombre2: str('Nombre2'),
      apellido1: str('Apellido1'),
      apellido2: str('Apellido2'),
      fechaNacimiento: date('FechaNacimiento'),
      cedula: str('Cedula'),
      telefono: str('Telefono'),
      celular: str('Celular'),
      direccion: str('Direccion'),
      barrioCasa: str('BarrioCasa'),
      municipioCodigo: str('MunicipioCodigo'),
      departamentoCodigo: str('DepartamentoCodigo'),
      paisCodigo: str('PaisCodigo'),
      email: str('Email'),
      sexoCodigo: str('SexoCodigo'),
      estadoCivilCodigo: str('EstadoCivilCodigo'),
      relacionClienteCodigo: str('RelacionClienteCodigo'),
      esAsalariado: boolean('EsAsalariado'),
      empresa: str('Empresa'),
      cargo: str('Cargo'),
      tiempoLaborar: str('TiempoLaborar'),
      esEmpresario: boolean('EsEmpresario'),
      actividadCodigo: str('ActividadCodigo'),
      tiempoActividad: str('TiempoActividad'),
      direccionTrabajo: str('DireccionTrabajo'),
      barrioTrabajo: str('BarrioTrabajo'),
      telefonoTrabajo: str('TelefonoTrabajo'),
      lugarTrabajoAnterior: str('LugarTrabajoAnterior'),
      personasACargo: integer('PersonasACargo'),
      cantidadDependientes: integer('CantidadDependientes'),
      tieneDocumentosDomicilio: boolean('TieneDocumentosDomicilio'),
      tipoDomicilioCodigo: str('TipoDomicilioCodigo'),
      duenoVivienda: str('DuenoVivienda'),
      pagoAlquiler: integer('PagoAlquiler'),
      profesion: integer('Profesion'),
      anosVivirDomicilio: integer('AnosVivirDomicilio'),
      nombreFamiliarCercano: str('NombreFamiliarCercano'),
      parentescoFamiliarCercanoCodigo: str('ParentescoFamiliarCercanoCodigo'),
      direccionFamiliarCercano: str('DireccionFamiliarCercano'),
      telefonoFamiliarCercano: str('TelefonoFamiliarCercano'),
      salarioNetoCordoba: dbl('SalarioNetoCordoba'),
      otrosIngresosCordoba: dbl('OtrosIngresosCordoba'),
      totalIngresosFamiliares: dbl('TotalIngresosFamiliares'),
      ventaNegocio: integer('VentaNegocio'),
      costoVenta: integer('CostoVenta'),
      gastosOperativos: integer('GastosOperativos'),
      gananciaNegocio: integer('GananciaNegocio'),
      otrosIngresos: integer('OtrosIngresos'),
      fuenteOtrosIngresos: str('FuenteOtrosIngresos'),
      consumoFamiliar: dbl('ConsumoFamiliar'),
      saldoDisponible: integer('SaldoDisponible'),
      activo: boolean('Activo'),
      sucursal: str('Sucursal'),
      usuarioCreacion: str('UsuarioCreacion'),
      maquinaCreacion: str('MaquinaCreacion'),
      tipoDocumentoCodigo: str('TipoDocumentoCodigo'),
      esFirmaDigitalFiador: boolean('EsFirmaDigitalFiador'),
      rtn: str('RTN'),
      aldeaCodigo: str('AldeaCodigo'),
      caserioCasa: str('CaserioCasa'),
      tipoFiadorCodigo: str('TipoFiadorCodigo'),
      escolaridadCodigo: str('EscolaridadCodigo'),
      ocupacionCodigo: str('OcupacionCodigo'),
      profesionCodigo: str('ProfesionCodigo'),
      paisNacimientoCodigo: str('PaisNacimientoCodigo'),
      fechaEmisionCedula: date('FechaEmisionCedula'),
      fechaVencimientoCedula: date('FechaVencimientoCedula'),
      nacionalidad1Codigo: str('Nacionalidad1codigo'),
      nacionalidad2Codigo: str('Nacionalidad2Codigo'),
      nacionalidad3Codigo: str('Nacionalidad3Codigo'),
      cantidadHijos: integer('CantidadHijos'),
      tipoViviendaCodigo: str('TipoViviendaCodigo'),
      tipoPersonaCnbsCodigo: str('TipoPersonaCNBSCodigo'),
      estatusCodigo: str('EstatusCodigo'),
      tipoClienteCodigo: str('TipoClienteCodigo'),
      actividadEconomicaCnbs1Codigo: str('ActividadEconomicaCNBS1Codigo'),
      actividadEconomicaDescripcion1: str('ActividadEconomicaDescripcion1'),
      actividadEconomicaCnbs2Codigo: str('ActividadEconomicaCNBS2Codigo'),
      actividadEconomicaDescripcion2: str('ActividadEconomicaDescripcion2'),
      actividadEconomicaCnbs3Codigo: str('ActividadEconomicaCNBS3Codigo'),
      actividadEconomicaDescripcion3: str('ActividadEconomicaDescripcion3'),
      ejerceApnfd: boolean('EjerceAPNFD'),
      nombreNegocio: str('NombreNegocio'),
      tiempoNegocio: integer('TiempoNegocio'),
      nivelAproximadoIngresosCodigo: str('NivelAproximadoIngresosCodigo'),
      puesto: str('Puesto'),
      condicionLocalCodigo: str('CondicionLocalCodigo'),
      horarioVisita: str('HorarioVisita'),
      horarioTrabajo: str('HorarioTrabajo'),
      paisOcupacionCodigo: str('PaisOcupacionCodigo'),
      departamentoOcupacionCodigo: str('DepartamentoOcupacionCodigo'),
      municipioOcupacionCodigo: str('MunicipioOcupacionCodigo'),
      aldeaOcupacionCodigo: str('AldeaOcupacionCodigo'),
      caserioOcupacion: str('CaserioOcupacion'),
      celularOcupacion: str('CelularOcupacion'),
      historialCredito: (json['HistorialCredito'] as List<dynamic>? ?? [])
          .map((e) => HistorialCredito.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'database': LocalStorage().database,
      'NumeroSolicitud': numeroSolicitud,
      'Nombre1': nombre1,
      'Nombre2': nombre2,
      'Apellido1': apellido1,
      'Apellido2': apellido2,
      'FechaNacimiento': fechaNacimiento?.toUtc().toIso8601String(),
      'Cedula': cedula,
      'Telefono': telefono,
      'Celular': celular,
      'Direccion': direccion,
      'BarrioCasa': barrioCasa,
      'MunicipioCodigo': municipioCodigo,
      'DepartamentoCodigo': departamentoCodigo,
      'PaisCodigo': paisCodigo,
      'Email': email,
      'SexoCodigo': sexoCodigo,
      'EstadoCivilCodigo': estadoCivilCodigo,
      'RelacionClienteCodigo': relacionClienteCodigo,
      'EsAsalariado': esAsalariado,
      'Empresa': empresa,
      'Cargo': cargo,
      'TiempoLaborar': tiempoLaborar,
      'EsEmpresario': esEmpresario,
      'ActividadCodigo': actividadCodigo,
      'TiempoActividad': tiempoActividad,
      'DireccionTrabajo': direccionTrabajo,
      'BarrioTrabajo': barrioTrabajo,
      'TelefonoTrabajo': telefonoTrabajo,
      'LugarTrabajoAnterior': lugarTrabajoAnterior,
      'PersonasACargo': personasACargo,
      'CantidadDependientes': cantidadDependientes,
      'TieneDocumentosDomicilio': tieneDocumentosDomicilio,
      'TipoDomicilioCodigo': tipoDomicilioCodigo,
      'DuenoVivienda': duenoVivienda,
      'PagoAlquiler': pagoAlquiler,
      'Profesion': profesion,
      'AnosVivirDomicilio': anosVivirDomicilio,
      'NombreFamiliarCercano': nombreFamiliarCercano,
      'ParentescoFamiliarCercanoCodigo': parentescoFamiliarCercanoCodigo,
      'DireccionFamiliarCercano': direccionFamiliarCercano,
      'TelefonoFamiliarCercano': telefonoFamiliarCercano,
      'SalarioNetoCordoba': salarioNetoCordoba,
      'OtrosIngresosCordoba': otrosIngresosCordoba,
      'TotalIngresosFamiliares': totalIngresosFamiliares,
      'VentaNegocio': ventaNegocio,
      'CostoVenta': costoVenta,
      'GastosOperativos': gastosOperativos,
      'GananciaNegocio': gananciaNegocio,
      'OtrosIngresos': otrosIngresos,
      'FuenteOtrosIngresos': fuenteOtrosIngresos,
      'ConsumoFamiliar': consumoFamiliar,
      'SaldoDisponible': saldoDisponible,
      'Activo': activo,
      'Sucursal': sucursal,
      'UsuarioCreacion': usuarioCreacion,
      'MaquinaCreacion': maquinaCreacion,
      'TipoDocumentoCodigo': tipoDocumentoCodigo,
      'EsFirmaDigitalFiador': esFirmaDigitalFiador,
      'RTN': rtn,
      'AldeaCodigo': aldeaCodigo,
      'CaserioCasa': caserioCasa,
      'TipoFiadorCodigo': tipoFiadorCodigo,
      'EscolaridadCodigo': escolaridadCodigo,
      'OcupacionCodigo': ocupacionCodigo,
      'ProfesionCodigo': profesionCodigo,
      'PaisNacimientoCodigo': paisNacimientoCodigo,
      'FechaEmisionCedula': fechaEmisionCedula?.toUtc().toIso8601String(),
      'FechaVencimientoCedula':
          fechaVencimientoCedula?.toUtc().toIso8601String(),
      'Nacionalidad1codigo': nacionalidad1Codigo,
      'Nacionalidad2Codigo': nacionalidad2Codigo,
      'Nacionalidad3Codigo': nacionalidad3Codigo,
      'CantidadHijos': cantidadHijos,
      'TipoViviendaCodigo': tipoViviendaCodigo,
      'TipoPersonaCNBSCodigo': tipoPersonaCnbsCodigo,
      'EstatusCodigo': estatusCodigo,
      'TipoClienteCodigo': tipoClienteCodigo,
      'ActividadEconomicaCNBS1Codigo': actividadEconomicaCnbs1Codigo,
      'ActividadEconomicaDescripcion1': actividadEconomicaDescripcion1,
      'ActividadEconomicaCNBS2Codigo': actividadEconomicaCnbs2Codigo,
      'ActividadEconomicaDescripcion2': actividadEconomicaDescripcion2,
      'ActividadEconomicaCNBS3Codigo': actividadEconomicaCnbs3Codigo,
      'ActividadEconomicaDescripcion3': actividadEconomicaDescripcion3,
      'EjerceAPNFD': ejerceApnfd,
      'NombreNegocio': nombreNegocio,
      'TiempoNegocio': tiempoNegocio,
      'NivelAproximadoIngresosCodigo': nivelAproximadoIngresosCodigo,
      'Puesto': puesto,
      'CondicionLocalCodigo': condicionLocalCodigo,
      'HorarioVisita': horarioVisita,
      'HorarioTrabajo': horarioTrabajo,
      'PaisOcupacionCodigo': paisOcupacionCodigo,
      'DepartamentoOcupacionCodigo': departamentoOcupacionCodigo,
      'MunicipioOcupacionCodigo': municipioOcupacionCodigo,
      'AldeaOcupacionCodigo': aldeaOcupacionCodigo,
      'CaserioOcupacion': caserioOcupacion,
      'CelularOcupacion': celularOcupacion,
      'HistorialCredito':
          List<dynamic>.from(historialCredito.map((x) => x.toJson())),
    };
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
