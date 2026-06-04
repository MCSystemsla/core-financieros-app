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
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_represtamo_state.dart';

class AnalisisReprestamoCubit extends Cubit<AnalisisReprestamoState> {
  final AnalisisRepositoryHn _repository;
  late final AnalisisReprestamoHnAutosave autoSaveHelper;

  AnalisisReprestamoCubit(this._repository)
      : super(AnalisisReprestamoInitial());

  Future<void> createAnalisisReprestamo() async {
    final incobrablesxCobrar = global<SolicitudesHnBoxService>()
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

    final costoPorcentajeVenta = state.inventario
            .fold(0.0, (sum, element) => sum + (element.costoVentaPorcentaje)) /
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

    final porcentajeDeVenta = (state.inventario.fold(
                0.0, (sum, element) => sum + (element.costoVentaPorcentaje)) /
            (state.inventario.length))
        .toStringAsFixed(2);

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
      objEmpleadoVerificaReferenciaID1: _prefer(
          state.objEmpleadoVerificaReferenciaID1,
          prev?.objEmpleadoVerificaReferenciaID1),
      objEmpleadoVerificaReferenciaID2: _prefer(
          state.objEmpleadoVerificaReferenciaID2,
          prev?.objEmpleadoVerificaReferenciaID2),
      objEmpleadoVerificaReferenciaID3: _prefer(
          state.objEmpleadoVerificaReferenciaID3,
          prev?.objEmpleadoVerificaReferenciaID3),
      cedulaReferencia1:
          _prefer(state.cedulaReferencia1, prev?.cedulaReferencia1),
      cedulaReferencia2:
          _prefer(state.cedulaReferencia2, prev?.cedulaReferencia2),
      cedulaReferencia3:
          _prefer(state.cedulaReferencia3, prev?.cedulaReferencia3),
      direccionReferencia1:
          _prefer(state.direccionReferencia1, prev?.direccionReferencia1),
      direccionReferencia2:
          _prefer(state.direccionReferencia2, prev?.direccionReferencia2),
      direccionReferencia3:
          _prefer(state.direccionReferencia3, prev?.direccionReferencia3),
      telefonoReferencia1:
          _prefer(state.telefonoReferencia1, prev?.telefonoReferencia1),
      telefonoReferencia2:
          _prefer(state.telefonoReferencia2, prev?.telefonoReferencia2),
      telefonoReferencia3:
          _prefer(state.telefonoReferencia3, prev?.telefonoReferencia3),
      lugarTrabajoReferencia1:
          _prefer(state.lugarTrabajoReferencia1, prev?.lugarTrabajoReferencia1),
      lugarTrabajoReferencia2:
          _prefer(state.lugarTrabajoReferencia2, prev?.lugarTrabajoReferencia2),
      lugarTrabajoReferencia3:
          _prefer(state.lugarTrabajoReferencia3, prev?.lugarTrabajoReferencia3),
      aniosConocerReferido1: state.aniosConocerReferido1 == 0
          ? (prev?.aniosConocerReferido1 ?? 0)
          : state.aniosConocerReferido1,
      aniosConocerReferido2: state.aniosConocerReferido2 == 0
          ? (prev?.aniosConocerReferido2 ?? 0)
          : state.aniosConocerReferido2,
      aniosConocerReferido3: state.aniosConocerReferido3 == 0
          ? (prev?.aniosConocerReferido3 ?? 0)
          : state.aniosConocerReferido3,
      parentescoReferenciaCodigo1: _prefer(
          state.parentescoReferenciaCodigo1, prev?.parentescoReferenciaCodigo1),
      parentescoReferenciaCodigo2: _prefer(
          state.parentescoReferenciaCodigo2, prev?.parentescoReferenciaCodigo2),
      parentescoReferenciaCodigo3: _prefer(
          state.parentescoReferenciaCodigo3, prev?.parentescoReferenciaCodigo3),
      resultadoVerificacion1:
          _prefer(state.resultadoVerificacion1, prev?.resultadoVerificacion1),
      resultadoVerificacion2:
          _prefer(state.resultadoVerificacion2, prev?.resultadoVerificacion2),
      resultadoVerificacion3:
          _prefer(state.resultadoVerificacion3, prev?.resultadoVerificacion3),
      adelantoClientes: state.adelantoClientes == 0
          ? (prev?.adelantoClientes ?? 0)
          : state.adelantoClientes,
      adelantoProveedores: state.adelantoProveedores == 0
          ? (prev?.adelantoProveedores ?? 0)
          : state.adelantoProveedores,
      aguaElectricidad: state.aguaElectricidad == 0
          ? (prev?.aguaElectricidad ?? 0)
          : state.aguaElectricidad,
      aguaElectricidadGas: state.aguaElectricidadGas == 0
          ? (prev?.aguaElectricidadGas ?? 0)
          : state.aguaElectricidadGas,
      alimentacion: state.alimentacion == 0
          ? (prev?.alimentacion ?? 0)
          : state.alimentacion,
      alquilerlocal: state.alquilerlocal == 0
          ? (prev?.alquilerlocal ?? 0)
          : state.alquilerlocal,
      alquilerFamiliar: state.alquilerFamiliar == 0
          ? (prev?.alquilerFamiliar ?? 0)
          : state.alquilerFamiliar,
      aseoLimpieza: state.aseoLimpieza == 0
          ? (prev?.aseoLimpieza ?? 0)
          : state.aseoLimpieza,
      caja: state.caja == 0 ? (prev?.caja ?? 0) : state.caja,
      cliente1: _prefer(state.cliente1, prev?.cliente1),
      cliente2: _prefer(state.cliente2, prev?.cliente2),
      cliente3: _prefer(state.cliente3, prev?.cliente3),
      combustible:
          state.combustible == 0 ? (prev?.combustible ?? 0) : state.combustible,
      cuentasAhorro: state.cuentasAhorro == 0
          ? (prev?.cuentasAhorro ?? 0)
          : state.cuentasAhorro,
      costoVentaProduccion: state.costoVentaProduccion == 0
          ? (prev?.costoVentaProduccion ?? 0)
          : state.costoVentaProduccion,
      costoVentaProduccionValor: state.costoVentaProduccionValor == 0
          ? (prev?.costoVentaProduccionValor ?? 0)
          : state.costoVentaProduccionValor,
      creditosInstFinancieras: state.creditosInstFinancieras == 0
          ? (prev?.creditosInstFinancieras ?? 0)
          : state.creditosInstFinancieras,
      diasBuenosVenta: state.diasBuenosVenta == 0
          ? (prev?.diasBuenosVenta ?? 0)
          : state.diasBuenosVenta,
      diasMalosVenta: state.diasMalosVenta == 0
          ? (prev?.diasMalosVenta ?? 0)
          : state.diasMalosVenta,
      diasNormalesVenta: state.diasNormalesVenta == 0
          ? (prev?.diasNormalesVenta ?? 0)
          : state.diasNormalesVenta,
      gastosPersonalAlimentacion: state.gastosPersonalAlimentacion == 0
          ? (prev?.gastosPersonalAlimentacion ?? 0)
          : state.gastosPersonalAlimentacion,
      impuesto: state.impuesto == 0 ? (prev?.impuesto ?? 0) : state.impuesto,
      ingresoAnual: state.ingresoAnual == 0
          ? (prev?.ingresoAnual ?? 0)
          : state.ingresoAnual,
      incobrables:
          state.incobrables == 0 ? (prev?.incobrables ?? 0) : state.incobrables,
      educacion:
          state.educacion == 0 ? (prev?.educacion ?? 0) : state.educacion,
      ingresosFueraNegocio: state.ingresosFueraNegocio == 0
          ? (prev?.ingresosFueraNegocio ?? 0)
          : state.ingresosFueraNegocio,
      prestamosAmigos: state.prestamosAmigos == 0
          ? (prev?.prestamosAmigos ?? 0)
          : state.prestamosAmigos,
      otros: state.otros == 0 ? (prev?.otros ?? 0) : state.otros,
      salud: state.salud == 0 ? (prev?.salud ?? 0) : state.salud,
      otrosGastosImprevistos: state.otrosGastosImprevistos == 0
          ? (prev?.otrosGastosImprevistos ?? 0)
          : state.otrosGastosImprevistos,
      pagoCreditosPrivados: state.pagoCreditosPrivados == 0
          ? (prev?.pagoCreditosPrivados ?? 0)
          : state.pagoCreditosPrivados,
      totalConsumoFamiliar: state.totalConsumoFamiliar == 0
          ? (prev?.totalConsumoFamiliar ?? 0)
          : state.totalConsumoFamiliar,
      pagoCuotaCredito: state.pagoCuotaCredito == 0
          ? (prev?.pagoCuotaCredito ?? 0)
          : state.pagoCuotaCredito,
      proveedores:
          state.proveedores == 0 ? (prev?.proveedores ?? 0) : state.proveedores,
      totalCuentasXCobrar: state.totalCuentasXCobrar == 0
          ? (prev?.totalCuentasXCobrar ?? 0)
          : state.totalCuentasXCobrar,
      totalInventario: state.totalInventario == 0
          ? (prev?.totalInventario ?? 0)
          : state.totalInventario,
      proveedoresAdelantosOtros: state.proveedoresAdelantosOtros == 0
          ? (prev?.proveedoresAdelantosOtros ?? 0)
          : state.proveedoresAdelantosOtros,
      resultadoLiquido: state.resultadoLiquido == 0
          ? (prev?.resultadoLiquido ?? 0)
          : state.resultadoLiquido,
      saldoDisponibleUf: state.saldoDisponibleUf == 0
          ? (prev?.saldoDisponibleUf ?? 0)
          : state.saldoDisponibleUf,
      pasivosMasPatrimonio: state.pasivosMasPatrimonio == 0
          ? (prev?.pasivosMasPatrimonio ?? 0)
          : state.pasivosMasPatrimonio,
      patrimonio:
          state.patrimonio == 0 ? (prev?.patrimonio ?? 0) : state.patrimonio,
      recuperaciones: state.recuperaciones == 0
          ? (prev?.recuperaciones ?? 0)
          : state.recuperaciones,
      reservas: state.reservas == 0 ? (prev?.reservas ?? 0) : state.reservas,
      semanasBuenas: state.semanasBuenas == 0
          ? (prev?.semanasBuenas ?? 0)
          : state.semanasBuenas,
      semanasMalas: state.semanasMalas == 0
          ? (prev?.semanasMalas ?? 0)
          : state.semanasMalas,
      semanasNormales: state.semanasNormales == 0
          ? (prev?.semanasNormales ?? 0)
          : state.semanasNormales,
      totalActivos: state.totalActivos == 0
          ? (prev?.totalActivos ?? 0)
          : state.totalActivos,
      totalActivosFijos: state.totalActivosFijos == 0
          ? (prev?.totalActivosFijos ?? 0)
          : state.totalActivosFijos,
      totalComprasMensuales: state.totalComprasMensuales == 0
          ? (prev?.totalComprasMensuales ?? 0)
          : state.totalComprasMensuales,
      subContratos: state.subContratos == 0
          ? (prev?.subContratos ?? 0)
          : state.subContratos,
      transporte:
          state.transporte == 0 ? (prev?.transporte ?? 0) : state.transporte,
      transporteFamiliar: state.transporteFamiliar == 0
          ? (prev?.transporteFamiliar ?? 0)
          : state.transporteFamiliar,
      ventasContado: state.ventasContado == 0
          ? (prev?.ventasContado ?? 0)
          : state.ventasContado,
      totalCostosOperativos: state.totalCostosOperativos == 0
          ? (prev?.totalCostosOperativos ?? 0)
          : state.totalCostosOperativos,
      totalDisponibleActivo: state.totalDisponibleActivo == 0
          ? (prev?.totalDisponibleActivo ?? 0)
          : state.totalDisponibleActivo,
      totalIngresos: state.totalIngresos == 0
          ? (prev?.totalIngresos ?? 0)
          : state.totalIngresos,
      totalInstFinancierasAmigosOtros:
          state.totalInstFinancierasAmigosOtros == 0
              ? (prev?.totalInstFinancierasAmigosOtros ?? 0)
              : state.totalInstFinancierasAmigosOtros,
      totalPasivos: state.totalPasivos == 0
          ? (prev?.totalPasivos ?? 0)
          : state.totalPasivos,
      totalVentasDiarias: state.totalVentasDiarias == 0
          ? (prev?.totalVentasDiarias ?? 0)
          : state.totalVentasDiarias,
      totalVentasMensuales: state.totalVentasMensuales == 0
          ? (prev?.totalVentasMensuales ?? 0)
          : state.totalVentasMensuales,
      ventasMensualesCompras: state.ventasMensualesCompras == 0
          ? (prev?.ventasMensualesCompras ?? 0)
          : state.ventasMensualesCompras,
      ventasMensualesProduccion: state.ventasMensualesProduccion == 0
          ? (prev?.ventasMensualesProduccion ?? 0)
          : state.ventasMensualesProduccion,
      vestimentaCalzado: state.vestimentaCalzado == 0
          ? (prev?.vestimentaCalzado ?? 0)
          : state.vestimentaCalzado,
      database: _prefer(state.database, prev?.database),
      destinoExcedentes:
          _prefer(state.destinoExcedentes, prev?.destinoExcedentes),
      maquinaCreacion: _prefer(state.maquinaCreacion, prev?.maquinaCreacion),
      nombreReferencia1:
          _prefer(state.nombreReferencia1, prev?.nombreReferencia1),
      numeroLicencia: _prefer(state.numeroLicencia, prev?.numeroLicencia),
      permisoOperacionFechaEmision: _preferDate(
          state.permisoOperacionFechaEmision,
          prev?.permisoOperacionFechaEmision),
      permisoOperacionFechaVencimiento: _preferDate(
          state.permisoOperacionFechaVencimiento,
          prev?.permisoOperacionFechaVencimiento),
      permisoOperacionNumero:
          _prefer(state.permisoOperacionNumero, prev?.permisoOperacionNumero),
      permisoOperacionNombreInstitucion: _prefer(
          state.permisoOperacionNombreInstitucion,
          prev?.permisoOperacionNombreInstitucion),
      nombreInstitucionLicencia: _prefer(
          state.nombreInstitucionLicencia, prev?.nombreInstitucionLicencia),
      nombreReferencia2:
          _prefer(state.nombreReferencia2, prev?.nombreReferencia2),
      nombreReferencia3:
          _prefer(state.nombreReferencia3, prev?.nombreReferencia3),
      proveedor1: _prefer(state.proveedor1, prev?.proveedor1),
      proveedor2: _prefer(state.proveedor2, prev?.proveedor2),
      proveedor3: _prefer(state.proveedor3, prev?.proveedor3),
      usuarioCreacion: _prefer(state.usuarioCreacion, prev?.usuarioCreacion),
      fechaEmisionLicencia:
          _preferDate(state.fechaEmisionLicencia, prev?.fechaEmisionLicencia),
      fechaVencimientoLicencia: _preferDate(
          state.fechaVencimientoLicencia, prev?.fechaVencimientoLicencia),
      fechaVerificacion1:
          _preferDate(state.fechaVerificacion1, prev?.fechaVerificacion1),
      fechaVerificacion2:
          _preferDate(state.fechaVerificacion2, prev?.fechaVerificacion2),
      fechaVerificacion3:
          _preferDate(state.fechaVerificacion3, prev?.fechaVerificacion3),
      numeroSolicitud: state.numeroSolicitud == 0
          ? (prev?.numeroSolicitud ?? 0)
          : state.numeroSolicitud,
    );
  }

  void onFieldChanged(AnalisisReprestamoState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  DateTime? _preferDate(String? current, DateTime? previous) {
    final parsed = DateTime.tryParse(current ?? '');
    return parsed ?? previous;
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';

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
      ..proveedorArticulo = comprasPorProveedor.proveedorArticulo;

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
