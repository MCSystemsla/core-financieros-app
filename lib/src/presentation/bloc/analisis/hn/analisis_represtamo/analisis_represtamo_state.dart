// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_represtamo_cubit.dart';

class AnalisisReprestamoState extends Equatable {
  final String objEmpleadoVerificaReferenciaID1;
  final String objEmpleadoVerificaReferenciaID2;
  final String objEmpleadoVerificaReferenciaID3;
  final int idLocalResponse;
  final String? uuid;
  final String errorMsg;
  final Status status;
  final String database;
  final int numeroSolicitud;
  final int diasBuenosVenta;
  final int diasNormalesVenta;
  final int diasMalosVenta;
  final int totalVentasDiarias;
  final int totalVentasMensuales;
  final int semanasBuenas;
  final int semanasNormales;
  final int semanasMalas;
  final int totalComprasMensuales;
  final int ventasMensualesCompras;
  final int ventasMensualesProduccion;
  final int caja;
  final int reservas;
  final int cuentasAhorro;
  final int totalDisponibleActivo;
  final int adelantoProveedores;
  final int incobrables;
  final double totalCuentasXCobrar;
  final double totalInventario;
  final int totalActivosFijos;
  final double totalActivos;
  final int proveedores;
  final int adelantoClientes;
  final int proveedoresAdelantosOtros;
  final int creditosInstFinancieras;
  final int prestamosAmigos;
  final int totalInstFinancierasAmigosOtros;
  final int totalPasivos;
  final double patrimonio;
  final double pasivosMasPatrimonio;
  final int ventasContado;
  final int recuperaciones;
  final int totalIngresos;
  final int costoVentaProduccionValor;
  final int costoVentaProduccion;
  final int gastosPersonalAlimentacion;
  final int subContratos;
  final int alquilerlocal;
  final int aguaElectricidad;
  final int combustible;
  final int transporte;
  final int pagoCuotaCredito;
  final int impuesto;
  final int otros;
  final int totalCostosOperativos;
  final int resultadoLiquido;
  final int alimentacion;
  final int educacion;
  final int aguaElectricidadGas;
  final int alquilerFamiliar;
  final int aseoLimpieza;
  final int vestimentaCalzado;
  final int transporteFamiliar;
  final int otrosGastosImprevistos;
  final int pagoCreditosPrivados;
  final int totalConsumoFamiliar;
  final int ingresosFueraNegocio;
  final int saldoDisponibleUf;
  final String destinoExcedentes;
  final String numeroLicencia;
  final String nombreInstitucionLicencia;
  final String fechaEmisionLicencia;
  final String fechaVencimientoLicencia;
  final int ingresoAnual;
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
  final int aniosConocerReferido1;
  final String parentescoReferenciaCodigo1;
  final String resultadoVerificacion1;
  final String fechaVerificacion2;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final int aniosConocerReferido2;
  final String parentescoReferenciaCodigo2;
  final String resultadoVerificacion2;
  final String usuarioCreacion;
  final String maquinaCreacion;
  final String fechaVerificacion3;
  final String nombreReferencia3;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String telefonoReferencia3;
  final String lugarTrabajoReferencia3;
  final int aniosConocerReferido3;
  final String parentescoReferenciaCodigo3;
  final String resultadoVerificacion3;
  final int salud;
  final String permisoOperacionNombreInstitucion;
  final String permisoOperacionFechaEmision;
  final String permisoOperacionFechaVencimiento;
  final String permisoOperacionNumero;
  final CicloVentaHN cicloVentaMensual;
  final CicloVentaDiaria cicloVentaDiaria;
  final List<NivelProduccionHN> nivelProduccion;
  final List<ComprasProveedorArticuloHN> comprasProveedorArticulo;
  final CicloDeComprasSemanalesHN cicloDeComprasSemanales;
  final List<CuentasPorCobrarHN> cuentasPorCobrar;
  final List<ActivoHN> activos;
  final List<InventarioHN> inventario;
  const AnalisisReprestamoState({
    this.objEmpleadoVerificaReferenciaID1 = '',
    this.objEmpleadoVerificaReferenciaID2 = '',
    this.objEmpleadoVerificaReferenciaID3 = '',
    this.idLocalResponse = 0,
    this.uuid,
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.database = '',
    this.numeroSolicitud = 0,
    this.diasBuenosVenta = 0,
    this.diasNormalesVenta = 0,
    this.diasMalosVenta = 0,
    this.totalVentasDiarias = 0,
    this.totalVentasMensuales = 0,
    this.semanasBuenas = 0,
    this.semanasNormales = 0,
    this.semanasMalas = 0,
    this.totalComprasMensuales = 0,
    this.ventasMensualesCompras = 0,
    this.ventasMensualesProduccion = 0,
    this.caja = 0,
    this.reservas = 0,
    this.cuentasAhorro = 0,
    this.totalDisponibleActivo = 0,
    this.adelantoProveedores = 0,
    this.incobrables = 0,
    this.totalCuentasXCobrar = 0,
    this.totalInventario = 0,
    this.totalActivosFijos = 0,
    this.totalActivos = 0,
    this.proveedores = 0,
    this.adelantoClientes = 0,
    this.proveedoresAdelantosOtros = 0,
    this.creditosInstFinancieras = 0,
    this.prestamosAmigos = 0,
    this.totalInstFinancierasAmigosOtros = 0,
    this.totalPasivos = 0,
    this.patrimonio = 0,
    this.pasivosMasPatrimonio = 0,
    this.ventasContado = 0,
    this.recuperaciones = 0,
    this.totalIngresos = 0,
    this.costoVentaProduccionValor = 0,
    this.costoVentaProduccion = 0,
    this.gastosPersonalAlimentacion = 0,
    this.subContratos = 0,
    this.alquilerlocal = 0,
    this.aguaElectricidad = 0,
    this.combustible = 0,
    this.transporte = 0,
    this.pagoCuotaCredito = 0,
    this.impuesto = 0,
    this.otros = 0,
    this.totalCostosOperativos = 0,
    this.resultadoLiquido = 0,
    this.alimentacion = 0,
    this.educacion = 0,
    this.aguaElectricidadGas = 0,
    this.alquilerFamiliar = 0,
    this.aseoLimpieza = 0,
    this.vestimentaCalzado = 0,
    this.transporteFamiliar = 0,
    this.otrosGastosImprevistos = 0,
    this.pagoCreditosPrivados = 0,
    this.totalConsumoFamiliar = 0,
    this.ingresosFueraNegocio = 0,
    this.saldoDisponibleUf = 0,
    this.destinoExcedentes = '',
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
    this.usuarioCreacion = '',
    this.maquinaCreacion = '',
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
    this.permisoOperacionNombreInstitucion = '',
    this.permisoOperacionFechaEmision = '',
    this.permisoOperacionFechaVencimiento = '',
    this.permisoOperacionNumero = '',
    this.cicloVentaMensual = const CicloVentaHN(
      ciclo: [],
      totalVentasDiaria: 0,
    ),
    this.cicloVentaDiaria = const CicloVentaDiaria(
      cicloVentas: [],
      totalVentasDiaria: 0,
    ),
    this.nivelProduccion = const [],
    this.comprasProveedorArticulo = const [],
    this.cicloDeComprasSemanales = const CicloDeComprasSemanalesHN(
      cicloCompra: [],
      totalComprasMensualSemanal: 0,
    ),
    this.cuentasPorCobrar = const [],
    this.activos = const [],
    this.inventario = const [],
  });

  @override
  List<Object> get props => [
        objEmpleadoVerificaReferenciaID1,
        objEmpleadoVerificaReferenciaID2,
        objEmpleadoVerificaReferenciaID3,
        idLocalResponse,
        errorMsg,
        status,
        cicloVentaMensual,
        cicloVentaDiaria,
        nivelProduccion,
        comprasProveedorArticulo,
        cicloDeComprasSemanales,
        cuentasPorCobrar,
        activos,
        inventario,
        database,
        numeroSolicitud,
        diasBuenosVenta,
        diasNormalesVenta,
        diasMalosVenta,
        totalVentasDiarias,
        totalVentasMensuales,
        semanasBuenas,
        semanasNormales,
        semanasMalas,
        totalComprasMensuales,
        ventasMensualesCompras,
        ventasMensualesProduccion,
        caja,
        reservas,
        cuentasAhorro,
        totalDisponibleActivo,
        adelantoProveedores,
        incobrables,
        totalCuentasXCobrar,
        totalInventario,
        totalActivosFijos,
        totalActivos,
        proveedores,
        adelantoClientes,
        proveedoresAdelantosOtros,
        creditosInstFinancieras,
        prestamosAmigos,
        totalInstFinancierasAmigosOtros,
        totalPasivos,
        patrimonio,
        pasivosMasPatrimonio,
        ventasContado,
        recuperaciones,
        totalIngresos,
        costoVentaProduccionValor,
        costoVentaProduccion,
        gastosPersonalAlimentacion,
        subContratos,
        alquilerlocal,
        aguaElectricidad,
        combustible,
        transporte,
        pagoCuotaCredito,
        impuesto,
        otros,
        totalCostosOperativos,
        resultadoLiquido,
        alimentacion,
        educacion,
        aguaElectricidadGas,
        alquilerFamiliar,
        aseoLimpieza,
        vestimentaCalzado,
        transporteFamiliar,
        otrosGastosImprevistos,
        pagoCreditosPrivados,
        totalConsumoFamiliar,
        ingresosFueraNegocio,
        saldoDisponibleUf,
        destinoExcedentes,
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
        usuarioCreacion,
        maquinaCreacion,
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
        permisoOperacionNombreInstitucion,
        permisoOperacionFechaEmision,
        permisoOperacionFechaVencimiento,
        permisoOperacionNumero,
        cicloVentaMensual,
      ];

  AnalisisReprestamoState copyWith({
    String? objEmpleadoVerificaReferenciaID1,
    String? objEmpleadoVerificaReferenciaID2,
    String? objEmpleadoVerificaReferenciaID3,
    int? idLocalResponse,
    String? uuid,
    String? errorMsg,
    Status? status,
    String? database,
    int? numeroSolicitud,
    int? diasBuenosVenta,
    int? diasNormalesVenta,
    int? diasMalosVenta,
    int? totalVentasDiarias,
    int? totalVentasMensuales,
    int? semanasBuenas,
    int? semanasNormales,
    int? semanasMalas,
    int? totalComprasMensuales,
    int? ventasMensualesCompras,
    int? ventasMensualesProduccion,
    int? caja,
    int? reservas,
    int? cuentasAhorro,
    int? totalDisponibleActivo,
    int? adelantoProveedores,
    int? incobrables,
    double? totalCuentasXCobrar,
    double? totalInventario,
    int? totalActivosFijos,
    double? totalActivos,
    int? proveedores,
    int? adelantoClientes,
    int? proveedoresAdelantosOtros,
    int? creditosInstFinancieras,
    int? prestamosAmigos,
    int? totalInstFinancierasAmigosOtros,
    int? totalPasivos,
    double? patrimonio,
    double? pasivosMasPatrimonio,
    int? ventasContado,
    int? recuperaciones,
    int? totalIngresos,
    int? costoVentaProduccionValor,
    int? costoVentaProduccion,
    int? gastosPersonalAlimentacion,
    int? subContratos,
    int? alquilerlocal,
    int? aguaElectricidad,
    int? combustible,
    int? transporte,
    int? pagoCuotaCredito,
    int? impuesto,
    int? otros,
    int? totalCostosOperativos,
    int? resultadoLiquido,
    int? alimentacion,
    int? educacion,
    int? aguaElectricidadGas,
    int? alquilerFamiliar,
    int? aseoLimpieza,
    int? vestimentaCalzado,
    int? transporteFamiliar,
    int? otrosGastosImprevistos,
    int? pagoCreditosPrivados,
    int? totalConsumoFamiliar,
    int? ingresosFueraNegocio,
    int? saldoDisponibleUf,
    String? destinoExcedentes,
    String? numeroLicencia,
    String? nombreInstitucionLicencia,
    String? fechaEmisionLicencia,
    String? fechaVencimientoLicencia,
    int? ingresoAnual,
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
    int? aniosConocerReferido1,
    String? parentescoReferenciaCodigo1,
    String? resultadoVerificacion1,
    String? fechaVerificacion2,
    String? nombreReferencia2,
    String? cedulaReferencia2,
    String? direccionReferencia2,
    String? telefonoReferencia2,
    String? lugarTrabajoReferencia2,
    int? aniosConocerReferido2,
    String? parentescoReferenciaCodigo2,
    String? resultadoVerificacion2,
    String? usuarioCreacion,
    String? maquinaCreacion,
    String? fechaVerificacion3,
    String? nombreReferencia3,
    String? cedulaReferencia3,
    String? direccionReferencia3,
    String? telefonoReferencia3,
    String? lugarTrabajoReferencia3,
    int? aniosConocerReferido3,
    String? parentescoReferenciaCodigo3,
    String? resultadoVerificacion3,
    int? salud,
    String? permisoOperacionNombreInstitucion,
    String? permisoOperacionFechaEmision,
    String? permisoOperacionFechaVencimiento,
    String? permisoOperacionNumero,
    CicloVentaHN? cicloVentaMensual,
    CicloVentaDiaria? cicloVentaDiaria,
    List<NivelProduccionHN>? nivelProduccion,
    List<ComprasProveedorArticuloHN>? comprasProveedorArticulo,
    CicloDeComprasSemanalesHN? cicloDeComprasSemanales,
    List<CuentasPorCobrarHN>? cuentasPorCobrar,
    List<ActivoHN>? activos,
    List<InventarioHN>? inventario,
  }) {
    return AnalisisReprestamoState(
      objEmpleadoVerificaReferenciaID1: objEmpleadoVerificaReferenciaID1 ??
          this.objEmpleadoVerificaReferenciaID1,
      objEmpleadoVerificaReferenciaID2: objEmpleadoVerificaReferenciaID2 ??
          this.objEmpleadoVerificaReferenciaID2,
      objEmpleadoVerificaReferenciaID3: objEmpleadoVerificaReferenciaID3 ??
          this.objEmpleadoVerificaReferenciaID3,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      uuid: uuid ?? this.uuid,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      database: database ?? this.database,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      diasBuenosVenta: diasBuenosVenta ?? this.diasBuenosVenta,
      diasNormalesVenta: diasNormalesVenta ?? this.diasNormalesVenta,
      diasMalosVenta: diasMalosVenta ?? this.diasMalosVenta,
      totalVentasDiarias: totalVentasDiarias ?? this.totalVentasDiarias,
      totalVentasMensuales: totalVentasMensuales ?? this.totalVentasMensuales,
      semanasBuenas: semanasBuenas ?? this.semanasBuenas,
      semanasNormales: semanasNormales ?? this.semanasNormales,
      semanasMalas: semanasMalas ?? this.semanasMalas,
      totalComprasMensuales:
          totalComprasMensuales ?? this.totalComprasMensuales,
      ventasMensualesCompras:
          ventasMensualesCompras ?? this.ventasMensualesCompras,
      ventasMensualesProduccion:
          ventasMensualesProduccion ?? this.ventasMensualesProduccion,
      caja: caja ?? this.caja,
      reservas: reservas ?? this.reservas,
      cuentasAhorro: cuentasAhorro ?? this.cuentasAhorro,
      totalDisponibleActivo:
          totalDisponibleActivo ?? this.totalDisponibleActivo,
      adelantoProveedores: adelantoProveedores ?? this.adelantoProveedores,
      incobrables: incobrables ?? this.incobrables,
      totalCuentasXCobrar: totalCuentasXCobrar ?? this.totalCuentasXCobrar,
      totalInventario: totalInventario ?? this.totalInventario,
      totalActivosFijos: totalActivosFijos ?? this.totalActivosFijos,
      totalActivos: totalActivos ?? this.totalActivos,
      proveedores: proveedores ?? this.proveedores,
      adelantoClientes: adelantoClientes ?? this.adelantoClientes,
      proveedoresAdelantosOtros:
          proveedoresAdelantosOtros ?? this.proveedoresAdelantosOtros,
      creditosInstFinancieras:
          creditosInstFinancieras ?? this.creditosInstFinancieras,
      prestamosAmigos: prestamosAmigos ?? this.prestamosAmigos,
      totalInstFinancierasAmigosOtros: totalInstFinancierasAmigosOtros ??
          this.totalInstFinancierasAmigosOtros,
      totalPasivos: totalPasivos ?? this.totalPasivos,
      patrimonio: patrimonio ?? this.patrimonio,
      pasivosMasPatrimonio: pasivosMasPatrimonio ?? this.pasivosMasPatrimonio,
      ventasContado: ventasContado ?? this.ventasContado,
      recuperaciones: recuperaciones ?? this.recuperaciones,
      totalIngresos: totalIngresos ?? this.totalIngresos,
      costoVentaProduccionValor:
          costoVentaProduccionValor ?? this.costoVentaProduccionValor,
      costoVentaProduccion: costoVentaProduccion ?? this.costoVentaProduccion,
      gastosPersonalAlimentacion:
          gastosPersonalAlimentacion ?? this.gastosPersonalAlimentacion,
      subContratos: subContratos ?? this.subContratos,
      alquilerlocal: alquilerlocal ?? this.alquilerlocal,
      aguaElectricidad: aguaElectricidad ?? this.aguaElectricidad,
      combustible: combustible ?? this.combustible,
      transporte: transporte ?? this.transporte,
      pagoCuotaCredito: pagoCuotaCredito ?? this.pagoCuotaCredito,
      impuesto: impuesto ?? this.impuesto,
      otros: otros ?? this.otros,
      totalCostosOperativos:
          totalCostosOperativos ?? this.totalCostosOperativos,
      resultadoLiquido: resultadoLiquido ?? this.resultadoLiquido,
      alimentacion: alimentacion ?? this.alimentacion,
      educacion: educacion ?? this.educacion,
      aguaElectricidadGas: aguaElectricidadGas ?? this.aguaElectricidadGas,
      alquilerFamiliar: alquilerFamiliar ?? this.alquilerFamiliar,
      aseoLimpieza: aseoLimpieza ?? this.aseoLimpieza,
      vestimentaCalzado: vestimentaCalzado ?? this.vestimentaCalzado,
      transporteFamiliar: transporteFamiliar ?? this.transporteFamiliar,
      otrosGastosImprevistos:
          otrosGastosImprevistos ?? this.otrosGastosImprevistos,
      pagoCreditosPrivados: pagoCreditosPrivados ?? this.pagoCreditosPrivados,
      totalConsumoFamiliar: totalConsumoFamiliar ?? this.totalConsumoFamiliar,
      ingresosFueraNegocio: ingresosFueraNegocio ?? this.ingresosFueraNegocio,
      saldoDisponibleUf: saldoDisponibleUf ?? this.saldoDisponibleUf,
      destinoExcedentes: destinoExcedentes ?? this.destinoExcedentes,
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
      usuarioCreacion: usuarioCreacion ?? this.usuarioCreacion,
      maquinaCreacion: maquinaCreacion ?? this.maquinaCreacion,
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
      permisoOperacionNombreInstitucion: permisoOperacionNombreInstitucion ??
          this.permisoOperacionNombreInstitucion,
      permisoOperacionFechaEmision:
          permisoOperacionFechaEmision ?? this.permisoOperacionFechaEmision,
      permisoOperacionFechaVencimiento: permisoOperacionFechaVencimiento ??
          this.permisoOperacionFechaVencimiento,
      permisoOperacionNumero:
          permisoOperacionNumero ?? this.permisoOperacionNumero,
      cicloVentaMensual: cicloVentaMensual ?? this.cicloVentaMensual,
      cicloVentaDiaria: cicloVentaDiaria ?? this.cicloVentaDiaria,
      nivelProduccion: nivelProduccion ?? this.nivelProduccion,
      comprasProveedorArticulo:
          comprasProveedorArticulo ?? this.comprasProveedorArticulo,
      cicloDeComprasSemanales:
          cicloDeComprasSemanales ?? this.cicloDeComprasSemanales,
      cuentasPorCobrar: cuentasPorCobrar ?? this.cuentasPorCobrar,
      activos: activos ?? this.activos,
      inventario: inventario ?? this.inventario,
    );
  }
}

final class AnalisisReprestamoInitial extends AnalisisReprestamoState {}
