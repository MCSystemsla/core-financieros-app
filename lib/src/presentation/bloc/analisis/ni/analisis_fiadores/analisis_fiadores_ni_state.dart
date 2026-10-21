// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_fiadores_ni_cubit.dart';

class AnalisisFiadoresNiState extends Equatable {
  final Status status;
  final String errorMsg;
  final int numeroSolicitud;
  final String tipoFiadorCodigo;

  // Datos generales
  final String tipoDocumentoCodigo;
  final String cedula;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final DateTime? fechaNacimiento;
  final String paisNacimientoCodigo;
  final String sexoCodigo;
  final String estadoCivilCodigo;
  final String relacionClienteCodigo;
  final int personasACargo;

  // Datos personales
  final String paisCodigo;
  final String departamentoCodigo;
  final String municipioCodigo;
  final String barrioCasa;
  final String direccion;
  final String nacionalidad1Codigo;
  final String telefono;
  final String celular;
  final String email;
  final String escolaridadCodigo;
  final String profesionCodigo;
  final String profesion;
  final String ocupacionCodigo;
  final int cantidadDependientes;
  final int cantidadHijos;
  final String tipoPersonaCNBSCodigo;
  final String estatusCodigo;
  final String tipoClienteCodigo;

  // Actividad económica
  final String actividadEconomicaCNBS1Codigo;
  final String actividadEconomicaDescripcion1;

  // Datos de actividad
  final bool esAsalariado;
  final String empresa;
  final String cargo;
  final String tiempoLaborar;
  final String direccionTrabajo;
  final String barrioTrabajo;
  final String telefonoTrabajo;
  final String lugarTrabajoAnterior;
  final bool esEmpresario;
  final String paisOcupacionCodigo;
  final String departamentoOcupacionCodigo;
  final String municipioOcupacionCodigo;

  // Datos de ingresos
  final double salarioNetoCordoba;
  final double otrosIngresosCordoba;
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
  final String nombreFamiliarCercano;
  final String parentescoFamiliarCercanoCodigo;
  final String direccionFamiliarCercano;
  final String telefonoFamiliarCercano;

  const AnalisisFiadoresNiState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.numeroSolicitud = 0,
    this.tipoFiadorCodigo = '',
    this.tipoDocumentoCodigo = 'CEDULAIDENTIDAD',
    this.cedula = '',
    this.nombre1 = '',
    this.nombre2 = '',
    this.apellido1 = '',
    this.apellido2 = '',
    this.fechaNacimiento,
    this.paisNacimientoCodigo = '',
    this.sexoCodigo = '',
    this.estadoCivilCodigo = '',
    this.relacionClienteCodigo = '',
    this.personasACargo = 0,
    this.paisCodigo = '',
    this.departamentoCodigo = '',
    this.municipioCodigo = '',
    this.barrioCasa = '',
    this.direccion = '',
    this.nacionalidad1Codigo = '',
    this.telefono = '',
    this.celular = '',
    this.email = '',
    this.escolaridadCodigo = '',
    this.profesionCodigo = '',
    this.profesion = '',
    this.ocupacionCodigo = '',
    this.cantidadDependientes = 0,
    this.cantidadHijos = 0,
    this.tipoPersonaCNBSCodigo = '',
    this.estatusCodigo = '',
    this.tipoClienteCodigo = '',
    this.actividadEconomicaCNBS1Codigo = '',
    this.actividadEconomicaDescripcion1 = '',
    this.esAsalariado = false,
    this.empresa = '',
    this.cargo = '',
    this.tiempoLaborar = '',
    this.direccionTrabajo = '',
    this.barrioTrabajo = '',
    this.telefonoTrabajo = '',
    this.lugarTrabajoAnterior = '',
    this.esEmpresario = false,
    this.paisOcupacionCodigo = '',
    this.departamentoOcupacionCodigo = '',
    this.municipioOcupacionCodigo = '',
    this.salarioNetoCordoba = 0,
    this.otrosIngresosCordoba = 0,
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
    this.nombreFamiliarCercano = '',
    this.parentescoFamiliarCercanoCodigo = '',
    this.direccionFamiliarCercano = '',
    this.telefonoFamiliarCercano = '',
  });

  @override
  List<Object?> get props => [
        status,
        errorMsg,
        numeroSolicitud,
        tipoFiadorCodigo,
        tipoDocumentoCodigo,
        cedula,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
        fechaNacimiento,
        paisNacimientoCodigo,
        sexoCodigo,
        estadoCivilCodigo,
        relacionClienteCodigo,
        personasACargo,
        paisCodigo,
        departamentoCodigo,
        municipioCodigo,
        barrioCasa,
        direccion,
        nacionalidad1Codigo,
        telefono,
        celular,
        email,
        escolaridadCodigo,
        profesionCodigo,
        profesion,
        ocupacionCodigo,
        cantidadDependientes,
        cantidadHijos,
        tipoPersonaCNBSCodigo,
        estatusCodigo,
        tipoClienteCodigo,
        actividadEconomicaCNBS1Codigo,
        actividadEconomicaDescripcion1,
        esAsalariado,
        empresa,
        cargo,
        tiempoLaborar,
        direccionTrabajo,
        barrioTrabajo,
        telefonoTrabajo,
        lugarTrabajoAnterior,
        esEmpresario,
        paisOcupacionCodigo,
        departamentoOcupacionCodigo,
        municipioOcupacionCodigo,
        salarioNetoCordoba,
        otrosIngresosCordoba,
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
        nombreFamiliarCercano,
        parentescoFamiliarCercanoCodigo,
        direccionFamiliarCercano,
        telefonoFamiliarCercano,
      ];

  AnalisisFiadoresNiState copyWith({
    Status? status,
    String? errorMsg,
    int? numeroSolicitud,
    String? tipoFiadorCodigo,
    String? tipoDocumentoCodigo,
    String? cedula,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    DateTime? fechaNacimiento,
    String? paisNacimientoCodigo,
    String? sexoCodigo,
    String? estadoCivilCodigo,
    String? relacionClienteCodigo,
    int? personasACargo,
    String? paisCodigo,
    String? departamentoCodigo,
    String? municipioCodigo,
    String? barrioCasa,
    String? direccion,
    String? nacionalidad1Codigo,
    String? telefono,
    String? celular,
    String? email,
    String? escolaridadCodigo,
    String? profesionCodigo,
    String? profesion,
    String? ocupacionCodigo,
    int? cantidadDependientes,
    int? cantidadHijos,
    String? tipoPersonaCNBSCodigo,
    String? estatusCodigo,
    String? tipoClienteCodigo,
    String? actividadEconomicaCNBS1Codigo,
    String? actividadEconomicaDescripcion1,
    bool? esAsalariado,
    String? empresa,
    String? cargo,
    String? tiempoLaborar,
    String? direccionTrabajo,
    String? barrioTrabajo,
    String? telefonoTrabajo,
    String? lugarTrabajoAnterior,
    bool? esEmpresario,
    String? paisOcupacionCodigo,
    String? departamentoOcupacionCodigo,
    String? municipioOcupacionCodigo,
    double? salarioNetoCordoba,
    double? otrosIngresosCordoba,
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
    String? nombreFamiliarCercano,
    String? parentescoFamiliarCercanoCodigo,
    String? direccionFamiliarCercano,
    String? telefonoFamiliarCercano,
  }) {
    return AnalisisFiadoresNiState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      tipoFiadorCodigo: tipoFiadorCodigo ?? this.tipoFiadorCodigo,
      tipoDocumentoCodigo: tipoDocumentoCodigo ?? this.tipoDocumentoCodigo,
      cedula: cedula ?? this.cedula,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      paisNacimientoCodigo: paisNacimientoCodigo ?? this.paisNacimientoCodigo,
      sexoCodigo: sexoCodigo ?? this.sexoCodigo,
      estadoCivilCodigo: estadoCivilCodigo ?? this.estadoCivilCodigo,
      relacionClienteCodigo:
          relacionClienteCodigo ?? this.relacionClienteCodigo,
      personasACargo: personasACargo ?? this.personasACargo,
      paisCodigo: paisCodigo ?? this.paisCodigo,
      departamentoCodigo: departamentoCodigo ?? this.departamentoCodigo,
      municipioCodigo: municipioCodigo ?? this.municipioCodigo,
      barrioCasa: barrioCasa ?? this.barrioCasa,
      direccion: direccion ?? this.direccion,
      nacionalidad1Codigo: nacionalidad1Codigo ?? this.nacionalidad1Codigo,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      email: email ?? this.email,
      escolaridadCodigo: escolaridadCodigo ?? this.escolaridadCodigo,
      profesionCodigo: profesionCodigo ?? this.profesionCodigo,
      profesion: profesion ?? this.profesion,
      ocupacionCodigo: ocupacionCodigo ?? this.ocupacionCodigo,
      cantidadDependientes: cantidadDependientes ?? this.cantidadDependientes,
      cantidadHijos: cantidadHijos ?? this.cantidadHijos,
      tipoPersonaCNBSCodigo:
          tipoPersonaCNBSCodigo ?? this.tipoPersonaCNBSCodigo,
      estatusCodigo: estatusCodigo ?? this.estatusCodigo,
      tipoClienteCodigo: tipoClienteCodigo ?? this.tipoClienteCodigo,
      actividadEconomicaCNBS1Codigo:
          actividadEconomicaCNBS1Codigo ?? this.actividadEconomicaCNBS1Codigo,
      actividadEconomicaDescripcion1: actividadEconomicaDescripcion1 ??
          this.actividadEconomicaDescripcion1,
      esAsalariado: esAsalariado ?? this.esAsalariado,
      empresa: empresa ?? this.empresa,
      cargo: cargo ?? this.cargo,
      tiempoLaborar: tiempoLaborar ?? this.tiempoLaborar,
      direccionTrabajo: direccionTrabajo ?? this.direccionTrabajo,
      barrioTrabajo: barrioTrabajo ?? this.barrioTrabajo,
      telefonoTrabajo: telefonoTrabajo ?? this.telefonoTrabajo,
      lugarTrabajoAnterior: lugarTrabajoAnterior ?? this.lugarTrabajoAnterior,
      esEmpresario: esEmpresario ?? this.esEmpresario,
      paisOcupacionCodigo: paisOcupacionCodigo ?? this.paisOcupacionCodigo,
      departamentoOcupacionCodigo:
          departamentoOcupacionCodigo ?? this.departamentoOcupacionCodigo,
      municipioOcupacionCodigo:
          municipioOcupacionCodigo ?? this.municipioOcupacionCodigo,
      salarioNetoCordoba: salarioNetoCordoba ?? this.salarioNetoCordoba,
      otrosIngresosCordoba: otrosIngresosCordoba ?? this.otrosIngresosCordoba,
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
      nombreFamiliarCercano:
          nombreFamiliarCercano ?? this.nombreFamiliarCercano,
      parentescoFamiliarCercanoCodigo: parentescoFamiliarCercanoCodigo ??
          this.parentescoFamiliarCercanoCodigo,
      direccionFamiliarCercano:
          direccionFamiliarCercano ?? this.direccionFamiliarCercano,
      telefonoFamiliarCercano:
          telefonoFamiliarCercano ?? this.telefonoFamiliarCercano,
    );
  }
}
