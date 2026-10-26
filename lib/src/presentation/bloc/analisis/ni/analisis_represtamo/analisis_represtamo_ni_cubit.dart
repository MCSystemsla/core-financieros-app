import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/analisis/analisis_represtamo_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/represtamo/analisis_represtamo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_activo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_ciclo_compras_semanales_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_ciclo_venta_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_compras_proveedor_articulo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_cuentas_por_cobrar_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_inventario_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_nivel_produccion_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_represtamo_ni_state.dart';

class AnalisisReprestamoNiCubit extends Cubit<AnalisisReprestamoNiState> {
  final AnalisisFormsRepositoryNi _repository;
  late final AnalisisReprestamoHnAutosave autoSaveHelper;

  AnalisisReprestamoNiCubit(this._repository)
      : super(AnalisisReprestamoInitial());

  Future<void> createAnalisisReprestamo() async {
    final incobrablesxCobrar = global<ObjectBoxService>()
        .getParametroByName(nombre: 'INCOBRABLESDECXCOBRAR');
    final cicloVentaDiario = getCicloVentasDiarios();
    final totalComprasSemanas = getcomprasSemanasMensuales();
    final totalVentasMensuales = (state.cicloVentaMensual.ciclo.fold(
          0,
          (sum, e) => sum + e.venta,
        ) /
        12);
    final totalVentasDiarias = (state.cicloVentaDiaria.cicloVentas.fold(
          0,
          (sum, e) => sum + e.venta,
        ) *
        4);

    final totalNivelProduccionCalc = state.nivelProduccion
        .fold(0, (sum, e) => sum + e.totalMensualProduccion);

    final comprasMensuales = state.cicloDeComprasSemanales.cicloCompra
        .fold(0, (sum, e) => sum + e.cantidadCompra);

    final totalInventario =
        state.inventario.fold(0, (sum, element) => sum + element.total);

    final costoPorcentajeVenta = state.inventario.isEmpty
        ? 0.0
        : state.inventario.fold(
                0.0, (sum, element) => sum + (element.costoVentaPorcentaje)) /
            (state.inventario.length);

    final totalActivosFijos = state.activos.fold(0, (sum, e) => sum + e.monto);

    final totalCuentasxCobrar = state.cuentasPorCobrar
        .fold(0, (sum, element) => sum + element.totalMensualCredito);

    final totalClientes = state.cuentasPorCobrar
        .fold(0, (sum, element) => sum + element.totalMensualCredito);

    final incobrables =
        (totalCuentasxCobrar.toDouble() + state.adelantoProveedores) *
            (double.tryParse(incobrablesxCobrar?.valor ?? '0') ?? 0);

    final totalActivos = (totalActivosFijos +
        (totalClientes -
            incobrables +
            state.adelantoProveedores +
            state.caja +
            state.reservas +
            state.cuentasAhorro +
            totalInventario));

    final totalActivosCalc = state.caja + state.reservas + state.cuentasAhorro;

    final totalMontosCuentasxCobrarSum = state.cuentasPorCobrar
        .fold(0, (sum, element) => sum + element.montoCredito);

    final totalCuentasxCobrarCalc =
        (totalMontosCuentasxCobrarSum + state.adelantoProveedores) -
            incobrables;

    final totalProveedoresAdelantoCalc =
        state.proveedores + state.adelantoClientes;

    final totalInstAmigosCalc =
        state.creditosInstFinancieras + state.prestamosAmigos;

    final totalPasivosCalc = totalProveedoresAdelantoCalc + totalInstAmigosCalc;

    final patimonioCalc = totalActivos - totalPasivosCalc;

    final pasivosPatraimonioCalc = totalPasivosCalc + patimonioCalc;

    final nivelProduccion = state.nivelProduccion.fold(
      0,
      (sum, e) => sum + e.totalMensualProduccion,
    );

    final ventasDeContado =
        (totalVentasMensuales + totalVentasDiarias + nivelProduccion) / 3;

    final totalIngresos = ventasDeContado + state.recuperaciones;

    final porcentajeDeVenta = costoPorcentajeVenta.toStringAsFixed(2);

    final totalCostosOperativosCal = (state.gastosPersonalAlimentacion +
        state.subContratos +
        state.alquilerlocal +
        state.aguaElectricidad +
        state.combustible +
        state.transporte +
        state.pagoCuotaCredito +
        state.impuesto +
        state.otros);

    final porcentajeDeVentaTotalCal =
        (totalIngresos * double.parse(porcentajeDeVenta));

    final totalConsumoFamiliarCalc = state.alimentacion +
        state.educacion +
        state.aguaElectricidadGas +
        state.alquilerFamiliar +
        state.aseoLimpieza +
        state.vestimentaCalzado +
        state.transporteFamiliar +
        state.otrosGastosImprevistos +
        state.pagoCreditosPrivados;

    final totalIngresosAnual =
        state.cicloVentaMensual.ciclo.fold(0, (sum, e) => sum + e.venta);

    final utilidadBruta = totalIngresos - porcentajeDeVentaTotalCal;

    final totalResultadoLiquido = utilidadBruta - totalCostosOperativosCal;

    final totalSaldoDisponibleUnidadFamiliarCal =
        (totalResultadoLiquido - totalConsumoFamiliarCalc) +
            state.ingresosFueraNegocio;

    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createAnalisisReprestamo(
        analisisSolicitudReprestamo: AnalisisReprestamoHn(
          recuperaciones: state.recuperaciones,
          objEmpleadoVerificaReferenciaID1:
              state.objEmpleadoVerificaReferenciaID1,
          objEmpleadoVerificaReferenciaID2:
              state.objEmpleadoVerificaReferenciaID2,
          objEmpleadoVerificaReferenciaID3:
              state.objEmpleadoVerificaReferenciaID3,
          database: state.database,
          numeroSolicitud: state.numeroSolicitud,
          diasBuenosVenta: cicloVentaDiario['diasBuenos'],
          diasNormalesVenta: cicloVentaDiario['diasNormales'],
          diasMalosVenta: cicloVentaDiario['diasMalos'],
          totalVentasDiarias: totalVentasDiarias,
          totalVentasMensuales: totalVentasMensuales.toInt(),
          semanasBuenas: totalComprasSemanas['semanasBuenas'],
          semanasNormales: totalComprasSemanas['semanasNormales'],
          semanasMalas: totalComprasSemanas['semanasMalas'],
          totalComprasMensuales: comprasMensuales,
          ventasMensualesCompras: state.cicloDeComprasSemanales.cicloCompra
              .fold(0, (sum, e) => sum + e.cantidadCompra),
          ventasMensualesProduccion: state.nivelProduccion
              .fold(0, (sum, e) => sum + e.totalMensualProduccion),
          caja: state.caja,
          reservas: state.reservas,
          cuentasAhorro: state.cuentasAhorro,
          totalDisponibleActivo: totalActivosCalc,
          adelantoProveedores: state.adelantoProveedores,
          incobrables: incobrables.toInt(),
          totalCuentasXCobrar: totalCuentasxCobrarCalc,
          totalInventario: totalInventario.toDouble(),
          totalActivosFijos: totalActivosFijos,
          totalActivos: totalActivos,
          proveedores: state.proveedores,
          adelantoClientes: state.adelantoClientes,
          proveedoresAdelantosOtros: totalProveedoresAdelantoCalc,
          creditosInstFinancieras: state.creditosInstFinancieras,
          prestamosAmigos: state.prestamosAmigos,
          totalInstFinancierasAmigosOtros: totalInstAmigosCalc,
          totalPasivos: totalPasivosCalc,
          patrimonio: patimonioCalc,
          pasivosMasPatrimonio: pasivosPatraimonioCalc,
          ventasContado: ventasDeContado.toInt(),
          totalIngresos: totalIngresos.toInt(),
          costoVentaProduccionValor: costoPorcentajeVenta,
          costoVentaProduccion: totalNivelProduccionCalc,
          gastosPersonalAlimentacion: state.gastosPersonalAlimentacion,
          subContratos: state.subContratos,
          alquilerlocal: state.alquilerlocal,
          aguaElectricidad: state.aguaElectricidad,
          combustible: state.combustible,
          transporte: state.transporte,
          pagoCuotaCredito: state.pagoCuotaCredito,
          impuesto: state.impuesto,
          otros: state.otros,
          totalCostosOperativos: totalCostosOperativosCal,
          resultadoLiquido: totalResultadoLiquido.toInt(),
          alimentacion: state.alimentacion,
          educacion: state.educacion,
          aguaElectricidadGas: state.aguaElectricidadGas,
          alquilerFamiliar: state.alquilerFamiliar,
          aseoLimpieza: state.aseoLimpieza,
          vestimentaCalzado: state.vestimentaCalzado,
          transporteFamiliar: state.transporteFamiliar,
          otrosGastosImprevistos: state.otrosGastosImprevistos,
          pagoCreditosPrivados: state.pagoCreditosPrivados,
          totalConsumoFamiliar: totalConsumoFamiliarCalc,
          ingresosFueraNegocio: state.ingresosFueraNegocio,
          saldoDisponibleUf: totalSaldoDisponibleUnidadFamiliarCal.toInt(),
          destinoExcedentes: state.destinoExcedentes,
          numeroLicencia: state.numeroLicencia,
          nombreInstitucionLicencia: state.nombreInstitucionLicencia,
          fechaEmisionLicencia: DateTime.parse(state.fechaEmisionLicencia),
          fechaVencimientoLicencia:
              DateTime.parse(state.fechaVencimientoLicencia),
          ingresoAnual: totalIngresosAnual,
          cliente1: state.cliente1,
          cliente2: state.cliente2,
          cliente3: state.cliente3,
          proveedor1: state.proveedor1,
          proveedor2: state.proveedor2,
          proveedor3: state.proveedor3,
          fechaVerificacion1: state.fechaVerificacion1.isEmpty
              ? DateTime.now()
              : DateTime.parse(state.fechaVerificacion1),
          nombreReferencia1: state.nombreReferencia1,
          cedulaReferencia1: state.cedulaReferencia1,
          direccionReferencia1: state.direccionReferencia1,
          telefonoReferencia1: state.telefonoReferencia1,
          lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
          aniosConocerReferido1: state.aniosConocerReferido1,
          parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
          resultadoVerificacion1: state.resultadoVerificacion1,
          fechaVerificacion2: state.fechaVerificacion2.isEmpty
              ? DateTime.now()
              : DateTime.parse(state.fechaVerificacion2),
          nombreReferencia2: state.nombreReferencia2,
          cedulaReferencia2: state.cedulaReferencia2,
          direccionReferencia2: state.direccionReferencia2,
          telefonoReferencia2: state.telefonoReferencia2,
          lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
          aniosConocerReferido2: state.aniosConocerReferido2,
          parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
          resultadoVerificacion2: state.resultadoVerificacion2,
          usuarioCreacion: state.usuarioCreacion,
          maquinaCreacion: state.maquinaCreacion,
          fechaVerificacion3: DateTime.tryParse(state.fechaVerificacion3),
          nombreReferencia3: state.nombreReferencia3,
          cedulaReferencia3: state.cedulaReferencia3,
          direccionReferencia3: state.direccionReferencia3,
          telefonoReferencia3: state.telefonoReferencia3,
          lugarTrabajoReferencia3: state.lugarTrabajoReferencia3,
          aniosConocerReferido3: state.aniosConocerReferido3,
          parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
          resultadoVerificacion3: state.resultadoVerificacion3,
          salud: state.salud,
          permisoOperacionNombreInstitucion:
              state.permisoOperacionNombreInstitucion,
          permisoOperacionFechaEmision:
              DateTime.parse(state.permisoOperacionFechaEmision),
          permisoOperacionFechaVencimiento:
              DateTime.parse(state.permisoOperacionFechaVencimiento),
          permisoOperacionNumero: state.permisoOperacionNumero,
          cicloVentaMensual: CicloVentaHN(
            totalVentasDiaria: state.cicloVentaMensual.ciclo
                .fold(0, (sum, e) => sum + e.venta),
            ciclo: state.cicloVentaMensual.ciclo,
          ),
          cicloVentaDiaria: CicloVentaDiaria(
            totalVentasDiaria: state.cicloVentaDiaria.cicloVentas
                .fold(0, (sum, e) => sum + e.venta),
            cicloVentas: state.cicloVentaDiaria.cicloVentas,
          ),
          nivelProduccion: state.nivelProduccion,
          comprasProveedorArticulo: state.comprasProveedorArticulo,
          cicloDeComprasSemanales: CicloDeComprasSemanalesHN(
            totalComprasMensualSemanal: state
                .cicloDeComprasSemanales.cicloCompra
                .fold(0, (sum, e) => sum + e.cantidadCompra),
            cicloCompra: state.cicloDeComprasSemanales.cicloCompra,
          ),
          cuentasPorCobrar: state.cuentasPorCobrar,
          activos: state.activos,
          inventario: state.inventario,
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }

  void initAutoSave({String? uuid, required int numeroSolicitud}) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid, numeroSolicitud: numeroSolicitud));

    autoSaveHelper = AnalisisReprestamoHnAutosave(
      box: localDbProvider.analisisReprestamoHnLocalDb,
      buildModel: _buildModel,
      uuid: newUuid,
      numeroSolicitud: numeroSolicitud,
      onSaved: (m) {
        emit(state.copyWith(
          idLocalResponse: m.id,
          uuid: m.uuid,
          numeroSolicitud: m.numeroSolicitud,
        ));
      },
    );
  }

  void loadFromLocalDb(AnalisisReprestamoHnLocalDb? solicitud) {
    onFieldChanged(
      () => state.copyWith(
        objEmpleadoVerificaReferenciaID1:
            solicitud?.objEmpleadoVerificaReferenciaID1,
        objEmpleadoVerificaReferenciaID2:
            solicitud?.objEmpleadoVerificaReferenciaID2,
        objEmpleadoVerificaReferenciaID3:
            solicitud?.objEmpleadoVerificaReferenciaID3,
        adelantoClientes: solicitud?.adelantoClientes,
        adelantoProveedores: solicitud?.adelantoProveedores,
        aguaElectricidad: solicitud?.aguaElectricidad,
        aguaElectricidadGas: solicitud?.aguaElectricidadGas,
        alimentacion: solicitud?.alimentacion,
        alquilerlocal: solicitud?.alquilerlocal,
        alquilerFamiliar: solicitud?.alquilerFamiliar,
        aseoLimpieza: solicitud?.aseoLimpieza,
        caja: solicitud?.caja,
        cliente1: solicitud?.cliente1,
        cliente2: solicitud?.cliente2,
        cliente3: solicitud?.cliente3,
        combustible: solicitud?.combustible,
        cuentasAhorro: solicitud?.cuentasAhorro,
        costoVentaProduccion: solicitud?.costoVentaProduccion,
        costoVentaProduccionValor: solicitud?.costoVentaProduccionValor,
        creditosInstFinancieras: solicitud?.creditosInstFinancieras,
        diasBuenosVenta: solicitud?.diasBuenosVenta,
        diasMalosVenta: solicitud?.diasMalosVenta,
        diasNormalesVenta: solicitud?.diasNormalesVenta,
        gastosPersonalAlimentacion: solicitud?.gastosPersonalAlimentacion,
        impuesto: solicitud?.impuesto,
        ingresoAnual: solicitud?.ingresoAnual,
        incobrables: solicitud?.incobrables,
        educacion: solicitud?.educacion,
        ingresosFueraNegocio: solicitud?.ingresosFueraNegocio,
        prestamosAmigos: solicitud?.prestamosAmigos,
        otros: solicitud?.otros,
        salud: solicitud?.salud,
        otrosGastosImprevistos: solicitud?.otrosGastosImprevistos,
        pagoCreditosPrivados: solicitud?.pagoCreditosPrivados,
        totalConsumoFamiliar: solicitud?.totalConsumoFamiliar,
        pagoCuotaCredito: solicitud?.pagoCuotaCredito,
        proveedores: solicitud?.proveedores,
        totalCuentasXCobrar: solicitud?.totalCuentasXCobrar,
        totalInventario: solicitud?.totalInventario,
        proveedoresAdelantosOtros: solicitud?.proveedoresAdelantosOtros,
        resultadoLiquido: solicitud?.resultadoLiquido,
        saldoDisponibleUf: solicitud?.saldoDisponibleUf,
        pasivosMasPatrimonio: solicitud?.pasivosMasPatrimonio,
        patrimonio: solicitud?.patrimonio,
        recuperaciones: solicitud?.recuperaciones,
        reservas: solicitud?.reservas,
        semanasBuenas: solicitud?.semanasBuenas,
        semanasMalas: solicitud?.semanasMalas,
        semanasNormales: solicitud?.semanasNormales,
        totalActivos: solicitud?.totalActivos,
        totalActivosFijos: solicitud?.totalActivosFijos,
        totalComprasMensuales: solicitud?.totalComprasMensuales,
        subContratos: solicitud?.subContratos,
        transporte: solicitud?.transporte,
        transporteFamiliar: solicitud?.transporteFamiliar,
        ventasContado: solicitud?.ventasContado,
        totalCostosOperativos: solicitud?.totalCostosOperativos,
        totalDisponibleActivo: solicitud?.totalDisponibleActivo,
        totalIngresos: solicitud?.totalIngresos,
        totalInstFinancierasAmigosOtros:
            solicitud?.totalInstFinancierasAmigosOtros,
        totalPasivos: solicitud?.totalPasivos,
        totalVentasDiarias: solicitud?.totalVentasDiarias,
        totalVentasMensuales: solicitud?.totalVentasMensuales,
        ventasMensualesCompras: solicitud?.ventasMensualesCompras,
        ventasMensualesProduccion: solicitud?.ventasMensualesProduccion,
        vestimentaCalzado: solicitud?.vestimentaCalzado,
        database: solicitud?.database,
        destinoExcedentes: solicitud?.destinoExcedentes,
        maquinaCreacion: solicitud?.maquinaCreacion,
        nombreReferencia1: solicitud?.nombreReferencia1,
        numeroLicencia: solicitud?.numeroLicencia,
        permisoOperacionFechaEmision:
            solicitud?.permisoOperacionFechaEmision?.toUtc().toIso8601String(),
        permisoOperacionFechaVencimiento: solicitud
            ?.permisoOperacionFechaVencimiento
            ?.toUtc()
            .toIso8601String(),
        permisoOperacionNumero: solicitud?.permisoOperacionNumero,
        permisoOperacionNombreInstitucion:
            solicitud?.permisoOperacionNombreInstitucion,
        nombreInstitucionLicencia: solicitud?.nombreInstitucionLicencia,
        nombreReferencia2: solicitud?.nombreReferencia2,
        nombreReferencia3: solicitud?.nombreReferencia3,
        proveedor1: solicitud?.proveedor1,
        proveedor2: solicitud?.proveedor2,
        proveedor3: solicitud?.proveedor3,
        usuarioCreacion: solicitud?.usuarioCreacion,
        fechaEmisionLicencia:
            solicitud?.fechaEmisionLicencia?.toUtc().toIso8601String(),
        fechaVencimientoLicencia:
            solicitud?.fechaVencimientoLicencia?.toUtc().toIso8601String(),
        fechaVerificacion1:
            solicitud?.fechaVerificacion1?.toUtc().toIso8601String(),
        fechaVerificacion2:
            solicitud?.fechaVerificacion2?.toUtc().toIso8601String(),
        fechaVerificacion3:
            solicitud?.fechaVerificacion3?.toUtc().toIso8601String(),
        numeroSolicitud: solicitud?.numeroSolicitud,
        aniosConocerReferido1: solicitud?.aniosConocerReferido1,
        aniosConocerReferido2: solicitud?.aniosConocerReferido2,
        aniosConocerReferido3: solicitud?.aniosConocerReferido3,
        parentescoReferenciaCodigo1: solicitud?.parentescoReferenciaCodigo1,
        parentescoReferenciaCodigo2: solicitud?.parentescoReferenciaCodigo2,
        parentescoReferenciaCodigo3: solicitud?.parentescoReferenciaCodigo3,
        resultadoVerificacion1: solicitud?.resultadoVerificacion1,
        resultadoVerificacion2: solicitud?.resultadoVerificacion2,
        resultadoVerificacion3: solicitud?.resultadoVerificacion3,
        cedulaReferencia1: solicitud?.cedulaReferencia1,
        cedulaReferencia2: solicitud?.cedulaReferencia2,
        cedulaReferencia3: solicitud?.cedulaReferencia3,
        direccionReferencia1: solicitud?.direccionReferencia1,
        direccionReferencia2: solicitud?.direccionReferencia2,
        direccionReferencia3: solicitud?.direccionReferencia3,
        telefonoReferencia1: solicitud?.telefonoReferencia1,
        telefonoReferencia2: solicitud?.telefonoReferencia2,
        telefonoReferencia3: solicitud?.telefonoReferencia3,
        lugarTrabajoReferencia1: solicitud?.lugarTrabajoReferencia1,
        lugarTrabajoReferencia2: solicitud?.lugarTrabajoReferencia2,
        lugarTrabajoReferencia3: solicitud?.lugarTrabajoReferencia3,
      ),
    );
  }

  AnalisisReprestamoHnLocalDb _buildModel(
    AnalisisReprestamoHnLocalDb? existing,
  ) {
    final prev = existing;

    return AnalisisReprestamoHnLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      objEmpleadoVerificaReferenciaID1: state.objEmpleadoVerificaReferenciaID1,
      objEmpleadoVerificaReferenciaID2: state.objEmpleadoVerificaReferenciaID2,
      objEmpleadoVerificaReferenciaID3: state.objEmpleadoVerificaReferenciaID3,
      cedulaReferencia1: state.cedulaReferencia1,
      cedulaReferencia2: state.cedulaReferencia2,
      cedulaReferencia3: state.cedulaReferencia3,
      direccionReferencia1: state.direccionReferencia1,
      direccionReferencia2: state.direccionReferencia2,
      direccionReferencia3: state.direccionReferencia3,
      telefonoReferencia1: state.telefonoReferencia1,
      telefonoReferencia2: state.telefonoReferencia2,
      telefonoReferencia3: state.telefonoReferencia3,
      lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
      lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
      lugarTrabajoReferencia3: state.lugarTrabajoReferencia3,
      aniosConocerReferido1: state.aniosConocerReferido1,
      aniosConocerReferido2: state.aniosConocerReferido2,
      aniosConocerReferido3: state.aniosConocerReferido3,
      parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
      parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
      parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
      resultadoVerificacion1: state.resultadoVerificacion1,
      resultadoVerificacion2: state.resultadoVerificacion2,
      resultadoVerificacion3: state.resultadoVerificacion3,
      adelantoClientes: state.adelantoClientes,
      adelantoProveedores: state.adelantoProveedores,
      aguaElectricidad: state.aguaElectricidad,
      aguaElectricidadGas: state.aguaElectricidadGas,
      alimentacion: state.alimentacion,
      alquilerlocal: state.alquilerlocal,
      alquilerFamiliar: state.alquilerFamiliar,
      aseoLimpieza: state.aseoLimpieza,
      caja: state.caja,
      cliente1: state.cliente1,
      cliente2: state.cliente2,
      cliente3: state.cliente3,
      combustible: state.combustible,
      cuentasAhorro: state.cuentasAhorro,
      costoVentaProduccion: state.costoVentaProduccion,
      costoVentaProduccionValor: state.costoVentaProduccionValor,
      creditosInstFinancieras: state.creditosInstFinancieras,
      diasBuenosVenta: state.diasBuenosVenta,
      diasMalosVenta: state.diasMalosVenta,
      diasNormalesVenta: state.diasNormalesVenta,
      gastosPersonalAlimentacion: state.gastosPersonalAlimentacion,
      impuesto: state.impuesto,
      ingresoAnual: state.ingresoAnual,
      incobrables: state.incobrables,
      educacion: state.educacion,
      ingresosFueraNegocio: state.ingresosFueraNegocio,
      prestamosAmigos: state.prestamosAmigos,
      otros: state.otros,
      salud: state.salud,
      otrosGastosImprevistos: state.otrosGastosImprevistos,
      pagoCreditosPrivados: state.pagoCreditosPrivados,
      totalConsumoFamiliar: state.totalConsumoFamiliar,
      pagoCuotaCredito: state.pagoCuotaCredito,
      proveedores: state.proveedores,
      totalCuentasXCobrar: state.totalCuentasXCobrar,
      totalInventario: state.totalInventario,
      proveedoresAdelantosOtros: state.proveedoresAdelantosOtros,
      resultadoLiquido: state.resultadoLiquido,
      saldoDisponibleUf: state.saldoDisponibleUf,
      pasivosMasPatrimonio: state.pasivosMasPatrimonio,
      patrimonio: state.patrimonio,
      recuperaciones: state.recuperaciones,
      reservas: state.reservas,
      semanasBuenas: state.semanasBuenas,
      semanasMalas: state.semanasMalas,
      semanasNormales: state.semanasNormales,
      totalActivos: state.totalActivos,
      totalActivosFijos: state.totalActivosFijos,
      totalComprasMensuales: state.totalComprasMensuales,
      subContratos: state.subContratos,
      transporte: state.transporte,
      transporteFamiliar: state.transporteFamiliar,
      ventasContado: state.ventasContado,
      totalCostosOperativos: state.totalCostosOperativos,
      totalDisponibleActivo: state.totalDisponibleActivo,
      totalIngresos: state.totalIngresos,
      totalInstFinancierasAmigosOtros: state.totalInstFinancierasAmigosOtros,
      totalPasivos: state.totalPasivos,
      totalVentasDiarias: state.totalVentasDiarias,
      totalVentasMensuales: state.totalVentasMensuales,
      ventasMensualesCompras: state.ventasMensualesCompras,
      ventasMensualesProduccion: state.ventasMensualesProduccion,
      vestimentaCalzado: state.vestimentaCalzado,
      database: state.database,
      destinoExcedentes: state.destinoExcedentes,
      maquinaCreacion: state.maquinaCreacion,
      nombreReferencia1: state.nombreReferencia1,
      numeroLicencia: state.numeroLicencia,
      permisoOperacionFechaEmision:
          DateTime.tryParse(state.permisoOperacionFechaEmision),
      permisoOperacionFechaVencimiento:
          DateTime.tryParse(state.permisoOperacionFechaVencimiento),
      permisoOperacionNumero: state.permisoOperacionNumero,
      permisoOperacionNombreInstitucion:
          state.permisoOperacionNombreInstitucion,
      nombreInstitucionLicencia: state.nombreInstitucionLicencia,
      nombreReferencia2: state.nombreReferencia2,
      nombreReferencia3: state.nombreReferencia3,
      proveedor1: state.proveedor1,
      proveedor2: state.proveedor2,
      proveedor3: state.proveedor3,
      usuarioCreacion: state.usuarioCreacion,
      fechaEmisionLicencia: DateTime.tryParse(state.fechaEmisionLicencia),
      fechaVencimientoLicencia:
          DateTime.tryParse(state.fechaVencimientoLicencia),
      fechaVerificacion1: DateTime.tryParse(state.fechaVerificacion1),
      fechaVerificacion2: DateTime.tryParse(state.fechaVerificacion2),
      fechaVerificacion3: DateTime.tryParse(state.fechaVerificacion3),
      numeroSolicitud: state.numeroSolicitud,
    );
  }

  void onFieldChanged(AnalisisReprestamoNiState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  /// Limpia la referencia adicional cuando el asesor la quita, para que no se
  /// envíe ni quede en el borrador.
  void quitarReferencia3() {
    onFieldChanged(
      () => state.copyWith(
        nombreReferencia3: '',
        cedulaReferencia3: '',
        direccionReferencia3: '',
        telefonoReferencia3: '',
        lugarTrabajoReferencia3: '',
        aniosConocerReferido3: 0,
        parentescoReferenciaCodigo3: '',
        resultadoVerificacion3: '',
        objEmpleadoVerificaReferenciaID3: '',
        fechaVerificacion3: '',
      ),
    );
  }

  void initCicloVentasMensuales(int numeroSolicitud) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final existing = localDbProvider.analisisCicloVentasMensualesHnBox
        .query(AnalisisCicloVentaHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisCicloVentaHnLocalDb_.typeFormAnalisis
                .equals('VENTAS_MESES')))
        .build()
        .find();

    if (existing.isNotEmpty) {
      emit(state.copyWith(
        cicloVentaMensual: CicloVentaHN(
          totalVentasDiaria:
              existing.fold(0, (sum, e) => (sum) + (e.venta?.toInt() ?? 0)),
          ciclo: existing
              .map((e) => Ciclo(
                    mes: e.mes ?? '',
                    venta: e.venta ?? 0,
                    valorizacion: e.valorizacion ?? '',
                  ))
              .toList(),
        ),
      ));
    } else {
      final defaultCiclo = [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre'
      ].map((mes) => Ciclo(mes: mes, venta: 0, valorizacion: 'M')).toList();

      // Guardar en BD
      final entities = defaultCiclo
          .map((c) => AnalisisCicloVentaHnLocalDb(
                mes: c.mes,
                venta: c.venta,
                valorizacion: c.valorizacion,
                typeFormAnalisis: 'VENTAS_MESES',
                numeroSolicitud: numeroSolicitud,
                uuid: const Uuid().v4(),
              ))
          .toList();

      localDbProvider.analisisCicloVentasMensualesHnBox.putMany(entities);

      emit(state.copyWith(
        totalVentasMensuales:
            defaultCiclo.fold(0, (sum, e) => (sum ?? 0) + e.venta.toInt()),
        cicloVentaMensual: CicloVentaHN(
          totalVentasDiaria:
              defaultCiclo.fold(0, (sum, e) => sum + e.venta.toInt()),
          ciclo: defaultCiclo,
        ),
      ));
    }
  }

  void initCicloVentasDiarias(int numeroSolicitud) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final existing = localDbProvider.cicloVentaDiariasHNBox
        .query(AnalisisCicloVentaHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisCicloVentaHnLocalDb_.typeFormAnalisis
                .equals('VENTAS_DIAS')))
        .build()
        .find();

    if (existing.isNotEmpty) {
      emit(state.copyWith(
        cicloVentaDiaria: CicloVentaDiaria(
          totalVentasDiaria:
              existing.fold(0, (sum, e) => (sum) + (e.venta ?? 0)),
          cicloVentas: existing
              .map((e) => CicloVenta(
                    dia: e.dia ?? '',
                    venta: e.venta ?? 0,
                    valorizacion: e.valorizacion ?? '',
                    maquinaCreacion: '',
                  ))
              .toList(),
        ),
      ));
    } else {
      final defaultCiclo = [
        'Lunes',
        'Martes',
        'Miercoles',
        'Jueves',
        'Viernes',
        'Sabado',
        'Domingo',
      ]
          .map((dia) => CicloVenta(
              dia: dia, venta: 0, valorizacion: 'M', maquinaCreacion: ''))
          .toList();

      // Guardar en BD
      final entities = defaultCiclo
          .map((c) => AnalisisCicloVentaHnLocalDb(
                dia: c.dia,
                venta: c.venta,
                valorizacion: c.valorizacion,
                typeFormAnalisis: 'VENTAS_DIAS',
                numeroSolicitud: numeroSolicitud,
                uuid: const Uuid().v4(),
              ))
          .toList();

      localDbProvider.cicloVentaDiariasHNBox.putMany(entities);

      emit(state.copyWith(
        cicloVentaDiaria: CicloVentaDiaria(
          totalVentasDiaria: 0,
          cicloVentas: defaultCiclo,
        ),
      ));
    }
  }

  void updateMesByName({
    required String mes,
    required int venta,
    required String valorizacion,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Buscar si ya existe ese mes para esa solicitud
    final query = localDbProvider.analisisCicloVentasMensualesHnBox
        .query(AnalisisCicloVentaHnLocalDb_.mes.equals(mes).and(
            AnalisisCicloVentaHnLocalDb_.numeroSolicitud
                .equals(numeroSolicitud)))
        .build();

    final existing = query.findFirst();
    query.close();

    final entity = existing ?? AnalisisCicloVentaHnLocalDb();

    // Actualizar o crear el registro
    entity.mes = mes;
    entity.venta = venta;
    entity.valorizacion = valorizacion;
    entity.numeroSolicitud = numeroSolicitud;
    entity.typeFormAnalisis = 'VENTAS_MESES';
    entity.uuid = mes; // usamos el nombre del mes como identificador lógico

    localDbProvider.analisisCicloVentasMensualesHnBox.put(entity);

    // Actualizar en memoria (state)
    final updatedCiclo = state.cicloVentaMensual.ciclo.map((c) {
      if (c.mes == mes) {
        return Ciclo(
          mes: mes,
          venta: venta,
          valorizacion: valorizacion,
        );
      }
      return c;
    }).toList();

    emit(
      state.copyWith(
        cicloVentaMensual: CicloVentaHN(
          totalVentasDiaria:
              state.cicloVentaMensual.ciclo.fold(0, (sum, e) => sum + e.venta),
          ciclo: updatedCiclo,
        ),
        // otros campos si tu state tiene más
      ),
    );
  }

  Map<String, dynamic> getCicloVentasMensuales() {
    if (state.cicloVentaMensual.ciclo.isEmpty) {
      return {'mesBueno': 0, 'mesNormal': 0, 'mesMalo': 0};
    }

    final sorted = state.cicloVentaMensual.ciclo
        .map((e) => e.venta)
        .toSet()
        .toList()
      ..sort((b, a) => a.compareTo(b));

    final uniqueCiclos = sorted
        .map((v) =>
            state.cicloVentaMensual.ciclo.firstWhere((c) => c.venta == v))
        .toList();

    final mesBueno = uniqueCiclos.first;
    final mesMalo = uniqueCiclos.last;
    final ventaNormales = state.cicloVentaMensual.ciclo
        .where((c) => c.valorizacion == 'N')
        .toList();

    final mesNormal = ventaNormales.isNotEmpty
        ? (ventaNormales..sort((b, a) => a.venta.compareTo(b.venta))).first
        : null;

    return {
      'mesBueno': mesBueno.venta,
      'mesNormal': mesNormal?.venta ?? 0,
      'mesMalo': mesMalo.venta,
    };
  }

  void updateDayByName({
    required String dia,
    required int venta,
    required String valorizacion,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Buscar si ya existe ese mes para esa solicitud
    final query = localDbProvider.cicloVentaDiariasHNBox
        .query(AnalisisCicloVentaHnLocalDb_.dia.equals(dia).and(
            AnalisisCicloVentaHnLocalDb_.numeroSolicitud
                .equals(numeroSolicitud)))
        .build();

    final existing = query.findFirst();
    query.close();

    final entity = existing ?? AnalisisCicloVentaHnLocalDb();

    // Actualizar o crear el registro
    entity.dia = dia;
    entity.venta = venta;
    entity.valorizacion = valorizacion;
    entity.numeroSolicitud = numeroSolicitud;
    entity.typeFormAnalisis = 'VENTAS_DIAS';
    entity.uuid = dia; // usamos el nombre del dia como identificador lógico

    localDbProvider.cicloVentaDiariasHNBox.put(entity);

    // Actualizar en memoria (state)
    final updatedCiclo = state.cicloVentaDiaria.cicloVentas.map((c) {
      if (c.dia == dia) {
        return CicloVenta(
            dia: dia,
            venta: venta,
            valorizacion: valorizacion,
            maquinaCreacion: '');
      }
      return c;
    }).toList();

    emit(
      state.copyWith(
        cicloVentaDiaria: CicloVentaDiaria(
          cicloVentas: updatedCiclo,
          totalVentasDiaria: state.cicloVentaDiaria.cicloVentas
              .fold(0, (sum, e) => sum + e.venta),
        ),
        // otros campos si tu state tiene más
      ),
    );
  }

  void updateCompraSemana({
    required int cantidadCompra,
    required String valorizacion,
    required String semanaDelMes,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Buscar si ya existe ese mes para esa solicitud
    final query = localDbProvider.cicloComprasSemanalesHnBox
        .query(AnalisisCicloComprasSemanalesHnLocalDb_.numerSolicitud
            .equals(numeroSolicitud)
            .and(AnalisisCicloComprasSemanalesHnLocalDb_.uuid
                .equals(semanaDelMes)))
        .build();

    final existing = query.findFirst();
    query.close();

    final entity = existing ?? AnalisisCicloComprasSemanalesHnLocalDb();

    // Actualizar o crear el registro
    entity.cantidadCompra = cantidadCompra;
    entity.semanaDelMes = semanaDelMes;
    entity.valorizacion = valorizacion;
    entity.numerSolicitud = numeroSolicitud;
    entity.uuid =
        semanaDelMes; // usamos el nombre del dia como identificador lógico

    localDbProvider.cicloComprasSemanalesHnBox.put(entity);

    // Actualizar en memoria (state)
    final updatedCiclo = state.cicloDeComprasSemanales.cicloCompra.map((c) {
      if (c.semanaDelMes == semanaDelMes) {
        return CicloCompraSemanal(
          cantidadCompra: cantidadCompra,
          valorizacion: valorizacion,
          semanaDelMes: semanaDelMes,
        );
      }
      return c;
    }).toList();

    emit(
      state.copyWith(
        cicloDeComprasSemanales: CicloDeComprasSemanalesHN(
          totalComprasMensualSemanal:
              updatedCiclo.fold(0, (sum, e) => sum + (e.cantidadCompra)),
          cicloCompra: updatedCiclo,
        ),
        // otros campos si tu state tiene más
      ),
    );
  }

  Map<String, dynamic> getCicloVentasDiarios() {
    if (state.cicloVentaDiaria.cicloVentas.isEmpty) {
      return {'diasBuenos': 0, 'diasNormales': 0, 'diasMalos': 0};
    }

    final sorted = state.cicloVentaDiaria.cicloVentas
        .map((e) => e.venta)
        .toSet()
        .toList()
      ..sort((b, a) => a.compareTo(b));

    final uniqueCiclos = sorted
        .map((v) =>
            state.cicloVentaDiaria.cicloVentas.firstWhere((c) => c.venta == v))
        .toList();

    final diasBuenos = uniqueCiclos.first;
    final diasMalos = uniqueCiclos.last;
    final ventaNormales = state.cicloVentaDiaria.cicloVentas
        .where((c) => c.valorizacion == 'N')
        .toList();

    final diasNormales = ventaNormales.isNotEmpty
        ? (ventaNormales..sort((b, a) => a.venta.compareTo(b.venta))).first
        : null;
    return {
      'diasBuenos': diasBuenos.venta,
      'diasNormales': diasNormales?.venta ?? 0,
      'diasMalos': diasMalos.venta,
    };
  }

  Map<String, dynamic> getcomprasSemanasMensuales() {
    if (state.cicloVentaDiaria.cicloVentas.isEmpty) {
      return {'semanasBuenas': 0, 'semanasNormales': 0, 'semanasMalas': 0};
    }

    final sorted = state.cicloDeComprasSemanales.cicloCompra
        .map((e) => e.cantidadCompra)
        .toSet()
        .toList()
      ..sort((b, a) => a.compareTo(b));

    final uniqueCiclos = sorted
        .map((v) => state.cicloDeComprasSemanales.cicloCompra
            .firstWhere((c) => c.cantidadCompra == v))
        .toList();

    final semanasBuenas = uniqueCiclos.first;
    final semanasMalas = uniqueCiclos.last;
    final ventaNormales = state.cicloDeComprasSemanales.cicloCompra
        .where((c) => c.valorizacion == 'N')
        .toList();

    final semanasNormales = ventaNormales.isNotEmpty
        ? (ventaNormales
              ..sort((b, a) => a.cantidadCompra.compareTo(b.cantidadCompra)))
            .first
        : null;

    return {
      'semanasBuenas': semanasBuenas.cantidadCompra,
      'semanasNormales': semanasNormales?.cantidadCompra ?? 0,
      'semanasMalas': semanasMalas.cantidadCompra,
    };
  }

  saveCuentaNivelProduccion({
    required NivelProduccionHN nivelProduccion,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.nivelProduccionHnBox.put(
      AnalisisNivelProduccionLocalDb(
        articuloProduccion: nivelProduccion.articuloProduccion,
        frecuenciaProduccionCodigo: nivelProduccion.frecuenciaProduccionCodigo,
        cantidadProduccion: nivelProduccion.cantidadProduccion,
        precioVentaUnidad: nivelProduccion.precioVentaUnidad,
        totalMensualProduccion: nivelProduccion.totalMensualProduccion,
        uuid: nivelProduccion.uuid,
        numeroSolicitud: numeroSolicitud,
      ),
    );
    emit(
      state.copyWith(
        nivelProduccion: [
          ...state.nivelProduccion,
          nivelProduccion,
        ],
      ),
    );
  }

  void updateNivelProduccion({
    required AnalisisNivelProduccionLocalDb nivelProduccion,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.nivelProduccionHnBox;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisNivelProduccionLocalDb_.uuid.equals(nivelProduccion.uuid!) &
              AnalisisNivelProduccionLocalDb_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No existe → no hay nada que actualizar
      return;
    }

    // 2. Actualizar campos
    existente
      ..articuloProduccion = nivelProduccion.articuloProduccion
      ..frecuenciaProduccionCodigo = nivelProduccion.frecuenciaProduccionCodigo
      ..cantidadProduccion = nivelProduccion.cantidadProduccion
      ..precioVentaUnidad = nivelProduccion.precioVentaUnidad
      ..totalMensualProduccion = nivelProduccion.totalMensualProduccion;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final nivelProduccionUpdated = NivelProduccionHN(
      articuloProduccion: nivelProduccion.articuloProduccion ?? '',
      frecuenciaProduccionCodigo:
          nivelProduccion.frecuenciaProduccionCodigo ?? '',
      cantidadProduccion: nivelProduccion.cantidadProduccion ?? 0,
      precioVentaUnidad: nivelProduccion.precioVentaUnidad ?? 0,
      totalMensualProduccion: nivelProduccion.totalMensualProduccion ?? 0,
      uuid: nivelProduccion.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        nivelProduccion: state.nivelProduccion
            .map((e) =>
                e.uuid == nivelProduccion.uuid ? nivelProduccionUpdated : e)
            .toList(),
      ),
    );
  }

  void deleteNivelProduccion({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.nivelProduccionHnBox;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisNivelProduccionLocalDb_.uuid.equals(uuid) &
              AnalisisNivelProduccionLocalDb_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No hay nada que borrar
      return;
    }

    // 2. Eliminarlo por ID
    box.remove(existente.id);

    // 3. Eliminar también del estado
    emit(
      state.copyWith(
        nivelProduccion:
            state.nivelProduccion.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }

  void initCicloComprasSemanales(int numeroSolicitud) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final existing = localDbProvider.cicloComprasSemanalesHnBox
        .query(AnalisisCicloComprasSemanalesHnLocalDb_.numerSolicitud
            .equals(numeroSolicitud))
        .build()
        .find();

    if (existing.isNotEmpty) {
      emit(
        state.copyWith(
          cicloDeComprasSemanales: CicloDeComprasSemanalesHN(
            totalComprasMensualSemanal:
                existing.fold(0, (sum, e) => sum + (e.cantidadCompra ?? 0)),
            cicloCompra: existing
                .map(
                  (e) => CicloCompraSemanal(
                    cantidadCompra: e.cantidadCompra ?? 0,
                    semanaDelMes: e.semanaDelMes ?? '',
                    valorizacion: e.valorizacion ?? '',
                  ),
                )
                .toList(),
          ),
        ),
      );
    } else {
      final defaultCiclo = [
        'Primera Semana',
        'Segunda Semana',
        'Tercera Semana',
        'Cuarta Semana',
      ]
          .map(
            (semana) => CicloCompraSemanal(
              semanaDelMes: semana,
              cantidadCompra: 0,
              valorizacion: 'M',
            ),
          )
          .toList();

      // Guardar en BD
      final entities = defaultCiclo
          .map((c) => AnalisisCicloComprasSemanalesHnLocalDb(
                cantidadCompra: c.cantidadCompra,
                semanaDelMes: c.semanaDelMes,
                valorizacion: c.valorizacion,
                uuid: c.semanaDelMes,
                numerSolicitud: numeroSolicitud,
              ))
          .toList();

      localDbProvider.cicloComprasSemanalesHnBox.putMany(entities);

      emit(state.copyWith(
        cicloDeComprasSemanales: CicloDeComprasSemanalesHN(
          totalComprasMensualSemanal:
              defaultCiclo.fold(0, (sum, e) => sum + (e.cantidadCompra)),
          cicloCompra: defaultCiclo,
        ),
      ));
    }
  }

  saveComprasPorProveedor({
    required ComprasProveedorArticuloHN comprasPorProveedor,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.analisisComprasProveedorArticuloHnLocalDb.put(
      AnalisisComprasProveedorArticuloHnLocalDb(
        frecuenciaCompraContadoCodigo:
            comprasPorProveedor.frecuenciaCompraContadoCodigo,
        frecuenciaCompraCreditoCodigo:
            comprasPorProveedor.frecuenciaCompraCreditoCodigo,
        montoCompraContado: comprasPorProveedor.montoCompraContado,
        montoCompraCredito: comprasPorProveedor.montoCompraCredito,
        proveedorArticulo: comprasPorProveedor.proveedorArticulo,
        totalCompraMensual: comprasPorProveedor.totalCompraMensual,
        uuid: comprasPorProveedor.uuid,
        numeroSolicitud: numeroSolicitud,
      ),
    );
    emit(
      state.copyWith(
        comprasProveedorArticulo: [
          ...state.comprasProveedorArticulo,
          comprasPorProveedor,
        ],
      ),
    );
  }

  void updateComprasPorProveedor({
    required AnalisisComprasProveedorArticuloHnLocalDb comprasPorProveedor,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.analisisComprasProveedorArticuloHnLocalDb;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisComprasProveedorArticuloHnLocalDb_.uuid
                  .equals(comprasPorProveedor.uuid!) &
              AnalisisComprasProveedorArticuloHnLocalDb_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No existe → no hay nada que actualizar
      return;
    }

    // 2. Actualizar campos
    existente
      ..frecuenciaCompraContadoCodigo =
          comprasPorProveedor.frecuenciaCompraContadoCodigo
      ..frecuenciaCompraCreditoCodigo =
          comprasPorProveedor.frecuenciaCompraCreditoCodigo
      ..montoCompraContado = comprasPorProveedor.montoCompraContado
      ..montoCompraCredito = comprasPorProveedor.montoCompraCredito
      ..proveedorArticulo = comprasPorProveedor.proveedorArticulo
      ..totalCompraMensual = comprasPorProveedor.totalCompraMensual;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final comprasPorProveedorList = ComprasProveedorArticuloHN(
      frecuenciaCompraContadoCodigo:
          comprasPorProveedor.frecuenciaCompraContadoCodigo ?? '',
      montoCompraContado: comprasPorProveedor.montoCompraContado ?? 0,
      proveedorArticulo: comprasPorProveedor.proveedorArticulo ?? '',
      frecuenciaCompraCreditoCodigo:
          comprasPorProveedor.frecuenciaCompraCreditoCodigo ?? '',
      montoCompraCredito: comprasPorProveedor.montoCompraCredito ?? 0,
      totalCompraMensual: comprasPorProveedor.totalCompraMensual ?? 0,
      uuid: comprasPorProveedor.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        comprasProveedorArticulo: state.comprasProveedorArticulo
            .map((e) => e.uuid == comprasPorProveedor.uuid
                ? comprasPorProveedorList
                : e)
            .toList(),
      ),
    );
  }

  saveCuentaPorCobrar({
    required CuentasPorCobrarHN cuentasPorCobrar,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.cuentasPorCobrarHnBox.put(
      AnalisisCuentasPorCobrarHn(
        abonoCredito: cuentasPorCobrar.abonoCredito,
        frecuenciaAbonoCodigo: cuentasPorCobrar.frecuenciaAbonoCodigo,
        totalMensualCredito: cuentasPorCobrar.totalMensualCredito,
        nombre: cuentasPorCobrar.nombre,
        montoCredito: cuentasPorCobrar.montoCredito,
        uuid: cuentasPorCobrar.uuid,
        numeroSolicitud: numeroSolicitud,
        isReprestamoForm: true,
      ),
    );
    emit(
      state.copyWith(
        cuentasPorCobrar: [
          ...state.cuentasPorCobrar,
          cuentasPorCobrar,
        ],
      ),
    );
  }

  void updateCuentaPorCobrar({
    required AnalisisCuentasPorCobrarHn cuentasPorCobrar,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.cuentasPorCobrarHnBox;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisCuentasPorCobrarHn_.uuid.equals(cuentasPorCobrar.uuid!) &
              AnalisisCuentasPorCobrarHn_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No existe → no hay nada que actualizar
      return;
    }

    // 2. Actualizar campos
    existente
      ..nombre = cuentasPorCobrar.nombre
      ..montoCredito = cuentasPorCobrar.montoCredito
      ..abonoCredito = cuentasPorCobrar.abonoCredito
      ..frecuenciaAbonoCodigo = cuentasPorCobrar.frecuenciaAbonoCodigo
      ..totalMensualCredito = cuentasPorCobrar.totalMensualCredito;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final cuentaPorCobrar = CuentasPorCobrarHN(
      abonoCredito: cuentasPorCobrar.abonoCredito ?? 0,
      frecuenciaAbonoCodigo: cuentasPorCobrar.frecuenciaAbonoCodigo ?? '',
      totalMensualCredito: cuentasPorCobrar.totalMensualCredito ?? 0,
      nombre: cuentasPorCobrar.nombre ?? '',
      montoCredito: cuentasPorCobrar.montoCredito ?? 0,
      uuid: cuentasPorCobrar.uuid ?? '',
      isReprestamoForm: true,
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        cuentasPorCobrar: state.cuentasPorCobrar
            .map((e) => e.uuid == cuentasPorCobrar.uuid ? cuentaPorCobrar : e)
            .toList(),
      ),
    );
  }

  void deleteCuentaPorCobrar({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.cuentasPorCobrarHnBox;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisCuentasPorCobrarHn_.uuid.equals(uuid) &
              AnalisisCuentasPorCobrarHn_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No hay nada que borrar
      return;
    }

    // 2. Eliminarlo por ID
    box.remove(existente.id);

    // 3. Eliminar también del estado
    emit(
      state.copyWith(
        cuentasPorCobrar:
            state.cuentasPorCobrar.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }

  saveInventario({
    required InventarioHN inventario,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.analisisInventarioHnLocalDb.put(
      AnalisisInventarioHnLocalDb(
        articulo: inventario.articulo,
        costoCompra: inventario.costoCompra,
        precioVenta: inventario.precioVenta,
        cantidad: inventario.cantidad,
        costoVentaPorcentaje: inventario.costoVentaPorcentaje,
        total: inventario.total,
        numeroSolicitud: numeroSolicitud,
        uuid: inventario.uuid,
      ),
    );
    emit(
      state.copyWith(
        inventario: [
          ...state.inventario,
          inventario,
        ],
      ),
    );
  }

  void updateInventario({
    required AnalisisInventarioHnLocalDb inventario,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.analisisInventarioHnLocalDb;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisInventarioHnLocalDb_.uuid.equals(inventario.uuid!) &
              AnalisisInventarioHnLocalDb_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No existe → no hay nada que actualizar
      return;
    }

    // 2. Actualizar campos
    existente
      ..articulo = inventario.articulo
      ..cantidad = inventario.cantidad
      ..costoCompra = inventario.costoCompra
      ..precioVenta = inventario.precioVenta
      ..costoVentaPorcentaje = inventario.costoVentaPorcentaje
      ..total = inventario.total;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final comprasPorProveedorList = InventarioHN(
      cantidad: inventario.cantidad ?? 0,
      articulo: inventario.articulo ?? '',
      costoCompra: inventario.costoCompra ?? 0,
      precioVenta: inventario.precioVenta ?? 0,
      costoVentaPorcentaje: inventario.costoVentaPorcentaje ?? 0,
      total: inventario.total ?? 0,
      uuid: inventario.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        inventario: state.inventario
            .map((e) => e.uuid == inventario.uuid ? comprasPorProveedorList : e)
            .toList(),
      ),
    );
  }

  void deleteInventario({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.analisisInventarioHnLocalDb;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisInventarioHnLocalDb_.uuid.equals(uuid) &
              AnalisisInventarioHnLocalDb_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No hay nada que borrar
      return;
    }

    // 2. Eliminarlo por ID
    box.remove(existente.id);

    // 3. Eliminar también del estado
    emit(
      state.copyWith(
        inventario: state.inventario.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }

  void deleteActivo({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.analisisActivoHnLocalDb;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisActivoHnLocalDb_.uuid.equals(uuid) &
              AnalisisActivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No hay nada que borrar
      return;
    }

    // 2. Eliminarlo por ID
    box.remove(existente.id);

    // 3. Eliminar también del estado
    emit(
      state.copyWith(
        activos: state.activos.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }

  void updateActivosFijos({
    required AnalisisActivoHnLocalDb activo,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.analisisActivoHnLocalDb;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisActivoHnLocalDb_.uuid.equals(activo.uuid!) &
              AnalisisActivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No existe → no hay nada que actualizar
      return;
    }

    // 2. Actualizar campos
    existente
      ..nombreActivo = activo.nombreActivo
      ..monto = activo.monto;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final inventarioUpdated = ActivoHN(
      nombreActivo: activo.nombreActivo ?? '',
      monto: activo.monto ?? 0,
      uuid: activo.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        activos: state.activos
            .map((e) => e.uuid == activo.uuid ? inventarioUpdated : e)
            .toList(),
      ),
    );
  }

  saveActivosFijos({
    required ActivoHN activoFijo,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.analisisActivoHnLocalDb.put(
      AnalisisActivoHnLocalDb(
        monto: activoFijo.monto,
        nombreActivo: activoFijo.nombreActivo,
        uuid: activoFijo.uuid,
        numeroSolicitud: numeroSolicitud,
      ),
    );
    emit(
      state.copyWith(
        activos: [
          ...state.activos,
          activoFijo,
        ],
      ),
    );
  }

  void loadCuentasPorCobrar({required int numeroSolicitud}) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final cuentasGuardadas = localDbProvider.cuentasPorCobrarHnBox
        .query(
            AnalisisCuentasPorCobrarHn_.numeroSolicitud.equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final cuentasPorCobrarList = cuentasGuardadas
        .map((c) => CuentasPorCobrarHN(
              abonoCredito: c.abonoCredito ?? 0,
              frecuenciaAbonoCodigo: c.frecuenciaAbonoCodigo ?? '',
              totalMensualCredito: c.totalMensualCredito ?? 0,
              nombre: c.nombre ?? '',
              montoCredito: c.montoCredito ?? 0,
              uuid: c.uuid ?? '',
              isReprestamoForm: true,
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      cuentasPorCobrar: cuentasPorCobrarList,
      totalCuentasXCobrar: cuentasPorCobrarList.fold(
        0,
        (sum, e) => (sum ?? 0) + e.totalMensualCredito,
      ),
    ));
  }

  void loadNivelProduccionFromLocalDb({required int numeroSolicitud}) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final nivelProduccion = localDbProvider.nivelProduccionHnBox
        .query(AnalisisNivelProduccionLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final nivelProduccionList = nivelProduccion
        .map((c) => NivelProduccionHN(
              articuloProduccion: c.articuloProduccion ?? '',
              cantidadProduccion: c.cantidadProduccion ?? 0,
              precioVentaUnidad: c.precioVentaUnidad ?? 0,
              frecuenciaProduccionCodigo: c.frecuenciaProduccionCodigo ?? '',
              totalMensualProduccion: c.totalMensualProduccion ?? 0,
              uuid: c.uuid ?? '',
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      nivelProduccion: nivelProduccionList,
    ));
  }

  void loadComprasProveedorFromLocalDb({required int numeroSolicitud}) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final comprasProveedorDb = localDbProvider
        .analisisComprasProveedorArticuloHnLocalDb
        .query(AnalisisComprasProveedorArticuloHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final comprasProveedorList = comprasProveedorDb
        .map((c) => ComprasProveedorArticuloHN(
              frecuenciaCompraContadoCodigo:
                  c.frecuenciaCompraContadoCodigo ?? '',
              frecuenciaCompraCreditoCodigo:
                  c.frecuenciaCompraCreditoCodigo ?? '',
              montoCompraContado: c.montoCompraContado ?? 0,
              montoCompraCredito: c.montoCompraCredito ?? 0,
              proveedorArticulo: c.proveedorArticulo ?? '',
              totalCompraMensual: c.totalCompraMensual ?? 0,
              uuid: c.uuid ?? '',
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      comprasProveedorArticulo: comprasProveedorList,
    ));
  }

  void loadActivosFijosFromLocalDb({
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final activosFijosDb = localDbProvider.analisisActivoHnLocalDb
        .query(AnalisisActivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final activosFijosList = activosFijosDb
        .map((c) => ActivoHN(
              nombreActivo: c.nombreActivo ?? '',
              monto: c.monto ?? 0,
              uuid: c.uuid ?? '',
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      activos: activosFijosList,
    ));
  }

  void loadInventarioFromLocalDb({
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final inventarioDb = localDbProvider.analisisInventarioHnLocalDb
        .query(AnalisisInventarioHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final inventarioList = inventarioDb
        .map((c) => InventarioHN(
              cantidad: c.cantidad ?? 0,
              articulo: c.articulo ?? '',
              costoCompra: c.costoCompra ?? 0,
              precioVenta: c.precioVenta ?? 0,
              costoVentaPorcentaje: c.costoVentaPorcentaje ?? 0,
              total: c.total ?? 0,
              uuid: c.uuid ?? '',
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      inventario: inventarioList,
    ));
  }
}
