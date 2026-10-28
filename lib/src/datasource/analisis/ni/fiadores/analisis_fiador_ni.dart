import 'dart:convert';

String analisisFiadorNiToJson(AnalisisFiadorNi data) =>
    json.encode(data.toJson());

/// Body de `POST /cartera/analisis-fiador/create` para Nicaragua.
///
/// Lleva solo los campos de la pantalla de fiadores de NI (sistema de
/// escritorio). `FuenteOtrosIngresos`, `PagoAlquiler`, `ActividadCodigo` y
/// `TiempoActividad` usan los mismos nombres que HN en ese endpoint.
class AnalisisFiadorNi {
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
  final double pagoAlquiler;
  final String profesion;
  final int anosVivirDomicilio;
  final String nombreFamiliarCercano;
  final String parentescoFamiliarCercanoCodigo;
  final String direccionFamiliarCercano;
  final String telefonoFamiliarCercano;
  final double salarioNetoCordoba;
  final double otrosIngresosCordoba;
  final double totalIngresosFamiliares;
  final double ventaNegocio;
  final double costoVenta;
  final double gastosOperativos;
  final double gananciaNegocio;
  final double otrosIngresos;
  final String fuenteOtrosIngresos;
  final double consumoFamiliar;
  final double saldoDisponible;
  final bool activo;
  final String tipoDocumentoCodigo;
  final bool esFirmaDigitalFiador;
  final String tipoViviendaCodigo;

  AnalisisFiadorNi({
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
    this.activo = true,
    required this.tipoDocumentoCodigo,
    this.esFirmaDigitalFiador = false,
    required this.tipoViviendaCodigo,
  });

  /// Inverso de [toJson]. Se usa para reconstruir un fiador guardado offline
  /// (`AnalisisFiadorNiLocalDb.payloadJson`). `toJson()` descarta `null` y
  /// `''`, así que las llaves ausentes toman `''`, `0`, `false` o `null`.
  factory AnalisisFiadorNi.fromJson(Map<String, dynamic> json) {
    String str(String key) => json[key] as String? ?? '';
    int integer(String key) => (json[key] as num?)?.toInt() ?? 0;
    double dbl(String key) => (json[key] as num?)?.toDouble() ?? 0;
    bool boolean(String key) => json[key] as bool? ?? false;

    final fechaNacimiento = json['FechaNacimiento'] as String?;

    return AnalisisFiadorNi(
      database: str('database'),
      numeroSolicitud: integer('NumeroSolicitud'),
      nombre1: str('Nombre1'),
      nombre2: str('Nombre2'),
      apellido1: str('Apellido1'),
      apellido2: str('Apellido2'),
      fechaNacimiento:
          fechaNacimiento == null ? null : DateTime.parse(fechaNacimiento),
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
      pagoAlquiler: dbl('PagoAlquiler'),
      profesion: str('Profesion'),
      anosVivirDomicilio: integer('AnosVivirDomicilio'),
      nombreFamiliarCercano: str('NombreFamiliarCercano'),
      parentescoFamiliarCercanoCodigo: str('ParentescoFamiliarCercanoCodigo'),
      direccionFamiliarCercano: str('DireccionFamiliarCercano'),
      telefonoFamiliarCercano: str('TelefonoFamiliarCercano'),
      salarioNetoCordoba: dbl('SalarioNetoCordoba'),
      otrosIngresosCordoba: dbl('OtrosIngresosCordoba'),
      totalIngresosFamiliares: dbl('TotalIngresosFamiliares'),
      ventaNegocio: dbl('VentaNegocio'),
      costoVenta: dbl('CostoVenta'),
      gastosOperativos: dbl('GastosOperativos'),
      gananciaNegocio: dbl('GananciaNegocio'),
      otrosIngresos: dbl('OtrosIngresos'),
      fuenteOtrosIngresos: str('FuenteOtrosIngresos'),
      consumoFamiliar: dbl('ConsumoFamiliar'),
      saldoDisponible: dbl('SaldoDisponible'),
      activo: json['Activo'] as bool? ?? true,
      tipoDocumentoCodigo: str('TipoDocumentoCodigo'),
      esFirmaDigitalFiador: boolean('EsFirmaDigitalFiador'),
      tipoViviendaCodigo: str('TipoViviendaCodigo'),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'database': database,
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
      'TipoDocumentoCodigo': tipoDocumentoCodigo,
      'EsFirmaDigitalFiador': esFirmaDigitalFiador,
      'TipoViviendaCodigo': tipoViviendaCodigo,
    };
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
