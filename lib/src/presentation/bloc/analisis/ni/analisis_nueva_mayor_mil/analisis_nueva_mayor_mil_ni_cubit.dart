import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/analisis/nueva_mayor_a_mil_autosave.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_activo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_ciclo_compras_semanales_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_ciclo_venta_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_compras_proveedor_articulo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_costo_de_personal_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_cuentas_por_cobrar_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_ingresos_familiares_fuera_negocio_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_inventario_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_nivel_produccion_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/nueva_mayor_mil/analisis_nueva_mayor_a_mil_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_otros_credito_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_pasivo_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_nueva_mayor_mil_ni_state.dart';

class AnalisisNuevaMayorMilNiCubit extends Cubit<AnalisisNuevaMayorMilNiState> {
  final AnalisisFormsRepositoryNi _repository;
  late final NuevaMayorAMilAutosaveHN autoSaveHelper;
  final AnalisisBoxServiceHn localDbProvider;

  AnalisisNuevaMayorMilNiCubit(
    this._repository,
    this.localDbProvider,
  ) : super(AnalisisNuevaMayorMilHnInitial());

  Future<void> createAnalisisNuevaMayorMil({
    required int numeroSolicitud,
  }) async {
    final semanas = getcomprasSemanasMensuales();
    final dias = getCicloVentasDiarios();
    final incobrablesxCobrar = global<ObjectBoxService>()
        .getParametroByName(nombre: 'INCOBRABLESDECXCOBRAR');
    final totalIngresosAnual =
        state.cicloVentaMensual.ciclo.fold(0, (sum, e) => sum + e.venta);
    final totalIngresosFueraNegocio = state.ingeresosFamilaresFueraNegocio
        .fold(0, (sum, e) => sum + e.ingresosFamiliaresFueraNegocio);
    final totalPasivos = state.pasivos.fold(0, (sum, e) => sum + e.monto);
    final otrosCreditos =
        state.otrosCreditos.fold(0, (sum, e) => sum + e.monto);
    final totalInventario =
        state.inventario.fold(0, (sum, element) => sum + element.total);
    final totalClientes = state.cuentasPorCobrar
        .fold(0, (sum, element) => sum + element.totalMensualCredito);
    final totalCuentasxCobrar = state.cuentasPorCobrar
        .fold(0, (sum, element) => sum + element.totalMensualCredito);
    final incobrables = totalCuentasxCobrar.toDouble() *
        (double.tryParse(incobrablesxCobrar?.valor ?? '0') ?? 0);
    final totalActivosFijos = state.activos.fold(0, (sum, e) => sum + e.monto);
    final totalActivos = (totalActivosFijos +
        (totalClientes -
            incobrables +
            state.adelantoProveedores +
            state.caja +
            state.reservas +
            state.cuentasAhorro +
            totalInventario));
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
    final nivelProduccion = state.nivelProduccion.fold(
      0,
      (sum, e) => sum + e.totalMensualProduccion,
    );
    final ventasDeContado = nivelProduccion > 0
        ? (totalVentasMensuales + totalVentasDiarias + nivelProduccion) / 3
        : (totalVentasMensuales + totalVentasDiarias + nivelProduccion) / 2;
    final recuperaciones = state.cuentasPorCobrar.fold(
      0,
      (total, e) => total + e.abonoCredito,
    );
    final porcentajeDeVenta = state.inventario.isEmpty
        ? 0.0.toSafeString(2)
        : (state.inventario.fold<double>(
                  0.0,
                  (sum, e) => sum + e.costoVentaPorcentaje,
                ) /
                state.inventario.length)
            .toSafeString(2);

    final totalIngresos = (ventasDeContado + recuperaciones).round();

    final utilidadBruta =
        (totalIngresos - (totalIngresos * double.parse(porcentajeDeVenta)));
    final subContratos =
        state.costoDePersonal.fold(0, (sum, e) => sum + e.salarioMensual);

    final totalCostosOperativos = subContratos +
        state.gastosPersonalAlimentacion +
        state.alquilerlocal +
        state.agua +
        state.combustible +
        state.transporte +
        state.pagoCuotaCredito +
        state.impuesto +
        state.otros;
    final resultadoLiquido = utilidadBruta - totalCostosOperativos;
    final totalConsumoFamiliar = state.alimentacionFam +
        state.educacionFam +
        state.aguaFam +
        state.alquilerFam +
        state.aseoLimpiezaFam +
        state.vestimentaCalzadoFam +
        state.transporteFam +
        state.otrosGastosFam +
        state.pagoCreditosFam;
    final ingresosFueraDeNegocio = state.ingeresosFamilaresFueraNegocio
        .fold(0, (sum, e) => sum + e.ingresosFamiliaresFueraNegocio);

    final saldoDisponibleUnidadFamiliar =
        resultadoLiquido - totalConsumoFamiliar + ingresosFueraDeNegocio;

    final nivelProduccionVentaMensual = state.nivelProduccion
        .fold<double>(0, (sum, e) => sum + e.totalMensualProduccion);

    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createAnalisisNuevaMayorMil(
        analisisSolicitudNuevaMenor: AnalisisNuevaMayorMilHn(
          database: state.database,
          numeroSolicitud: numeroSolicitud,
          totalIngresosFueraNegocio: totalIngresosFueraNegocio,
          alimentacionFam: state.alimentacionFam,
          educacionFam: state.educacionFam,
          aguaFam: state.aguaFam,
          alquilerFam: state.alquilerFam,
          aseoLimpiezaFam: state.aseoLimpiezaFam,
          vestimentaCalzadoFam: state.vestimentaCalzadoFam,
          transporteFam: state.transporteFam,
          otrosGastosFam: state.otrosGastosFam,
          pagoCreditosFam: state.pagoCreditosFam,
          totalConsumoFamiliar: totalConsumoFamiliar,
          numeroLicencia: state.numeroLicencia,
          nombreInstitucionLicencia: state.nombreInstitucionLicencia,
          fechaEmisionLicencia: DateTime.tryParse(state.fechaEmisionLicencia),
          fechaVencimientoLicencia:
              DateTime.tryParse(state.fechaVencimientoLicencia),
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
          aniosConocerReferido2: state.aniosConocerReferido2.toInt(),
          parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
          resultadoVerificacion2: state.resultadoVerificacion2,
          semanasBuenas: semanas['semanasBuenas'],
          semanasNormales: semanas['semanasNormales'],
          semanasMalas: semanas['semanasMalas'],
          totalComprasMensuales: state.cicloDeComprasSemanales.cicloCompra
              .fold(0, (sum, e) => sum + e.cantidadCompra),
          totalVentasSegunCompras: nivelProduccionVentaMensual,
          totalCostoPersonal: state.totalCostoPersonal,
          totalUltimaCompra: state.totalUltimaCompra,
          diasBuenosVenta: dias['diasBuenos'],
          diasNormalesVenta: dias['diasNormales'],
          diasMalosVenta: dias['diasMalos'],
          totalVentasDiarias: totalVentasDiarias,
          totalVentasMensuales: totalVentasMensuales,
          totalAbono:
              state.cuentasPorCobrar.fold(0, (sum, e) => sum + e.abonoCredito),
          totalVentasMensualSegunNumClientes:
              state.totalVentasMensualSegunNumClientes,
          totalVentasSegunNivelProduccion: nivelProduccion,
          porcentajeProdAltaRotacion: state.porcentajeProdAltaRotacion,
          valorAltaRotacion: state.valorAltaRotacion,
          porcentajeProdBajaRotacion: state.porcentajeProdBajaRotacion,
          valorBajaRotacion: state.valorBajaRotacion,
          caja: state.caja,
          reservas: state.reservas,
          cuentasAhorro: state.cuentasAhorro,
          totalDisponibleActivo:
              (state.caja + state.reservas + state.cuentasAhorro),
          incobrables: incobrables,
          totalClientes: totalClientes,
          adelantoProveedores: state.adelantoProveedores,
          totalCuentasXCobrar:
              (totalClientes - incobrables + state.adelantoProveedores),
          totalInventario: totalInventario,
          totalActivosCorrientes: (totalClientes -
              incobrables +
              state.adelantoProveedores +
              state.caja +
              state.reservas +
              state.cuentasAhorro +
              totalInventario),
          totalActivosFijos: totalActivosFijos,
          totalActivos: totalActivos,
          totalProveedoresAdelantos: totalPasivos,
          totalCreditosInstAmigos: otrosCreditos,
          totalPasivos: (totalPasivos + otrosCreditos),
          patrimonio: (totalActivos - (totalPasivos + otrosCreditos)),
          pasivosMasPatrimonio: ((totalPasivos + otrosCreditos) +
              (totalActivos - (totalPasivos + otrosCreditos))),
          ventasContado: ventasDeContado,
          recuperaciones: recuperaciones,
          totalIngresos: totalIngresos,
          costoVentaProduccion: state.nivelProduccion.fold(
            0,
            (sum, e) => sum + e.totalMensualProduccion,
          ),
          utilidadBruta: utilidadBruta,
          gastosPersonalAlimentacion: state.gastosPersonalAlimentacion,
          subContratos: subContratos,
          alquilerlocal: state.alquilerlocal,
          agua: state.agua,
          combustible: state.combustible,
          transporte: state.transporte,
          pagoCuotaCredito: state.pagoCuotaCredito,
          impuesto: state.impuesto,
          otros: state.otros,
          totalCostosOperativos: totalCostosOperativos,
          resultadoLiquido: resultadoLiquido,
          consumoFamiliar: totalConsumoFamiliar,
          ingresosFueraNegocio: totalIngresosFueraNegocio.toDouble(),
          saldoDisponibleUf: saldoDisponibleUnidadFamiliar,
          costoVentaPorcentaje: state.inventario.fold(
                  0.0, (sum, element) => sum + (element.costoVentaPorcentaje)) /
              (state.inventario.length),
          fechaVerificacion3: state.fechaVerificacion3.isEmpty
              ? DateTime.now()
              : DateTime.parse(state.fechaVerificacion3),
          nombreReferencia3: state.nombreReferencia3,
          cedulaReferencia3: state.cedulaReferencia3,
          direccionReferencia3: state.direccionReferencia3,
          telefonoReferencia3: state.telefonoReferencia3,
          lugarTrabajoReferencia3: state.lugarTrabajoReferencia3,
          aniosConocerReferido3: state.aniosConocerReferido3,
          parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
          resultadoVerificacion3: state.resultadoVerificacion3,
          salud: state.salud,
          permisoOperacionNumero: state.permisoOperacionNumero,
          permisoOperacionNombreInstitucion:
              state.permisoOperacionNombreInstitucion,
          permisoOperacionFechaEmision:
              DateTime.tryParse(state.permisoOperacionFechaEmision),
          permisoOperacionFechaVencimiento:
              DateTime.tryParse(state.permisoOperacionFechaVencimiento),
          cicloVentaMensual: CicloVentaHN(
            totalVentasDiaria: state.cicloVentaMensual.ciclo.fold(
              0,
              (sum, e) => sum + e.venta.toInt(),
            ),
            ciclo: state.cicloVentaMensual.ciclo,
          ),
          cicloVentaDiaria: CicloVentaDiaria(
            totalVentasDiaria: state.cicloVentaDiaria.cicloVentas
                .fold(0, (sum, e) => sum + e.venta.toInt()),
            cicloVentas: state.cicloVentaDiaria.cicloVentas,
          ),
          nivelProduccion: state.nivelProduccion,
          cuentasPorCobrar: state.cuentasPorCobrar,
          cicloDeComprasSemanales: CicloDeComprasSemanalesHN(
            totalComprasMensualSemanal: state
                .cicloDeComprasSemanales.cicloCompra
                .fold(0, (sum, e) => sum + e.cantidadCompra),
            cicloCompra: state.cicloDeComprasSemanales.cicloCompra,
          ),
          comprasProveedorArticulo: state.comprasProveedorArticulo,
          costoDePersonal: state.costoDePersonal,
          ingeresosFamilaresFueraNegocio: state.ingeresosFamilaresFueraNegocio,
          otrosCreditos: state.otrosCreditos,
          pasivos: state.pasivos,
          activos: state.activos,
          inventario: state.inventario,
          objEmpleadoVerificaReferenciaID1:
              state.objEmpleadoVerificaReferenciaID1,
          objEmpleadoVerificaReferenciaID2:
              state.objEmpleadoVerificaReferenciaID2,
          objEmpleadoVerificaReferenciaID3:
              state.objEmpleadoVerificaReferenciaID3,
        ),
      );
      emit(state.copyWith(
        status: Status.done,
      ));
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
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid, numeroSolicitud: numeroSolicitud));

    autoSaveHelper = NuevaMayorAMilAutosaveHN(
      box: localDbProvider.analisisNuevaMayorAMilHnLocalDb,
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

  AnalisisNuevaMayorAMilHnLocalDb _buildModel(
    AnalisisNuevaMayorAMilHnLocalDb? existing,
  ) {
    final prev = existing;

    return AnalisisNuevaMayorAMilHnLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      cedulaReferencia1: state.cedulaReferencia1,
      cedulaReferencia2: state.cedulaReferencia2,
      cedulaReferencia3: state.cedulaReferencia3,
      cliente1: state.cliente1,
      cliente2: state.cliente2,
      cliente3: state.cliente3,
      database: state.database,
      direccionReferencia1: state.direccionReferencia1,
      direccionReferencia2: state.direccionReferencia2,
      direccionReferencia3: state.direccionReferencia3,
      lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
      lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
      lugarTrabajoReferencia3: state.lugarTrabajoReferencia3,
      nombreInstitucionLicencia: state.nombreInstitucionLicencia,
      nombreReferencia1: state.nombreReferencia1,
      nombreReferencia2: state.nombreReferencia2,
      nombreReferencia3: state.nombreReferencia3,
      numeroLicencia: state.numeroLicencia,
      parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
      parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
      parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
      permisoOperacionNombreInstitucion:
          state.permisoOperacionNombreInstitucion,
      permisoOperacionNumero: state.permisoOperacionNumero,
      proveedor1: state.proveedor1,
      proveedor2: state.proveedor2,
      proveedor3: state.proveedor3,
      resultadoVerificacion1: state.resultadoVerificacion1,
      resultadoVerificacion2: state.resultadoVerificacion2,
      resultadoVerificacion3: state.resultadoVerificacion3,
      telefonoReferencia1: state.telefonoReferencia1,
      telefonoReferencia2: state.telefonoReferencia2,
      telefonoReferencia3: state.telefonoReferencia3,
      objEmpleadoVerificaReferenciaID1: state.objEmpleadoVerificaReferenciaID1,
      objEmpleadoVerificaReferenciaID2: state.objEmpleadoVerificaReferenciaID2,
      objEmpleadoVerificaReferenciaID3: state.objEmpleadoVerificaReferenciaID3,
      fechaEmisionLicencia: DateTime.tryParse(state.fechaEmisionLicencia),
      fechaVencimientoLicencia:
          DateTime.tryParse(state.fechaVencimientoLicencia),
      fechaVerificacion1: DateTime.tryParse(state.fechaVerificacion1),
      fechaVerificacion2: DateTime.tryParse(state.fechaVerificacion2),
      fechaVerificacion3: DateTime.tryParse(state.fechaVerificacion3),
      permisoOperacionFechaEmision:
          DateTime.tryParse(state.permisoOperacionFechaEmision),
      permisoOperacionFechaVencimiento:
          DateTime.tryParse(state.permisoOperacionFechaVencimiento),
      adelantoProveedores: state.adelantoProveedores,
      cuentasAhorro: state.cuentasAhorro,
      agua: state.agua,
      combustible: state.combustible,
      gastosPersonalAlimentacion: state.gastosPersonalAlimentacion,
      aguaFam: state.aguaFam,
      alquilerFam: state.alquilerFam,
      aseoLimpiezaFam: state.aseoLimpiezaFam,
      ventasContado: state.ventasContado,
      recuperaciones: state.recuperaciones,
      alimentacionFam: state.alimentacionFam,
      educacionFam: state.educacionFam,
      transporteFam: state.transporteFam,
      otrosGastosFam: state.otrosGastosFam,
      pagoCreditosFam: state.pagoCreditosFam,
      alquilerlocal: state.alquilerlocal,
      aniosConocerReferido1: state.aniosConocerReferido1,
      aniosConocerReferido2: state.aniosConocerReferido2,
      aniosConocerReferido3: state.aniosConocerReferido3,
      caja: state.caja,
      reservas: state.reservas,
      consumoFamiliar: state.consumoFamiliar,
      costoVentaPorcentaje: state.costoVentaPorcentaje,
      costoVentaProduccion: state.costoVentaProduccion,
      diasBuenosVenta: state.diasBuenosVenta,
      diasNormalesVenta: state.diasNormalesVenta,
      diasMalosVenta: state.diasMalosVenta,
      impuesto: state.impuesto,
      incobrables: state.incobrables,
      ingresoAnual: state.ingresoAnual,
      ingresosFueraNegocio: state.ingresosFueraNegocio,
      otros: state.otros,
      pagoCuotaCredito: state.pagoCuotaCredito,
      pasivosMasPatrimonio: state.pasivosMasPatrimonio,
      patrimonio: state.patrimonio,
      resultadoLiquido: state.resultadoLiquido,
      saldoDisponibleUf: state.saldoDisponibleUf,
      porcentajeProdAltaRotacion: state.porcentajeProdAltaRotacion,
      porcentajeProdBajaRotacion: state.porcentajeProdBajaRotacion,
      salud: state.salud,
      semanasBuenas: state.semanasBuenas,
      semanasMalas: state.semanasMalas,
      semanasNormales: state.semanasNormales,
      totalCostoPersonal: state.totalCostoPersonal,
      totalCostosOperativos: state.totalCostosOperativos,
      totalCreditosInstAmigos: state.totalCreditosInstAmigos,
      subContratos: state.subContratos,
      totalAbono: state.totalAbono,
      totalActivos: state.totalActivos,
      totalActivosCorrientes: state.totalActivosCorrientes,
      totalActivosFijos: state.totalActivosFijos,
      totalClientes: state.totalClientes,
      totalComprasMensuales: state.totalComprasMensuales,
      totalConsumoFamiliar: state.totalConsumoFamiliar,
      totalCuentasXCobrar: state.totalCuentasXCobrar,
      totalDisponibleActivo: state.totalDisponibleActivo,
      totalIngresos: state.totalIngresos,
      totalIngresosFueraNegocio: state.totalIngresosFueraNegocio,
      totalInventario: state.totalInventario,
      totalPasivos: state.totalPasivos,
      totalProveedoresAdelantos: state.totalProveedoresAdelantos,
      totalVentasDiarias: state.totalVentasDiarias,
      totalVentasMensuales: state.totalVentasMensuales,
      totalVentasSegunCompras: state.totalVentasSegunCompras,
      totalUltimaCompra: state.totalUltimaCompra,
      totalVentasMensualSegunNumClientes:
          state.totalVentasMensualSegunNumClientes,
      totalVentasSegunNivelProduccion: state.totalVentasSegunNivelProduccion,
      transporte: state.transporte,
      utilidadBruta: state.utilidadBruta,
      valorAltaRotacion: state.valorAltaRotacion,
      valorBajaRotacion: state.valorBajaRotacion,
      vestimentaCalzadoFam: state.vestimentaCalzadoFam,
      numeroSolicitud: state.numeroSolicitud,
    );
  }

  void onFieldChanged(AnalisisNuevaMayorMilNiState Function() copyWithFn) {
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

  void loadFromLocalDb(AnalisisNuevaMayorAMilHnLocalDb? solicitud) {
    onFieldChanged(
      () => state.copyWith(
        valorAltaRotacion: solicitud?.valorAltaRotacion,
        valorBajaRotacion: solicitud?.valorBajaRotacion,
        porcentajeProdAltaRotacion: solicitud?.porcentajeProdAltaRotacion,
        permisoOperacionNumero: solicitud?.permisoOperacionNumero,
        numeroLicencia: solicitud?.numeroLicencia,
        nombreInstitucionLicencia: solicitud?.nombreInstitucionLicencia,
        adelantoProveedores: solicitud?.adelantoProveedores,
        agua: solicitud?.agua,
        aguaFam: solicitud?.aguaFam,
        alimentacionFam: solicitud?.alimentacionFam,
        alquilerFam: solicitud?.alquilerFam,
        aseoLimpiezaFam: solicitud?.aseoLimpiezaFam,
        alquilerlocal: solicitud?.alquilerlocal,
        aniosConocerReferido1: solicitud?.aniosConocerReferido1,
        aniosConocerReferido2: solicitud?.aniosConocerReferido2?.toDouble(),
        aniosConocerReferido3: solicitud?.aniosConocerReferido3,
        caja: solicitud?.caja,
        cedulaReferencia1: solicitud?.cedulaReferencia1,
        cedulaReferencia2: solicitud?.cedulaReferencia2,
        cedulaReferencia3: solicitud?.cedulaReferencia3,
        cliente1: solicitud?.cliente1,
        cliente2: solicitud?.cliente2,
        cliente3: solicitud?.cliente3,
        cuentasAhorro: solicitud?.cuentasAhorro,
        combustible: solicitud?.combustible,
        consumoFamiliar: solicitud?.consumoFamiliar,
        costoVentaPorcentaje: solicitud?.costoVentaPorcentaje,
        costoVentaProduccion: solicitud?.costoVentaProduccion,
        database: solicitud?.database,
        diasBuenosVenta: solicitud?.diasBuenosVenta,
        diasMalosVenta: solicitud?.diasMalosVenta,
        diasNormalesVenta: solicitud?.diasNormalesVenta,
        direccionReferencia1: solicitud?.direccionReferencia1,
        direccionReferencia2: solicitud?.direccionReferencia2,
        direccionReferencia3: solicitud?.direccionReferencia3,
        educacionFam: solicitud?.educacionFam,
        fechaEmisionLicencia:
            solicitud?.fechaEmisionLicencia?.toIso8601String(),
        fechaVencimientoLicencia:
            solicitud?.fechaVencimientoLicencia?.toIso8601String(),
        fechaVerificacion1: solicitud?.fechaVerificacion1?.toIso8601String(),
        fechaVerificacion2: solicitud?.fechaVerificacion2?.toIso8601String(),
        fechaVerificacion3: solicitud?.fechaVerificacion3?.toIso8601String(),
        gastosPersonalAlimentacion: solicitud?.gastosPersonalAlimentacion,
        impuesto: solicitud?.impuesto,
        incobrables: solicitud?.incobrables,
        ingresoAnual: solicitud?.ingresoAnual,
        nombreReferencia1: solicitud?.nombreReferencia1,
        nombreReferencia2: solicitud?.nombreReferencia2,
        nombreReferencia3: solicitud?.nombreReferencia3,
        ingresosFueraNegocio: solicitud?.ingresosFueraNegocio,
        lugarTrabajoReferencia1: solicitud?.lugarTrabajoReferencia1,
        lugarTrabajoReferencia2: solicitud?.lugarTrabajoReferencia2,
        lugarTrabajoReferencia3: solicitud?.lugarTrabajoReferencia3,
        otros: solicitud?.otros,
        otrosGastosFam: solicitud?.otrosGastosFam,
        pagoCreditosFam: solicitud?.pagoCreditosFam,
        pagoCuotaCredito: solicitud?.pagoCuotaCredito,
        pasivosMasPatrimonio: solicitud?.pasivosMasPatrimonio,
        parentescoReferenciaCodigo1: solicitud?.parentescoReferenciaCodigo1,
        parentescoReferenciaCodigo2: solicitud?.parentescoReferenciaCodigo2,
        parentescoReferenciaCodigo3: solicitud?.parentescoReferenciaCodigo3,
        patrimonio: solicitud?.patrimonio,
        permisoOperacionFechaEmision:
            solicitud?.permisoOperacionFechaEmision?.toIso8601String(),
        permisoOperacionFechaVencimiento:
            solicitud?.permisoOperacionFechaVencimiento?.toIso8601String(),
        permisoOperacionNombreInstitucion:
            solicitud?.permisoOperacionNombreInstitucion,
        porcentajeProdBajaRotacion: solicitud?.porcentajeProdBajaRotacion,
        proveedor1: solicitud?.proveedor1,
        proveedor2: solicitud?.proveedor2,
        proveedor3: solicitud?.proveedor3,
        resultadoLiquido: solicitud?.resultadoLiquido,
        resultadoVerificacion1: solicitud?.resultadoVerificacion1,
        resultadoVerificacion2: solicitud?.resultadoVerificacion2,
        resultadoVerificacion3: solicitud?.resultadoVerificacion3,
        saldoDisponibleUf: solicitud?.saldoDisponibleUf,
        salud: solicitud?.salud,
        recuperaciones: solicitud?.recuperaciones,
        reservas: solicitud?.reservas,
        semanasBuenas: solicitud?.semanasBuenas,
        semanasMalas: solicitud?.semanasMalas,
        semanasNormales: solicitud?.semanasNormales,
        subContratos: solicitud?.subContratos,
        telefonoReferencia1: solicitud?.telefonoReferencia1,
        telefonoReferencia2: solicitud?.telefonoReferencia2,
        telefonoReferencia3: solicitud?.telefonoReferencia3,
        totalAbono: solicitud?.totalAbono,
        totalActivos: solicitud?.totalActivos,
        totalActivosCorrientes: solicitud?.totalActivosCorrientes,
        totalActivosFijos: solicitud?.totalActivosFijos,
        totalClientes: solicitud?.totalClientes,
        totalCreditosInstAmigos: solicitud?.totalCreditosInstAmigos,
        totalCuentasXCobrar: solicitud?.totalCuentasXCobrar,
        totalCostoPersonal: solicitud?.totalCostoPersonal,
        totalCostosOperativos: solicitud?.totalCostosOperativos,
        totalComprasMensuales: solicitud?.totalComprasMensuales,
        totalConsumoFamiliar: solicitud?.totalConsumoFamiliar,
        totalDisponibleActivo: solicitud?.totalDisponibleActivo,
        totalIngresos: solicitud?.totalIngresos,
        totalIngresosFueraNegocio: solicitud?.totalIngresosFueraNegocio,
        totalInventario: solicitud?.totalInventario,
        totalPasivos: solicitud?.totalPasivos,
        totalProveedoresAdelantos: solicitud?.totalProveedoresAdelantos,
        totalUltimaCompra: solicitud?.totalUltimaCompra,
        totalVentasDiarias: solicitud?.totalVentasDiarias,
        totalVentasMensualSegunNumClientes:
            solicitud?.totalVentasMensualSegunNumClientes,
        totalVentasMensuales: solicitud?.totalVentasMensuales,
        totalVentasSegunCompras: solicitud?.totalVentasSegunCompras,
        totalVentasSegunNivelProduccion:
            solicitud?.totalVentasSegunNivelProduccion,
        transporte: solicitud?.transporte,
        transporteFam: solicitud?.transporteFam,
        utilidadBruta: solicitud?.utilidadBruta,
        ventasContado: solicitud?.ventasContado,
        vestimentaCalzadoFam: solicitud?.vestimentaCalzadoFam,
        objEmpleadoVerificaReferenciaID1:
            solicitud?.objEmpleadoVerificaReferenciaID1,
        objEmpleadoVerificaReferenciaID2:
            solicitud?.objEmpleadoVerificaReferenciaID2,
        objEmpleadoVerificaReferenciaID3:
            solicitud?.objEmpleadoVerificaReferenciaID3,
      ),
    );
  }

  loadVentasMensualesFromLocalDb({required CicloVentaHN cicloVenta}) {
    emit(
      state.copyWith(
        cicloVentaMensual: cicloVenta,
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

  saveCuentaPorCobrar({
    required CuentasPorCobrarHN cuentasPorCobrar,
    required int numeroSolicitud,
  }) {
    localDbProvider.cuentasPorCobrarHnBox.put(
      AnalisisCuentasPorCobrarHn(
        abonoCredito: cuentasPorCobrar.abonoCredito,
        frecuenciaAbonoCodigo: cuentasPorCobrar.frecuenciaAbonoCodigo,
        totalMensualCredito: cuentasPorCobrar.totalMensualCredito,
        nombre: cuentasPorCobrar.nombre,
        montoCredito: cuentasPorCobrar.montoCredito,
        uuid: cuentasPorCobrar.uuid,
        numeroSolicitud: numeroSolicitud,
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

  void deleteComprasPorProveedor({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisComprasProveedorArticuloHnLocalDb;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisComprasProveedorArticuloHnLocalDb_.uuid.equals(uuid) &
              AnalisisComprasProveedorArticuloHnLocalDb_.numeroSolicitud
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
        comprasProveedorArticulo: state.comprasProveedorArticulo
            .where((e) => e.uuid != uuid)
            .toList(),
      ),
    );
  }

  void deleteCostoPersonal({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisCostoDePersonalHnLocalDb;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisCostoDePersonalHnLocalDb_.uuid.equals(uuid) &
              AnalisisCostoDePersonalHnLocalDb_.numeroSolicitud
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
        costoDePersonal:
            state.costoDePersonal.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }

  void deleteInventario({
    required String uuid,
    required int numeroSolicitud,
  }) {
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

  void deletePasivo({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisPasivoHnLocalDb;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisPasivoHnLocalDb_.uuid.equals(uuid) &
              AnalisisPasivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
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
        pasivos: state.pasivos.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }

  void deleteOtroCredito({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisOtrosCreditoHnLocalDb;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisOtrosCreditoHnLocalDb_.uuid.equals(uuid) &
              AnalisisOtrosCreditoHnLocalDb_.numeroSolicitud
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
        otrosCreditos:
            state.otrosCreditos.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }

  void deleteIngresosFamiliaresFueraDelNegocio({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisIngresosFamiliaresFueraNegocioHnLocalDb;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisIngresosFamiliaresFueraNegocioHnLocalDb_.uuid.equals(uuid) &
              AnalisisIngresosFamiliaresFueraNegocioHnLocalDb_.numeroSolicitud
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
        ingeresosFamilaresFueraNegocio: state.ingeresosFamilaresFueraNegocio
            .where((e) => e.uuid != uuid)
            .toList(),
      ),
    );
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

  void updateCostoPersonal({
    required AnalisisCostoDePersonalHnLocalDb costoPersonal,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisCostoDePersonalHnLocalDb;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisCostoDePersonalHnLocalDb_.uuid.equals(costoPersonal.uuid!) &
              AnalisisCostoDePersonalHnLocalDb_.numeroSolicitud
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
      ..formaDePago = costoPersonal.formaDePago
      ..salarioMensual = costoPersonal.salarioMensual
      ..numeroEmpleado = costoPersonal.numeroEmpleado
      ..lugarProceso = costoPersonal.lugarProceso
      ..permanente = costoPersonal.permanente
      ..temporal = costoPersonal.temporal;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final comprasPorProveedorList = CostoDePersonalHN(
      formaDePago: costoPersonal.formaDePago ?? '',
      salarioMensual: costoPersonal.salarioMensual ?? 0,
      numeroEmpleado: costoPersonal.numeroEmpleado ?? 0,
      lugarProceso: costoPersonal.lugarProceso ?? '',
      permanente: costoPersonal.permanente ?? false,
      temporal: costoPersonal.temporal ?? false,
      uuid: costoPersonal.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        costoDePersonal: state.costoDePersonal
            .map((e) =>
                e.uuid == costoPersonal.uuid ? comprasPorProveedorList : e)
            .toList(),
      ),
    );
  }

  void updateIngresosFamiliaresFueraDelNegocio({
    required AnalisisIngresosFamiliaresFueraNegocioHnLocalDb
        ingresosFamiliaresFueraNegocio,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisIngresosFamiliaresFueraNegocioHnLocalDb;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisIngresosFamiliaresFueraNegocioHnLocalDb_.uuid
                  .equals(ingresosFamiliaresFueraNegocio.uuid!) &
              AnalisisIngresosFamiliaresFueraNegocioHnLocalDb_.numeroSolicitud
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
      ..fuenteOtrosIngresosFamiliar =
          ingresosFamiliaresFueraNegocio.fuenteOtrosIngresosFamiliar
      ..ingresosFamiliaresFueraNegocio =
          ingresosFamiliaresFueraNegocio.ingresosFamiliaresFueraNegocio;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final comprasPorProveedorList = IngresosFamilaresFueraNegocioHN(
      fuenteOtrosIngresosFamiliar:
          ingresosFamiliaresFueraNegocio.fuenteOtrosIngresosFamiliar ?? '',
      ingresosFamiliaresFueraNegocio:
          ingresosFamiliaresFueraNegocio.ingresosFamiliaresFueraNegocio ?? 0,
      uuid: ingresosFamiliaresFueraNegocio.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        ingeresosFamilaresFueraNegocio: state.ingeresosFamilaresFueraNegocio
            .map((e) => e.uuid == ingresosFamiliaresFueraNegocio.uuid
                ? comprasPorProveedorList
                : e)
            .toList(),
      ),
    );
  }

  void updateInventario({
    required AnalisisInventarioHnLocalDb inventario,
    required int numeroSolicitud,
  }) {
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

  void updateActivosFijos({
    required AnalisisActivoHnLocalDb activo,
    required int numeroSolicitud,
  }) {
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

  void updatePasivosFijos({
    required AnalisisPasivoHnLocalDb pasivo,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisPasivoHnLocalDb;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisPasivoHnLocalDb_.uuid.equals(pasivo.uuid!) &
              AnalisisPasivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud),
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
      ..nombreProveedores = pasivo.nombreProveedores
      ..monto = pasivo.monto;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final pasivoUpdated = PasivoHN(
      nombreProveedores: pasivo.nombreProveedores ?? '',
      monto: pasivo.monto ?? 0,
      uuid: pasivo.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        pasivos: state.pasivos
            .map((e) => e.uuid == pasivo.uuid ? pasivoUpdated : e)
            .toList(),
      ),
    );
  }

  void updateOtrosCredito({
    required AnalisisOtrosCreditoHnLocalDb pasivo,
    required int numeroSolicitud,
  }) {
    final box = localDbProvider.analisisOtrosCreditoHnLocalDb;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisOtrosCreditoHnLocalDb_.uuid.equals(pasivo.uuid!) &
              AnalisisOtrosCreditoHnLocalDb_.numeroSolicitud
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
      ..nombreOtrosCreditos = pasivo.nombreOtrosCreditos
      ..monto = pasivo.monto;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final otrosCrditosUpdated = OtrosCreditoHN(
      monto: pasivo.monto ?? 0,
      nombreOtrosCreditos: pasivo.nombreOtrosCreditos ?? '',
      uuid: pasivo.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        otrosCreditos: state.otrosCreditos
            .map((e) => e.uuid == pasivo.uuid ? otrosCrditosUpdated : e)
            .toList(),
      ),
    );
  }

  saveCostoPersonal({
    required CostoDePersonalHN costoDePersonal,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.analisisCostoDePersonalHnLocalDb.put(
      AnalisisCostoDePersonalHnLocalDb(
        formaDePago: costoDePersonal.formaDePago,
        salarioMensual: costoDePersonal.salarioMensual,
        numeroEmpleado: costoDePersonal.numeroEmpleado,
        lugarProceso: costoDePersonal.lugarProceso,
        permanente: costoDePersonal.permanente,
        temporal: costoDePersonal.temporal,
        uuid: costoDePersonal.uuid,
        numeroSolicitud: numeroSolicitud,
      ),
    );
    emit(
      state.copyWith(
        costoDePersonal: [
          ...state.costoDePersonal,
          costoDePersonal,
        ],
      ),
    );
  }

  saveIngresosFamiliaresFueraDelNegocio({
    required IngresosFamilaresFueraNegocioHN ingresosFamiliaresFueraNegocio,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.analisisIngresosFamiliaresFueraNegocioHnLocalDb.put(
      AnalisisIngresosFamiliaresFueraNegocioHnLocalDb(
        fuenteOtrosIngresosFamiliar:
            ingresosFamiliaresFueraNegocio.fuenteOtrosIngresosFamiliar,
        ingresosFamiliaresFueraNegocio:
            ingresosFamiliaresFueraNegocio.ingresosFamiliaresFueraNegocio,
        uuid: ingresosFamiliaresFueraNegocio.uuid,
        numeroSolicitud: numeroSolicitud,
      ),
    );
    emit(
      state.copyWith(
        ingeresosFamilaresFueraNegocio: [
          ...state.ingeresosFamilaresFueraNegocio,
          ingresosFamiliaresFueraNegocio,
        ],
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

  saveOtrosCredito({
    required OtrosCreditoHN otroCredito,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.analisisOtrosCreditoHnLocalDb.put(
      AnalisisOtrosCreditoHnLocalDb(
        nombreOtrosCreditos: otroCredito.nombreOtrosCreditos,
        monto: otroCredito.monto,
        uuid: otroCredito.uuid,
        numeroSolicitud: numeroSolicitud,
      ),
    );
    emit(
      state.copyWith(
        otrosCreditos: [
          ...state.otrosCreditos,
          otroCredito,
        ],
      ),
    );
  }

  savePasivo({
    required PasivoHN pasivo,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.analisisPasivoHnLocalDb.put(
      AnalisisPasivoHnLocalDb(
        nombreProveedores: pasivo.nombreProveedores,
        monto: pasivo.monto,
        uuid: pasivo.uuid,
        numeroSolicitud: numeroSolicitud,
      ),
    );
    emit(
      state.copyWith(
        pasivos: [
          ...state.pasivos,
          pasivo,
        ],
      ),
    );
  }

  saveInventario({
    required InventarioHN inventario,
    required int numeroSolicitud,
  }) {
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
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      cuentasPorCobrar: cuentasPorCobrarList,
      totalClientes: cuentasPorCobrarList.fold(
        0,
        (sum, e) => (sum ?? 0) + e.totalMensualCredito,
      ),
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

  void loadCostoPersonalFromLocalDb({required int numeroSolicitud}) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final costoPersonalDb = localDbProvider.analisisCostoDePersonalHnLocalDb
        .query(AnalisisCostoDePersonalHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final costoPersonalList = costoPersonalDb
        .map((c) => CostoDePersonalHN(
              numeroEmpleado: c.numeroEmpleado ?? 0,
              lugarProceso: c.lugarProceso ?? '',
              permanente: c.permanente ?? false,
              temporal: c.temporal ?? false,
              formaDePago: c.formaDePago ?? '',
              salarioMensual: c.salarioMensual ?? 0,
              uuid: c.uuid ?? '',
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      costoDePersonal: costoPersonalList,
    ));
  }

  void loadNegocioFamiliarFueraNegocioFromLocalDb({
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final analisisIngresosFamiliaresFueraNegocioHnLocalDb = localDbProvider
        .analisisIngresosFamiliaresFueraNegocioHnLocalDb
        .query(AnalisisIngresosFamiliaresFueraNegocioHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final analisisIngresosFamiliaresList =
        analisisIngresosFamiliaresFueraNegocioHnLocalDb
            .map((c) => IngresosFamilaresFueraNegocioHN(
                  fuenteOtrosIngresosFamiliar:
                      c.fuenteOtrosIngresosFamiliar ?? '',
                  ingresosFamiliaresFueraNegocio:
                      c.ingresosFamiliaresFueraNegocio ?? 0,
                  uuid: c.uuid ?? '',
                ))
            .toList();

    // Actualizar el state
    emit(state.copyWith(
      ingeresosFamilaresFueraNegocio: analisisIngresosFamiliaresList,
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

  void loadPasivosFromLocalDb({
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final pasivosFijosDb = localDbProvider.analisisPasivoHnLocalDb
        .query(AnalisisPasivoHnLocalDb_.numeroSolicitud.equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final pasivosFijosList = pasivosFijosDb
        .map((c) => PasivoHN(
              nombreProveedores: c.nombreProveedores ?? '',
              monto: c.monto ?? 0,
              uuid: c.uuid ?? '',
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      pasivos: pasivosFijosList,
    ));
  }

  void loadOtrosCreditosFromLocalDb({
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final otrosCreditosDb = localDbProvider.analisisOtrosCreditoHnLocalDb
        .query(AnalisisOtrosCreditoHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final otrosCreditosList = otrosCreditosDb
        .map((c) => OtrosCreditoHN(
              nombreOtrosCreditos: c.nombreOtrosCreditos ?? '',
              monto: c.monto ?? 0,
              uuid: c.uuid ?? '',
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      otrosCreditos: otrosCreditosList,
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
