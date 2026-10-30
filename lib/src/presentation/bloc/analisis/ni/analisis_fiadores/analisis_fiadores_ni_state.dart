// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_fiadores_ni_cubit.dart';

class AnalisisFiadoresNiState extends Equatable {
  final Status status;
  final String errorMsg;
  // true si el último envío falló por red (sin conexión o timeout): solo
  // entonces se ofrece guardar el fiador en el teléfono.
  final bool isNetworkError;
  final int numeroSolicitud;

  // Datos personales
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final DateTime? fechaNacimiento;
  final String tipoDocumentoCodigo;
  final String cedula;
  final String sexoCodigo;
  final String estadoCivilCodigo;
  final String relacionClienteCodigo;

  // Contacto y domicilio
  final String telefono;
  final String celular;
  final String email;
  final int personasACargo;
  final int cantidadDependientes;
  final String direccion;
  final String barrioCasa;
  final String paisCodigo;
  final String departamentoCodigo;
  final String municipioCodigo;
  final String profesion;

  // Datos laborales
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

  // Ingresos y vivienda
  final double salarioNetoCordoba;
  final double otrosIngresosCordoba;
  final String fuenteOtrosIngresos;
  final double totalIngresosFamiliares;
  final double ventaNegocio;
  final double costoVenta;
  final double gastosOperativos;
  final double gananciaNegocio;
  final double otrosIngresos;
  final double consumoFamiliar;
  final double saldoDisponible;
  final String tipoDomicilioCodigo;
  final int anosVivirDomicilio;
  final bool tieneDocumentosDomicilio;
  final String duenoVivienda;
  final double pagoAlquiler;
  final String nombreFamiliarCercano;
  final String parentescoFamiliarCercanoCodigo;
  final String telefonoFamiliarCercano;
  final String direccionFamiliarCercano;

  const AnalisisFiadoresNiState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.isNetworkError = false,
    this.numeroSolicitud = 0,
    this.nombre1 = '',
    this.nombre2 = '',
    this.apellido1 = '',
    this.apellido2 = '',
    this.fechaNacimiento,
    this.tipoDocumentoCodigo = 'CEDULAIDENTIDAD',
    this.cedula = '',
    this.sexoCodigo = '',
    this.estadoCivilCodigo = '',
    this.relacionClienteCodigo = '',
    this.telefono = '',
    this.celular = '',
    this.email = '',
    this.personasACargo = 0,
    this.cantidadDependientes = 0,
    this.direccion = '',
    this.barrioCasa = '',
    this.paisCodigo = '',
    this.departamentoCodigo = '',
    this.municipioCodigo = '',
    this.profesion = '',
    this.esAsalariado = false,
    this.empresa = '',
    this.cargo = '',
    this.tiempoLaborar = '',
    this.esEmpresario = false,
    this.actividadCodigo = '',
    this.tiempoActividad = '',
    this.direccionTrabajo = '',
    this.barrioTrabajo = '',
    this.telefonoTrabajo = '',
    this.lugarTrabajoAnterior = '',
    this.salarioNetoCordoba = 0,
    this.otrosIngresosCordoba = 0,
    this.fuenteOtrosIngresos = '',
    this.totalIngresosFamiliares = 0,
    this.ventaNegocio = 0,
    this.costoVenta = 0,
    this.gastosOperativos = 0,
    this.gananciaNegocio = 0,
    this.otrosIngresos = 0,
    this.consumoFamiliar = 0,
    this.saldoDisponible = 0,
    this.tipoDomicilioCodigo = '',
    this.anosVivirDomicilio = 0,
    this.tieneDocumentosDomicilio = false,
    this.duenoVivienda = '',
    this.pagoAlquiler = 0,
    this.nombreFamiliarCercano = '',
    this.parentescoFamiliarCercanoCodigo = '',
    this.telefonoFamiliarCercano = '',
    this.direccionFamiliarCercano = '',
  });

  @override
  List<Object?> get props => [
        status,
        errorMsg,
        isNetworkError,
        numeroSolicitud,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
        fechaNacimiento,
        tipoDocumentoCodigo,
        cedula,
        sexoCodigo,
        estadoCivilCodigo,
        relacionClienteCodigo,
        telefono,
        celular,
        email,
        personasACargo,
        cantidadDependientes,
        direccion,
        barrioCasa,
        paisCodigo,
        departamentoCodigo,
        municipioCodigo,
        profesion,
        esAsalariado,
        empresa,
        cargo,
        tiempoLaborar,
        esEmpresario,
        actividadCodigo,
        tiempoActividad,
        direccionTrabajo,
        barrioTrabajo,
        telefonoTrabajo,
        lugarTrabajoAnterior,
        salarioNetoCordoba,
        otrosIngresosCordoba,
        fuenteOtrosIngresos,
        totalIngresosFamiliares,
        ventaNegocio,
        costoVenta,
        gastosOperativos,
        gananciaNegocio,
        otrosIngresos,
        consumoFamiliar,
        saldoDisponible,
        tipoDomicilioCodigo,
        anosVivirDomicilio,
        tieneDocumentosDomicilio,
        duenoVivienda,
        pagoAlquiler,
        nombreFamiliarCercano,
        parentescoFamiliarCercanoCodigo,
        telefonoFamiliarCercano,
        direccionFamiliarCercano,
      ];

  AnalisisFiadoresNiState copyWith({
    Status? status,
    String? errorMsg,
    bool? isNetworkError,
    int? numeroSolicitud,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    DateTime? fechaNacimiento,
    String? tipoDocumentoCodigo,
    String? cedula,
    String? sexoCodigo,
    String? estadoCivilCodigo,
    String? relacionClienteCodigo,
    String? telefono,
    String? celular,
    String? email,
    int? personasACargo,
    int? cantidadDependientes,
    String? direccion,
    String? barrioCasa,
    String? paisCodigo,
    String? departamentoCodigo,
    String? municipioCodigo,
    String? profesion,
    bool? esAsalariado,
    String? empresa,
    String? cargo,
    String? tiempoLaborar,
    bool? esEmpresario,
    String? actividadCodigo,
    String? tiempoActividad,
    String? direccionTrabajo,
    String? barrioTrabajo,
    String? telefonoTrabajo,
    String? lugarTrabajoAnterior,
    double? salarioNetoCordoba,
    double? otrosIngresosCordoba,
    String? fuenteOtrosIngresos,
    double? totalIngresosFamiliares,
    double? ventaNegocio,
    double? costoVenta,
    double? gastosOperativos,
    double? gananciaNegocio,
    double? otrosIngresos,
    double? consumoFamiliar,
    double? saldoDisponible,
    String? tipoDomicilioCodigo,
    int? anosVivirDomicilio,
    bool? tieneDocumentosDomicilio,
    String? duenoVivienda,
    double? pagoAlquiler,
    String? nombreFamiliarCercano,
    String? parentescoFamiliarCercanoCodigo,
    String? telefonoFamiliarCercano,
    String? direccionFamiliarCercano,
  }) {
    return AnalisisFiadoresNiState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      isNetworkError: isNetworkError ?? this.isNetworkError,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      tipoDocumentoCodigo: tipoDocumentoCodigo ?? this.tipoDocumentoCodigo,
      cedula: cedula ?? this.cedula,
      sexoCodigo: sexoCodigo ?? this.sexoCodigo,
      estadoCivilCodigo: estadoCivilCodigo ?? this.estadoCivilCodigo,
      relacionClienteCodigo:
          relacionClienteCodigo ?? this.relacionClienteCodigo,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      email: email ?? this.email,
      personasACargo: personasACargo ?? this.personasACargo,
      cantidadDependientes: cantidadDependientes ?? this.cantidadDependientes,
      direccion: direccion ?? this.direccion,
      barrioCasa: barrioCasa ?? this.barrioCasa,
      paisCodigo: paisCodigo ?? this.paisCodigo,
      departamentoCodigo: departamentoCodigo ?? this.departamentoCodigo,
      municipioCodigo: municipioCodigo ?? this.municipioCodigo,
      profesion: profesion ?? this.profesion,
      esAsalariado: esAsalariado ?? this.esAsalariado,
      empresa: empresa ?? this.empresa,
      cargo: cargo ?? this.cargo,
      tiempoLaborar: tiempoLaborar ?? this.tiempoLaborar,
      esEmpresario: esEmpresario ?? this.esEmpresario,
      actividadCodigo: actividadCodigo ?? this.actividadCodigo,
      tiempoActividad: tiempoActividad ?? this.tiempoActividad,
      direccionTrabajo: direccionTrabajo ?? this.direccionTrabajo,
      barrioTrabajo: barrioTrabajo ?? this.barrioTrabajo,
      telefonoTrabajo: telefonoTrabajo ?? this.telefonoTrabajo,
      lugarTrabajoAnterior: lugarTrabajoAnterior ?? this.lugarTrabajoAnterior,
      salarioNetoCordoba: salarioNetoCordoba ?? this.salarioNetoCordoba,
      otrosIngresosCordoba: otrosIngresosCordoba ?? this.otrosIngresosCordoba,
      fuenteOtrosIngresos: fuenteOtrosIngresos ?? this.fuenteOtrosIngresos,
      totalIngresosFamiliares:
          totalIngresosFamiliares ?? this.totalIngresosFamiliares,
      ventaNegocio: ventaNegocio ?? this.ventaNegocio,
      costoVenta: costoVenta ?? this.costoVenta,
      gastosOperativos: gastosOperativos ?? this.gastosOperativos,
      gananciaNegocio: gananciaNegocio ?? this.gananciaNegocio,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      consumoFamiliar: consumoFamiliar ?? this.consumoFamiliar,
      saldoDisponible: saldoDisponible ?? this.saldoDisponible,
      tipoDomicilioCodigo: tipoDomicilioCodigo ?? this.tipoDomicilioCodigo,
      anosVivirDomicilio: anosVivirDomicilio ?? this.anosVivirDomicilio,
      tieneDocumentosDomicilio:
          tieneDocumentosDomicilio ?? this.tieneDocumentosDomicilio,
      duenoVivienda: duenoVivienda ?? this.duenoVivienda,
      pagoAlquiler: pagoAlquiler ?? this.pagoAlquiler,
      nombreFamiliarCercano:
          nombreFamiliarCercano ?? this.nombreFamiliarCercano,
      parentescoFamiliarCercanoCodigo: parentescoFamiliarCercanoCodigo ??
          this.parentescoFamiliarCercanoCodigo,
      telefonoFamiliarCercano:
          telefonoFamiliarCercano ?? this.telefonoFamiliarCercano,
      direccionFamiliarCercano:
          direccionFamiliarCercano ?? this.direccionFamiliarCercano,
    );
  }
}
