// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_fiadores_cubit.dart';

class AnalisisFiadoresState extends Equatable {
  final Status status;
  final String errorMsg;
  final String database;
  final int numeroSolicitud;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String fechaNacimiento;
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
  final String fechaEmisionCedula;
  final String fechaVencimientoCedula;
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
  const AnalisisFiadoresState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.database = '',
    this.numeroSolicitud = 0,
    this.nombre1 = '',
    this.nombre2 = '',
    this.apellido1 = '',
    this.apellido2 = '',
    this.fechaNacimiento = '',
    this.cedula = '',
    this.telefono = '',
    this.celular = '',
    this.direccion = '',
    this.barrioCasa = '',
    this.municipioCodigo = '',
    this.departamentoCodigo = '',
    this.paisCodigo = '',
    this.email = '',
    this.sexoCodigo = '',
    this.estadoCivilCodigo = '',
    this.relacionClienteCodigo = '',
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
    this.personasACargo = 0,
    this.cantidadDependientes = 0,
    this.tieneDocumentosDomicilio = false,
    this.tipoDomicilioCodigo = '',
    this.duenoVivienda = '',
    this.pagoAlquiler = 0,
    this.profesion = 0,
    this.anosVivirDomicilio = 0,
    this.nombreFamiliarCercano = '',
    this.parentescoFamiliarCercanoCodigo = '',
    this.direccionFamiliarCercano = '',
    this.telefonoFamiliarCercano = '',
    this.salarioNetoCordoba = 0,
    this.otrosIngresosCordoba = 0,
    this.totalIngresosFamiliares = 0,
    this.ventaNegocio = 0,
    this.costoVenta = 0,
    this.gastosOperativos = 0,
    this.gananciaNegocio = 0,
    this.otrosIngresos = 0,
    this.fuenteOtrosIngresos = '',
    this.consumoFamiliar = 0,
    this.saldoDisponible = 0,
    this.activo = false,
    this.sucursal = '',
    this.usuarioCreacion = '',
    this.maquinaCreacion = '',
    this.tipoDocumentoCodigo = '',
    this.esFirmaDigitalFiador = false,
    this.rtn = '',
    this.aldeaCodigo = '',
    this.caserioCasa = '',
    this.tipoFiadorCodigo = '',
    this.escolaridadCodigo = '',
    this.ocupacionCodigo = '',
    this.profesionCodigo = '',
    this.paisNacimientoCodigo = '',
    this.fechaEmisionCedula = '',
    this.fechaVencimientoCedula = '',
    this.nacionalidad1Codigo = '',
    this.nacionalidad2Codigo = '',
    this.nacionalidad3Codigo = '',
    this.cantidadHijos = 0,
    this.tipoViviendaCodigo = '',
    this.tipoPersonaCnbsCodigo = '',
    this.estatusCodigo = '',
    this.tipoClienteCodigo = '',
    this.actividadEconomicaCnbs1Codigo = '',
    this.actividadEconomicaDescripcion1 = '',
    this.actividadEconomicaCnbs2Codigo = '',
    this.actividadEconomicaDescripcion2 = '',
    this.actividadEconomicaCnbs3Codigo = '',
    this.actividadEconomicaDescripcion3 = '',
    this.ejerceApnfd = false,
    this.nombreNegocio = '',
    this.tiempoNegocio = 0,
    this.nivelAproximadoIngresosCodigo = '',
    this.puesto = '',
    this.condicionLocalCodigo = '',
    this.horarioVisita = '',
    this.horarioTrabajo = '',
    this.paisOcupacionCodigo = '',
    this.departamentoOcupacionCodigo = '',
    this.municipioOcupacionCodigo = '',
    this.aldeaOcupacionCodigo = '',
    this.caserioOcupacion = '',
    this.celularOcupacion = '',
    this.historialCredito = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        database,
        numeroSolicitud,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
        fechaNacimiento,
        cedula,
        telefono,
        celular,
        direccion,
        barrioCasa,
        municipioCodigo,
        departamentoCodigo,
        paisCodigo,
        email,
        sexoCodigo,
        estadoCivilCodigo,
        relacionClienteCodigo,
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
        personasACargo,
        cantidadDependientes,
        tieneDocumentosDomicilio,
        tipoDomicilioCodigo,
        duenoVivienda,
        pagoAlquiler,
        profesion,
        anosVivirDomicilio,
        nombreFamiliarCercano,
        parentescoFamiliarCercanoCodigo,
        direccionFamiliarCercano,
        telefonoFamiliarCercano,
        salarioNetoCordoba,
        otrosIngresosCordoba,
        totalIngresosFamiliares,
        ventaNegocio,
        costoVenta,
        gastosOperativos,
        gananciaNegocio,
        otrosIngresos,
        fuenteOtrosIngresos,
        consumoFamiliar,
        saldoDisponible,
        activo,
        sucursal,
        usuarioCreacion,
        maquinaCreacion,
        tipoDocumentoCodigo,
        esFirmaDigitalFiador,
        rtn,
        aldeaCodigo,
        caserioCasa,
        tipoFiadorCodigo,
        escolaridadCodigo,
        ocupacionCodigo,
        profesionCodigo,
        paisNacimientoCodigo,
        fechaEmisionCedula,
        fechaVencimientoCedula,
        nacionalidad1Codigo,
        nacionalidad2Codigo,
        nacionalidad3Codigo,
        cantidadHijos,
        tipoViviendaCodigo,
        tipoPersonaCnbsCodigo,
        estatusCodigo,
        tipoClienteCodigo,
        actividadEconomicaCnbs1Codigo,
        actividadEconomicaDescripcion1,
        actividadEconomicaCnbs2Codigo,
        actividadEconomicaDescripcion2,
        actividadEconomicaCnbs3Codigo,
        actividadEconomicaDescripcion3,
        ejerceApnfd,
        nombreNegocio,
        tiempoNegocio,
        nivelAproximadoIngresosCodigo,
        puesto,
        condicionLocalCodigo,
        horarioVisita,
        horarioTrabajo,
        paisOcupacionCodigo,
        departamentoOcupacionCodigo,
        municipioOcupacionCodigo,
        aldeaOcupacionCodigo,
        caserioOcupacion,
        celularOcupacion,
        historialCredito,
      ];

  AnalisisFiadoresState copyWith({
    Status? status,
    String? errorMsg,
    String? database,
    int? numeroSolicitud,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? fechaNacimiento,
    String? cedula,
    String? telefono,
    String? celular,
    String? direccion,
    String? barrioCasa,
    String? municipioCodigo,
    String? departamentoCodigo,
    String? paisCodigo,
    String? email,
    String? sexoCodigo,
    String? estadoCivilCodigo,
    String? relacionClienteCodigo,
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
    int? personasACargo,
    int? cantidadDependientes,
    bool? tieneDocumentosDomicilio,
    String? tipoDomicilioCodigo,
    String? duenoVivienda,
    int? pagoAlquiler,
    int? profesion,
    int? anosVivirDomicilio,
    String? nombreFamiliarCercano,
    String? parentescoFamiliarCercanoCodigo,
    String? direccionFamiliarCercano,
    String? telefonoFamiliarCercano,
    double? salarioNetoCordoba,
    double? otrosIngresosCordoba,
    double? totalIngresosFamiliares,
    int? ventaNegocio,
    int? costoVenta,
    int? gastosOperativos,
    int? gananciaNegocio,
    int? otrosIngresos,
    String? fuenteOtrosIngresos,
    double? consumoFamiliar,
    int? saldoDisponible,
    bool? activo,
    String? sucursal,
    String? usuarioCreacion,
    String? maquinaCreacion,
    String? tipoDocumentoCodigo,
    bool? esFirmaDigitalFiador,
    String? rtn,
    String? aldeaCodigo,
    String? caserioCasa,
    String? tipoFiadorCodigo,
    String? escolaridadCodigo,
    String? ocupacionCodigo,
    String? profesionCodigo,
    String? paisNacimientoCodigo,
    String? fechaEmisionCedula,
    String? fechaVencimientoCedula,
    String? nacionalidad1Codigo,
    String? nacionalidad2Codigo,
    String? nacionalidad3Codigo,
    int? cantidadHijos,
    String? tipoViviendaCodigo,
    String? tipoPersonaCnbsCodigo,
    String? estatusCodigo,
    String? tipoClienteCodigo,
    String? actividadEconomicaCnbs1Codigo,
    String? actividadEconomicaDescripcion1,
    String? actividadEconomicaCnbs2Codigo,
    String? actividadEconomicaDescripcion2,
    String? actividadEconomicaCnbs3Codigo,
    String? actividadEconomicaDescripcion3,
    bool? ejerceApnfd,
    String? nombreNegocio,
    int? tiempoNegocio,
    String? nivelAproximadoIngresosCodigo,
    String? puesto,
    String? condicionLocalCodigo,
    String? horarioVisita,
    String? horarioTrabajo,
    String? paisOcupacionCodigo,
    String? departamentoOcupacionCodigo,
    String? municipioOcupacionCodigo,
    String? aldeaOcupacionCodigo,
    String? caserioOcupacion,
    String? celularOcupacion,
    List<HistorialCredito>? historialCredito,
  }) {
    return AnalisisFiadoresState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      database: database ?? this.database,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      cedula: cedula ?? this.cedula,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      direccion: direccion ?? this.direccion,
      barrioCasa: barrioCasa ?? this.barrioCasa,
      municipioCodigo: municipioCodigo ?? this.municipioCodigo,
      departamentoCodigo: departamentoCodigo ?? this.departamentoCodigo,
      paisCodigo: paisCodigo ?? this.paisCodigo,
      email: email ?? this.email,
      sexoCodigo: sexoCodigo ?? this.sexoCodigo,
      estadoCivilCodigo: estadoCivilCodigo ?? this.estadoCivilCodigo,
      relacionClienteCodigo:
          relacionClienteCodigo ?? this.relacionClienteCodigo,
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
      personasACargo: personasACargo ?? this.personasACargo,
      cantidadDependientes: cantidadDependientes ?? this.cantidadDependientes,
      tieneDocumentosDomicilio:
          tieneDocumentosDomicilio ?? this.tieneDocumentosDomicilio,
      tipoDomicilioCodigo: tipoDomicilioCodigo ?? this.tipoDomicilioCodigo,
      duenoVivienda: duenoVivienda ?? this.duenoVivienda,
      pagoAlquiler: pagoAlquiler ?? this.pagoAlquiler,
      profesion: profesion ?? this.profesion,
      anosVivirDomicilio: anosVivirDomicilio ?? this.anosVivirDomicilio,
      nombreFamiliarCercano:
          nombreFamiliarCercano ?? this.nombreFamiliarCercano,
      parentescoFamiliarCercanoCodigo: parentescoFamiliarCercanoCodigo ??
          this.parentescoFamiliarCercanoCodigo,
      direccionFamiliarCercano:
          direccionFamiliarCercano ?? this.direccionFamiliarCercano,
      telefonoFamiliarCercano:
          telefonoFamiliarCercano ?? this.telefonoFamiliarCercano,
      salarioNetoCordoba: salarioNetoCordoba ?? this.salarioNetoCordoba,
      otrosIngresosCordoba: otrosIngresosCordoba ?? this.otrosIngresosCordoba,
      totalIngresosFamiliares:
          totalIngresosFamiliares ?? this.totalIngresosFamiliares,
      ventaNegocio: ventaNegocio ?? this.ventaNegocio,
      costoVenta: costoVenta ?? this.costoVenta,
      gastosOperativos: gastosOperativos ?? this.gastosOperativos,
      gananciaNegocio: gananciaNegocio ?? this.gananciaNegocio,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      fuenteOtrosIngresos: fuenteOtrosIngresos ?? this.fuenteOtrosIngresos,
      consumoFamiliar: consumoFamiliar ?? this.consumoFamiliar,
      saldoDisponible: saldoDisponible ?? this.saldoDisponible,
      activo: activo ?? this.activo,
      sucursal: sucursal ?? this.sucursal,
      usuarioCreacion: usuarioCreacion ?? this.usuarioCreacion,
      maquinaCreacion: maquinaCreacion ?? this.maquinaCreacion,
      tipoDocumentoCodigo: tipoDocumentoCodigo ?? this.tipoDocumentoCodigo,
      esFirmaDigitalFiador: esFirmaDigitalFiador ?? this.esFirmaDigitalFiador,
      rtn: rtn ?? this.rtn,
      aldeaCodigo: aldeaCodigo ?? this.aldeaCodigo,
      caserioCasa: caserioCasa ?? this.caserioCasa,
      tipoFiadorCodigo: tipoFiadorCodigo ?? this.tipoFiadorCodigo,
      escolaridadCodigo: escolaridadCodigo ?? this.escolaridadCodigo,
      ocupacionCodigo: ocupacionCodigo ?? this.ocupacionCodigo,
      profesionCodigo: profesionCodigo ?? this.profesionCodigo,
      paisNacimientoCodigo: paisNacimientoCodigo ?? this.paisNacimientoCodigo,
      fechaEmisionCedula: fechaEmisionCedula ?? this.fechaEmisionCedula,
      fechaVencimientoCedula:
          fechaVencimientoCedula ?? this.fechaVencimientoCedula,
      nacionalidad1Codigo: nacionalidad1Codigo ?? this.nacionalidad1Codigo,
      nacionalidad2Codigo: nacionalidad2Codigo ?? this.nacionalidad2Codigo,
      nacionalidad3Codigo: nacionalidad3Codigo ?? this.nacionalidad3Codigo,
      cantidadHijos: cantidadHijos ?? this.cantidadHijos,
      tipoViviendaCodigo: tipoViviendaCodigo ?? this.tipoViviendaCodigo,
      tipoPersonaCnbsCodigo:
          tipoPersonaCnbsCodigo ?? this.tipoPersonaCnbsCodigo,
      estatusCodigo: estatusCodigo ?? this.estatusCodigo,
      tipoClienteCodigo: tipoClienteCodigo ?? this.tipoClienteCodigo,
      actividadEconomicaCnbs1Codigo:
          actividadEconomicaCnbs1Codigo ?? this.actividadEconomicaCnbs1Codigo,
      actividadEconomicaDescripcion1:
          actividadEconomicaDescripcion1 ?? this.actividadEconomicaDescripcion1,
      actividadEconomicaCnbs2Codigo:
          actividadEconomicaCnbs2Codigo ?? this.actividadEconomicaCnbs2Codigo,
      actividadEconomicaDescripcion2:
          actividadEconomicaDescripcion2 ?? this.actividadEconomicaDescripcion2,
      actividadEconomicaCnbs3Codigo:
          actividadEconomicaCnbs3Codigo ?? this.actividadEconomicaCnbs3Codigo,
      actividadEconomicaDescripcion3:
          actividadEconomicaDescripcion3 ?? this.actividadEconomicaDescripcion3,
      ejerceApnfd: ejerceApnfd ?? this.ejerceApnfd,
      nombreNegocio: nombreNegocio ?? this.nombreNegocio,
      tiempoNegocio: tiempoNegocio ?? this.tiempoNegocio,
      nivelAproximadoIngresosCodigo:
          nivelAproximadoIngresosCodigo ?? this.nivelAproximadoIngresosCodigo,
      puesto: puesto ?? this.puesto,
      condicionLocalCodigo: condicionLocalCodigo ?? this.condicionLocalCodigo,
      horarioVisita: horarioVisita ?? this.horarioVisita,
      horarioTrabajo: horarioTrabajo ?? this.horarioTrabajo,
      paisOcupacionCodigo: paisOcupacionCodigo ?? this.paisOcupacionCodigo,
      departamentoOcupacionCodigo:
          departamentoOcupacionCodigo ?? this.departamentoOcupacionCodigo,
      municipioOcupacionCodigo:
          municipioOcupacionCodigo ?? this.municipioOcupacionCodigo,
      aldeaOcupacionCodigo: aldeaOcupacionCodigo ?? this.aldeaOcupacionCodigo,
      caserioOcupacion: caserioOcupacion ?? this.caserioOcupacion,
      celularOcupacion: celularOcupacion ?? this.celularOcupacion,
      historialCredito: historialCredito ?? this.historialCredito,
    );
  }
}

final class AnalisisFiadoresInitial extends AnalisisFiadoresState {}
