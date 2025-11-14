// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_nueva_mayor_mil_hn_cubit.dart';

class AnalisisNuevaMayorMilHnState extends Equatable {
  final int numeroSolicitud;
  final int idLocalResponse;
  final String? uuid;
  final String errorMsg;
  final Status status;
  final String database;
  final double totalIngresosFueraNegocio;
  final double alimentacionFam;
  final double educacionFam;
  final double aguaFam;
  final double alquilerFam;
  final double aseoLimpiezaFam;
  final double vestimentaCalzadoFam;
  final double transporteFam;
  final double otrosGastosFam;
  final double pagoCreditosFam;
  final double totalConsumoFamiliar;
  final String numeroLicencia;
  final String nombreInstitucionLicencia;
  final String fechaEmisionLicencia;
  final String fechaVencimientoLicencia;
  final double ingresoAnual;
  final String cliente1;
  final String cliente2;
  final String cliente3;
  final String proveedor1;
  final String proveedor2;
  final String proveedor3;
  final String fechaVerificacion1;
  final String nombreReferencia1;
  final String cedulaReferencia1;
  final String direccionReferencia1;
  final String telefonoReferencia1;
  final String lugarTrabajoReferencia1;
  final double aniosConocerReferido1;
  final String parentescoReferenciaCodigo1;
  final String resultadoVerificacion1;
  final String fechaVerificacion2;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final double aniosConocerReferido2;
  final String parentescoReferenciaCodigo2;
  final String resultadoVerificacion2;
  final double semanasBuenas;
  final double semanasNormales;
  final double semanasMalas;
  final double totalComprasMensuales;
  final double totalVentasSegunCompras;
  final double totalCostoPersonal;
  final double totalUltimaCompra;
  final double diasBuenosVenta;
  final double diasNormalesVenta;
  final double diasMalosVenta;
  final double totalVentasDiarias;
  final double totalVentasMensuales;
  final double totalAbono;
  final double totalVentasMensualSegunNumClientes;
  final double totalVentasSegunNivelProduccion;
  final double porcentajeProdAltaRotacion;
  final double valorAltaRotacion;
  final double porcentajeProdBajaRotacion;
  final double valorBajaRotacion;
  final double caja;
  final double reservas;
  final double cuentasAhorro;
  final double totalDisponibleActivo;
  final double incobrables;
  final double totalClientes;
  final double adelantoProveedores;
  final double totalCuentasXCobrar;
  final double totalInventario;
  final double totalActivosCorrientes;
  final double totalActivosFijos;
  final double totalActivos;
  final double totalProveedoresAdelantos;
  final double totalCreditosInstAmigos;
  final double totalPasivos;
  final double patrimonio;
  final double pasivosMasPatrimonio;
  final double ventasContado;
  final double recuperaciones;
  final double totalIngresos;
  final double costoVentaProduccion;
  final double utilidadBruta;
  final double gastosPersonalAlimentacion;
  final double subContratos;
  final double alquilerlocal;
  final double agua;
  final double combustible;
  final double transporte;
  final double pagoCuotaCredito;
  final double impuesto;
  final double otros;
  final double totalCostosOperativos;
  final double resultadoLiquido;
  final double consumoFamiliar;
  final double ingresosFueraNegocio;
  final double saldoDisponibleUf;
  final double costoVentaPorcentaje;
  final String fechaVerificacion3;
  final String nombreReferencia3;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String telefonoReferencia3;
  final String lugarTrabajoReferencia3;
  final int aniosConocerReferido3;
  final String parentescoReferenciaCodigo3;
  final String resultadoVerificacion3;
  final double salud;
  final String permisoOperacionNumero;
  final String permisoOperacionNombreInstitucion;
  final String permisoOperacionFechaEmision;
  final String permisoOperacionFechaVencimiento;
  final CicloVentaHN cicloVentaMensual;
  final CicloVentaDiaria cicloVentaDiaria;
  final List<NivelProduccionHN> nivelProduccion;
  final List<CuentasPorCobrarHN> cuentasPorCobrar;
  final List<CicloDeComprasSemanalHN> cicloDeComprasSemanales;
  final List<ComprasProveedorArticuloHN> comprasProveedorArticulo;
  final List<CostoDePersonalHN> costoDePersonal;
  final List<IngresosFamilaresFueraNegocioHN> ingeresosFamilaresFueraNegocio;
  final List<OtrosCreditoHN> otrosCreditos;
  final List<PasivoHN> pasivos;
  final List<ActivoHN> activos;
  const AnalisisNuevaMayorMilHnState({
    this.numeroSolicitud = 0,
    this.idLocalResponse = 0,
    this.uuid,
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.database = '',
    this.totalIngresosFueraNegocio = 0,
    this.alimentacionFam = 0,
    this.educacionFam = 0,
    this.aguaFam = 0,
    this.alquilerFam = 0,
    this.aseoLimpiezaFam = 0,
    this.vestimentaCalzadoFam = 0,
    this.transporteFam = 0,
    this.otrosGastosFam = 0,
    this.pagoCreditosFam = 0,
    this.totalConsumoFamiliar = 0,
    this.numeroLicencia = '',
    this.nombreInstitucionLicencia = '',
    this.fechaEmisionLicencia = '',
    this.fechaVencimientoLicencia = '',
    this.ingresoAnual = 0,
    this.cliente1 = '',
    this.cliente2 = '',
    this.cliente3 = '',
    this.proveedor1 = '',
    this.proveedor2 = '',
    this.proveedor3 = '',
    this.fechaVerificacion1 = '',
    this.nombreReferencia1 = '',
    this.cedulaReferencia1 = '',
    this.direccionReferencia1 = '',
    this.telefonoReferencia1 = '',
    this.lugarTrabajoReferencia1 = '',
    this.aniosConocerReferido1 = 0,
    this.parentescoReferenciaCodigo1 = '',
    this.resultadoVerificacion1 = '',
    this.fechaVerificacion2 = '',
    this.nombreReferencia2 = '',
    this.cedulaReferencia2 = '',
    this.direccionReferencia2 = '',
    this.telefonoReferencia2 = '',
    this.lugarTrabajoReferencia2 = '',
    this.aniosConocerReferido2 = 0,
    this.parentescoReferenciaCodigo2 = '',
    this.resultadoVerificacion2 = '',
    this.semanasBuenas = 0,
    this.semanasNormales = 0,
    this.semanasMalas = 0,
    this.totalComprasMensuales = 0,
    this.totalVentasSegunCompras = 0,
    this.totalCostoPersonal = 0,
    this.totalUltimaCompra = 0,
    this.diasBuenosVenta = 0,
    this.diasNormalesVenta = 0,
    this.diasMalosVenta = 0,
    this.totalVentasDiarias = 0,
    this.totalVentasMensuales = 0,
    this.totalAbono = 0,
    this.totalVentasMensualSegunNumClientes = 0,
    this.totalVentasSegunNivelProduccion = 0,
    this.porcentajeProdAltaRotacion = 0,
    this.valorAltaRotacion = 0,
    this.porcentajeProdBajaRotacion = 0,
    this.valorBajaRotacion = 0,
    this.caja = 0,
    this.reservas = 0,
    this.cuentasAhorro = 0,
    this.totalDisponibleActivo = 0,
    this.incobrables = 0,
    this.totalClientes = 0,
    this.adelantoProveedores = 0,
    this.totalCuentasXCobrar = 0,
    this.totalInventario = 0,
    this.totalActivosCorrientes = 0,
    this.totalActivosFijos = 0,
    this.totalActivos = 0,
    this.totalProveedoresAdelantos = 0,
    this.totalCreditosInstAmigos = 0,
    this.totalPasivos = 0,
    this.patrimonio = 0,
    this.pasivosMasPatrimonio = 0,
    this.ventasContado = 0,
    this.recuperaciones = 0,
    this.totalIngresos = 0,
    this.costoVentaProduccion = 0,
    this.utilidadBruta = 0,
    this.gastosPersonalAlimentacion = 0,
    this.subContratos = 0,
    this.alquilerlocal = 0,
    this.agua = 0,
    this.combustible = 0,
    this.transporte = 0,
    this.pagoCuotaCredito = 0,
    this.impuesto = 0,
    this.otros = 0,
    this.totalCostosOperativos = 0,
    this.resultadoLiquido = 0,
    this.consumoFamiliar = 0,
    this.ingresosFueraNegocio = 0,
    this.saldoDisponibleUf = 0,
    this.costoVentaPorcentaje = 0,
    this.fechaVerificacion3 = '',
    this.nombreReferencia3 = '',
    this.cedulaReferencia3 = '',
    this.direccionReferencia3 = '',
    this.telefonoReferencia3 = '',
    this.lugarTrabajoReferencia3 = '',
    this.aniosConocerReferido3 = 0,
    this.parentescoReferenciaCodigo3 = '',
    this.resultadoVerificacion3 = '',
    this.salud = 0,
    this.permisoOperacionNumero = '',
    this.permisoOperacionNombreInstitucion = '',
    this.permisoOperacionFechaEmision = '',
    this.permisoOperacionFechaVencimiento = '',
    this.cicloVentaMensual = const CicloVentaHN(
      totalVentasDiaria: 0,
      ciclo: [],
    ),
    this.cicloVentaDiaria = const CicloVentaDiaria(
      totalVentasDiaria: 0,
      cicloVentas: [],
    ),
    this.nivelProduccion = const [],
    this.cuentasPorCobrar = const [],
    this.cicloDeComprasSemanales = const [],
    this.comprasProveedorArticulo = const [],
    this.costoDePersonal = const [],
    this.ingeresosFamilaresFueraNegocio = const [],
    this.otrosCreditos = const [],
    this.pasivos = const [],
    this.activos = const [],
  });

  @override
  List<Object> get props => [
        cicloVentaMensual,
        valorAltaRotacion,
        numeroSolicitud,
        idLocalResponse,
        errorMsg,
        status,
        database,
        totalIngresosFueraNegocio,
        alimentacionFam,
        educacionFam,
        aguaFam,
        alquilerFam,
        aseoLimpiezaFam,
        vestimentaCalzadoFam,
        transporteFam,
        otrosGastosFam,
        pagoCreditosFam,
        totalConsumoFamiliar,
        numeroLicencia,
        nombreInstitucionLicencia,
        fechaEmisionLicencia,
        fechaVencimientoLicencia,
        ingresoAnual,
        cliente1,
        cliente2,
        cliente3,
        proveedor1,
        proveedor2,
        proveedor3,
        fechaVerificacion1,
        nombreReferencia1,
        cedulaReferencia1,
        direccionReferencia1,
        telefonoReferencia1,
        lugarTrabajoReferencia1,
        aniosConocerReferido1,
        parentescoReferenciaCodigo1,
        resultadoVerificacion1,
        fechaVerificacion2,
        nombreReferencia2,
        cedulaReferencia2,
        direccionReferencia2,
        telefonoReferencia2,
        lugarTrabajoReferencia2,
        aniosConocerReferido2,
        parentescoReferenciaCodigo2,
        resultadoVerificacion2,
        semanasBuenas,
        semanasNormales,
        semanasMalas,
        totalComprasMensuales,
        totalVentasSegunCompras,
        totalCostoPersonal,
        totalUltimaCompra,
        diasBuenosVenta,
        diasNormalesVenta,
        diasMalosVenta,
        totalVentasDiarias,
        totalVentasMensuales,
        totalAbono,
        totalVentasMensualSegunNumClientes,
        totalVentasSegunNivelProduccion,
        porcentajeProdAltaRotacion,
        porcentajeProdBajaRotacion,
        valorBajaRotacion,
        caja,
        reservas,
        cuentasAhorro,
        totalDisponibleActivo,
        incobrables,
        totalClientes,
        adelantoProveedores,
        totalCuentasXCobrar,
        totalInventario,
        totalActivosCorrientes,
        totalActivosFijos,
        totalActivos,
        totalProveedoresAdelantos,
        totalCreditosInstAmigos,
        totalPasivos,
        patrimonio,
        pasivosMasPatrimonio,
        ventasContado,
        recuperaciones,
        totalIngresos,
        costoVentaProduccion,
        utilidadBruta,
        gastosPersonalAlimentacion,
        subContratos,
        alquilerlocal,
        agua,
        combustible,
        transporte,
        pagoCuotaCredito,
        impuesto,
        otros,
        totalCostosOperativos,
        resultadoLiquido,
        consumoFamiliar,
        ingresosFueraNegocio,
        saldoDisponibleUf,
        costoVentaPorcentaje,
        fechaVerificacion3,
        nombreReferencia3,
        cedulaReferencia3,
        direccionReferencia3,
        telefonoReferencia3,
        lugarTrabajoReferencia3,
        aniosConocerReferido3,
        parentescoReferenciaCodigo3,
        resultadoVerificacion3,
        salud,
        permisoOperacionNumero,
        permisoOperacionNombreInstitucion,
        permisoOperacionFechaEmision,
        permisoOperacionFechaVencimiento,
        cicloVentaDiaria,
        nivelProduccion,
        cuentasPorCobrar,
        cicloDeComprasSemanales,
        comprasProveedorArticulo,
        costoDePersonal,
        ingeresosFamilaresFueraNegocio,
        otrosCreditos,
        pasivos,
        activos,
      ];

  AnalisisNuevaMayorMilHnState copyWith({
    int? numeroSolicitud,
    int? idLocalResponse,
    String? uuid,
    String? errorMsg,
    Status? status,
    String? database,
    double? totalIngresosFueraNegocio,
    double? alimentacionFam,
    double? educacionFam,
    double? aguaFam,
    double? alquilerFam,
    double? aseoLimpiezaFam,
    double? vestimentaCalzadoFam,
    double? transporteFam,
    double? otrosGastosFam,
    double? pagoCreditosFam,
    double? totalConsumoFamiliar,
    String? numeroLicencia,
    String? nombreInstitucionLicencia,
    String? fechaEmisionLicencia,
    String? fechaVencimientoLicencia,
    double? ingresoAnual,
    String? cliente1,
    String? cliente2,
    String? cliente3,
    String? proveedor1,
    String? proveedor2,
    String? proveedor3,
    String? fechaVerificacion1,
    String? nombreReferencia1,
    String? cedulaReferencia1,
    String? direccionReferencia1,
    String? telefonoReferencia1,
    String? lugarTrabajoReferencia1,
    double? aniosConocerReferido1,
    String? parentescoReferenciaCodigo1,
    String? resultadoVerificacion1,
    String? fechaVerificacion2,
    String? nombreReferencia2,
    String? cedulaReferencia2,
    String? direccionReferencia2,
    String? telefonoReferencia2,
    String? lugarTrabajoReferencia2,
    double? aniosConocerReferido2,
    String? parentescoReferenciaCodigo2,
    String? resultadoVerificacion2,
    double? semanasBuenas,
    double? semanasNormales,
    double? semanasMalas,
    double? totalComprasMensuales,
    double? totalVentasSegunCompras,
    double? totalCostoPersonal,
    double? totalUltimaCompra,
    double? diasBuenosVenta,
    double? diasNormalesVenta,
    double? diasMalosVenta,
    double? totalVentasDiarias,
    double? totalVentasMensuales,
    double? totalAbono,
    double? totalVentasMensualSegunNumClientes,
    double? totalVentasSegunNivelProduccion,
    double? porcentajeProdAltaRotacion,
    double? valorAltaRotacion,
    double? porcentajeProdBajaRotacion,
    double? valorBajaRotacion,
    double? caja,
    double? reservas,
    double? cuentasAhorro,
    double? totalDisponibleActivo,
    double? incobrables,
    double? totalClientes,
    double? adelantoProveedores,
    double? totalCuentasXCobrar,
    double? totalInventario,
    double? totalActivosCorrientes,
    double? totalActivosFijos,
    double? totalActivos,
    double? totalProveedoresAdelantos,
    double? totalCreditosInstAmigos,
    double? totalPasivos,
    double? patrimonio,
    double? pasivosMasPatrimonio,
    double? ventasContado,
    double? recuperaciones,
    double? totalIngresos,
    double? costoVentaProduccion,
    double? utilidadBruta,
    double? gastosPersonalAlimentacion,
    double? subContratos,
    double? alquilerlocal,
    double? agua,
    double? combustible,
    double? transporte,
    double? pagoCuotaCredito,
    double? impuesto,
    double? otros,
    double? totalCostosOperativos,
    double? resultadoLiquido,
    double? consumoFamiliar,
    double? ingresosFueraNegocio,
    double? saldoDisponibleUf,
    double? costoVentaPorcentaje,
    String? fechaVerificacion3,
    String? nombreReferencia3,
    String? cedulaReferencia3,
    String? direccionReferencia3,
    String? telefonoReferencia3,
    String? lugarTrabajoReferencia3,
    int? aniosConocerReferido3,
    String? parentescoReferenciaCodigo3,
    String? resultadoVerificacion3,
    double? salud,
    String? permisoOperacionNumero,
    String? permisoOperacionNombreInstitucion,
    String? permisoOperacionFechaEmision,
    String? permisoOperacionFechaVencimiento,
    CicloVentaHN? cicloVentaMensual,
    CicloVentaDiaria? cicloVentaDiaria,
    List<NivelProduccionHN>? nivelProduccion,
    List<CuentasPorCobrarHN>? cuentasPorCobrar,
    List<CicloDeComprasSemanalHN>? cicloDeComprasSemanales,
    List<ComprasProveedorArticuloHN>? comprasProveedorArticulo,
    List<CostoDePersonalHN>? costoDePersonal,
    List<IngresosFamilaresFueraNegocioHN>? ingeresosFamilaresFueraNegocio,
    List<OtrosCreditoHN>? otrosCreditos,
    List<PasivoHN>? pasivos,
    List<ActivoHN>? activos,
  }) {
    return AnalisisNuevaMayorMilHnState(
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      uuid: uuid ?? this.uuid,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      database: database ?? this.database,
      totalIngresosFueraNegocio:
          totalIngresosFueraNegocio ?? this.totalIngresosFueraNegocio,
      alimentacionFam: alimentacionFam ?? this.alimentacionFam,
      educacionFam: educacionFam ?? this.educacionFam,
      aguaFam: aguaFam ?? this.aguaFam,
      alquilerFam: alquilerFam ?? this.alquilerFam,
      aseoLimpiezaFam: aseoLimpiezaFam ?? this.aseoLimpiezaFam,
      vestimentaCalzadoFam: vestimentaCalzadoFam ?? this.vestimentaCalzadoFam,
      transporteFam: transporteFam ?? this.transporteFam,
      otrosGastosFam: otrosGastosFam ?? this.otrosGastosFam,
      pagoCreditosFam: pagoCreditosFam ?? this.pagoCreditosFam,
      totalConsumoFamiliar: totalConsumoFamiliar ?? this.totalConsumoFamiliar,
      numeroLicencia: numeroLicencia ?? this.numeroLicencia,
      nombreInstitucionLicencia:
          nombreInstitucionLicencia ?? this.nombreInstitucionLicencia,
      fechaEmisionLicencia: fechaEmisionLicencia ?? this.fechaEmisionLicencia,
      fechaVencimientoLicencia:
          fechaVencimientoLicencia ?? this.fechaVencimientoLicencia,
      ingresoAnual: ingresoAnual ?? this.ingresoAnual,
      cliente1: cliente1 ?? this.cliente1,
      cliente2: cliente2 ?? this.cliente2,
      cliente3: cliente3 ?? this.cliente3,
      proveedor1: proveedor1 ?? this.proveedor1,
      proveedor2: proveedor2 ?? this.proveedor2,
      proveedor3: proveedor3 ?? this.proveedor3,
      fechaVerificacion1: fechaVerificacion1 ?? this.fechaVerificacion1,
      nombreReferencia1: nombreReferencia1 ?? this.nombreReferencia1,
      cedulaReferencia1: cedulaReferencia1 ?? this.cedulaReferencia1,
      direccionReferencia1: direccionReferencia1 ?? this.direccionReferencia1,
      telefonoReferencia1: telefonoReferencia1 ?? this.telefonoReferencia1,
      lugarTrabajoReferencia1:
          lugarTrabajoReferencia1 ?? this.lugarTrabajoReferencia1,
      aniosConocerReferido1:
          aniosConocerReferido1 ?? this.aniosConocerReferido1,
      parentescoReferenciaCodigo1:
          parentescoReferenciaCodigo1 ?? this.parentescoReferenciaCodigo1,
      resultadoVerificacion1:
          resultadoVerificacion1 ?? this.resultadoVerificacion1,
      fechaVerificacion2: fechaVerificacion2 ?? this.fechaVerificacion2,
      nombreReferencia2: nombreReferencia2 ?? this.nombreReferencia2,
      cedulaReferencia2: cedulaReferencia2 ?? this.cedulaReferencia2,
      direccionReferencia2: direccionReferencia2 ?? this.direccionReferencia2,
      telefonoReferencia2: telefonoReferencia2 ?? this.telefonoReferencia2,
      lugarTrabajoReferencia2:
          lugarTrabajoReferencia2 ?? this.lugarTrabajoReferencia2,
      aniosConocerReferido2:
          aniosConocerReferido2 ?? this.aniosConocerReferido2,
      parentescoReferenciaCodigo2:
          parentescoReferenciaCodigo2 ?? this.parentescoReferenciaCodigo2,
      resultadoVerificacion2:
          resultadoVerificacion2 ?? this.resultadoVerificacion2,
      semanasBuenas: semanasBuenas ?? this.semanasBuenas,
      semanasNormales: semanasNormales ?? this.semanasNormales,
      semanasMalas: semanasMalas ?? this.semanasMalas,
      totalComprasMensuales:
          totalComprasMensuales ?? this.totalComprasMensuales,
      totalVentasSegunCompras:
          totalVentasSegunCompras ?? this.totalVentasSegunCompras,
      totalCostoPersonal: totalCostoPersonal ?? this.totalCostoPersonal,
      totalUltimaCompra: totalUltimaCompra ?? this.totalUltimaCompra,
      diasBuenosVenta: diasBuenosVenta ?? this.diasBuenosVenta,
      diasNormalesVenta: diasNormalesVenta ?? this.diasNormalesVenta,
      diasMalosVenta: diasMalosVenta ?? this.diasMalosVenta,
      totalVentasDiarias: totalVentasDiarias ?? this.totalVentasDiarias,
      totalVentasMensuales: totalVentasMensuales ?? this.totalVentasMensuales,
      totalAbono: totalAbono ?? this.totalAbono,
      totalVentasMensualSegunNumClientes: totalVentasMensualSegunNumClientes ??
          this.totalVentasMensualSegunNumClientes,
      totalVentasSegunNivelProduccion: totalVentasSegunNivelProduccion ??
          this.totalVentasSegunNivelProduccion,
      porcentajeProdAltaRotacion:
          porcentajeProdAltaRotacion ?? this.porcentajeProdAltaRotacion,
      valorAltaRotacion: valorAltaRotacion ?? this.valorAltaRotacion,
      porcentajeProdBajaRotacion:
          porcentajeProdBajaRotacion ?? this.porcentajeProdBajaRotacion,
      valorBajaRotacion: valorBajaRotacion ?? this.valorBajaRotacion,
      caja: caja ?? this.caja,
      reservas: reservas ?? this.reservas,
      cuentasAhorro: cuentasAhorro ?? this.cuentasAhorro,
      totalDisponibleActivo:
          totalDisponibleActivo ?? this.totalDisponibleActivo,
      incobrables: incobrables ?? this.incobrables,
      totalClientes: totalClientes ?? this.totalClientes,
      adelantoProveedores: adelantoProveedores ?? this.adelantoProveedores,
      totalCuentasXCobrar: totalCuentasXCobrar ?? this.totalCuentasXCobrar,
      totalInventario: totalInventario ?? this.totalInventario,
      totalActivosCorrientes:
          totalActivosCorrientes ?? this.totalActivosCorrientes,
      totalActivosFijos: totalActivosFijos ?? this.totalActivosFijos,
      totalActivos: totalActivos ?? this.totalActivos,
      totalProveedoresAdelantos:
          totalProveedoresAdelantos ?? this.totalProveedoresAdelantos,
      totalCreditosInstAmigos:
          totalCreditosInstAmigos ?? this.totalCreditosInstAmigos,
      totalPasivos: totalPasivos ?? this.totalPasivos,
      patrimonio: patrimonio ?? this.patrimonio,
      pasivosMasPatrimonio: pasivosMasPatrimonio ?? this.pasivosMasPatrimonio,
      ventasContado: ventasContado ?? this.ventasContado,
      recuperaciones: recuperaciones ?? this.recuperaciones,
      totalIngresos: totalIngresos ?? this.totalIngresos,
      costoVentaProduccion: costoVentaProduccion ?? this.costoVentaProduccion,
      utilidadBruta: utilidadBruta ?? this.utilidadBruta,
      gastosPersonalAlimentacion:
          gastosPersonalAlimentacion ?? this.gastosPersonalAlimentacion,
      subContratos: subContratos ?? this.subContratos,
      alquilerlocal: alquilerlocal ?? this.alquilerlocal,
      agua: agua ?? this.agua,
      combustible: combustible ?? this.combustible,
      transporte: transporte ?? this.transporte,
      pagoCuotaCredito: pagoCuotaCredito ?? this.pagoCuotaCredito,
      impuesto: impuesto ?? this.impuesto,
      otros: otros ?? this.otros,
      totalCostosOperativos:
          totalCostosOperativos ?? this.totalCostosOperativos,
      resultadoLiquido: resultadoLiquido ?? this.resultadoLiquido,
      consumoFamiliar: consumoFamiliar ?? this.consumoFamiliar,
      ingresosFueraNegocio: ingresosFueraNegocio ?? this.ingresosFueraNegocio,
      saldoDisponibleUf: saldoDisponibleUf ?? this.saldoDisponibleUf,
      costoVentaPorcentaje: costoVentaPorcentaje ?? this.costoVentaPorcentaje,
      fechaVerificacion3: fechaVerificacion3 ?? this.fechaVerificacion3,
      nombreReferencia3: nombreReferencia3 ?? this.nombreReferencia3,
      cedulaReferencia3: cedulaReferencia3 ?? this.cedulaReferencia3,
      direccionReferencia3: direccionReferencia3 ?? this.direccionReferencia3,
      telefonoReferencia3: telefonoReferencia3 ?? this.telefonoReferencia3,
      lugarTrabajoReferencia3:
          lugarTrabajoReferencia3 ?? this.lugarTrabajoReferencia3,
      aniosConocerReferido3:
          aniosConocerReferido3 ?? this.aniosConocerReferido3,
      parentescoReferenciaCodigo3:
          parentescoReferenciaCodigo3 ?? this.parentescoReferenciaCodigo3,
      resultadoVerificacion3:
          resultadoVerificacion3 ?? this.resultadoVerificacion3,
      salud: salud ?? this.salud,
      permisoOperacionNumero:
          permisoOperacionNumero ?? this.permisoOperacionNumero,
      permisoOperacionNombreInstitucion: permisoOperacionNombreInstitucion ??
          this.permisoOperacionNombreInstitucion,
      permisoOperacionFechaEmision:
          permisoOperacionFechaEmision ?? this.permisoOperacionFechaEmision,
      permisoOperacionFechaVencimiento: permisoOperacionFechaVencimiento ??
          this.permisoOperacionFechaVencimiento,
      cicloVentaMensual: cicloVentaMensual ?? this.cicloVentaMensual,
      cicloVentaDiaria: cicloVentaDiaria ?? this.cicloVentaDiaria,
      nivelProduccion: nivelProduccion ?? this.nivelProduccion,
      cuentasPorCobrar: cuentasPorCobrar ?? this.cuentasPorCobrar,
      cicloDeComprasSemanales:
          cicloDeComprasSemanales ?? this.cicloDeComprasSemanales,
      comprasProveedorArticulo:
          comprasProveedorArticulo ?? this.comprasProveedorArticulo,
      costoDePersonal: costoDePersonal ?? this.costoDePersonal,
      ingeresosFamilaresFueraNegocio:
          ingeresosFamilaresFueraNegocio ?? this.ingeresosFamilaresFueraNegocio,
      otrosCreditos: otrosCreditos ?? this.otrosCreditos,
      pasivos: pasivos ?? this.pasivos,
      activos: activos ?? this.activos,
    );
  }
}

final class AnalisisNuevaMayorMilHnInitial
    extends AnalisisNuevaMayorMilHnState {}
