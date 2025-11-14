import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/analisis/nueva_mayor_a_mil_autosave.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_ciclo_venta_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_cuentas_por_cobrar_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_nivel_produccion_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_nueva_mayor_a_mil_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_nueva_mayor_mil_hn_state.dart';

class AnalisisNuevaMayorMilHnCubit extends Cubit<AnalisisNuevaMayorMilHnState> {
  final AnalisisRepositoryHn _repository;
  late final NuevaMayorAMilAutosaveHN autoSaveHelper;
  final AnalisisBoxServiceHn localDbProvider;

  AnalisisNuevaMayorMilHnCubit(
    this._repository,
    this.localDbProvider,
  ) : super(AnalisisNuevaMayorMilHnInitial());

  Future<void> createAnalisisNuevaMayorMil({
    required int numeroSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.createAnalisisNuevaMayorMil(
        analisisSolicitudNuevaMenor: AnalisisNuevaMayorMilHn(
          database: state.database,
          numeroSolicitud: numeroSolicitud,
          totalIngresosFueraNegocio: state.totalIngresosFueraNegocio,
          alimentacionFam: state.alimentacionFam,
          educacionFam: state.educacionFam,
          aguaFam: state.aguaFam,
          alquilerFam: state.alquilerFam,
          aseoLimpiezaFam: state.aseoLimpiezaFam,
          vestimentaCalzadoFam: state.vestimentaCalzadoFam,
          transporteFam: state.transporteFam,
          otrosGastosFam: state.otrosGastosFam,
          pagoCreditosFam: state.pagoCreditosFam,
          totalConsumoFamiliar: state.totalConsumoFamiliar,
          numeroLicencia: state.numeroLicencia,
          nombreInstitucionLicencia: state.nombreInstitucionLicencia,
          fechaEmisionLicencia: DateTime.tryParse(state.fechaEmisionLicencia),
          fechaVencimientoLicencia:
              DateTime.tryParse(state.fechaVencimientoLicencia),
          ingresoAnual: state.ingresoAnual,
          cliente1: state.cliente1,
          cliente2: state.cliente2,
          cliente3: state.cliente3,
          proveedor1: state.proveedor1,
          proveedor2: state.proveedor2,
          proveedor3: state.proveedor3,
          fechaVerificacion1: DateTime.tryParse(state.fechaVerificacion1),
          nombreReferencia1: state.nombreReferencia1,
          cedulaReferencia1: state.cedulaReferencia1,
          direccionReferencia1: state.direccionReferencia1,
          telefonoReferencia1: state.telefonoReferencia1,
          lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
          aniosConocerReferido1: state.aniosConocerReferido1,
          parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
          resultadoVerificacion1: state.resultadoVerificacion1,
          fechaVerificacion2: DateTime.tryParse(state.fechaVerificacion2),
          nombreReferencia2: state.nombreReferencia2,
          cedulaReferencia2: state.cedulaReferencia2,
          direccionReferencia2: state.direccionReferencia2,
          telefonoReferencia2: state.telefonoReferencia2,
          lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
          aniosConocerReferido2: state.aniosConocerReferido2.toInt(),
          parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
          resultadoVerificacion2: state.resultadoVerificacion2,
          semanasBuenas: state.semanasBuenas,
          semanasNormales: state.semanasNormales,
          semanasMalas: state.semanasMalas,
          totalComprasMensuales: state.totalComprasMensuales,
          totalVentasSegunCompras: state.totalVentasSegunCompras,
          totalCostoPersonal: state.totalCostoPersonal,
          totalUltimaCompra: state.totalUltimaCompra,
          diasBuenosVenta: state.diasBuenosVenta,
          diasNormalesVenta: state.diasNormalesVenta,
          diasMalosVenta: state.diasMalosVenta,
          totalVentasDiarias: state.totalVentasDiarias,
          totalVentasMensuales: state.totalVentasMensuales,
          totalAbono: state.totalAbono,
          totalVentasMensualSegunNumClientes:
              state.totalVentasMensualSegunNumClientes,
          totalVentasSegunNivelProduccion:
              state.totalVentasSegunNivelProduccion,
          porcentajeProdAltaRotacion: state.porcentajeProdAltaRotacion,
          valorAltaRotacion: state.valorAltaRotacion,
          porcentajeProdBajaRotacion: state.porcentajeProdBajaRotacion,
          valorBajaRotacion: state.valorBajaRotacion,
          caja: state.caja,
          reservas: state.reservas,
          cuentasAhorro: state.cuentasAhorro,
          totalDisponibleActivo: state.totalDisponibleActivo,
          incobrables: state.incobrables,
          totalClientes: state.totalClientes,
          adelantoProveedores: state.adelantoProveedores,
          totalCuentasXCobrar: state.totalCuentasXCobrar,
          totalInventario: state.totalInventario,
          totalActivosCorrientes: state.totalActivosCorrientes,
          totalActivosFijos: state.totalActivosFijos,
          totalActivos: state.totalActivos,
          totalProveedoresAdelantos: state.totalProveedoresAdelantos,
          totalCreditosInstAmigos: state.totalCreditosInstAmigos,
          totalPasivos: state.totalPasivos,
          patrimonio: state.patrimonio,
          pasivosMasPatrimonio: state.pasivosMasPatrimonio,
          ventasContado: state.ventasContado,
          recuperaciones: state.recuperaciones,
          totalIngresos: state.totalIngresos,
          costoVentaProduccion: state.costoVentaProduccion,
          utilidadBruta: state.utilidadBruta,
          gastosPersonalAlimentacion: state.gastosPersonalAlimentacion,
          subContratos: state.subContratos,
          alquilerlocal: state.alquilerlocal,
          agua: state.agua,
          combustible: state.combustible,
          transporte: state.transporte,
          pagoCuotaCredito: state.pagoCuotaCredito,
          impuesto: state.impuesto,
          otros: state.otros,
          totalCostosOperativos: state.totalCostosOperativos,
          resultadoLiquido: state.resultadoLiquido,
          consumoFamiliar: state.consumoFamiliar,
          ingresosFueraNegocio: state.ingresosFueraNegocio,
          saldoDisponibleUf: state.saldoDisponibleUf,
          costoVentaPorcentaje: state.costoVentaPorcentaje,
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
          permisoOperacionNumero: state.permisoOperacionNumero,
          permisoOperacionNombreInstitucion:
              state.permisoOperacionNombreInstitucion,
          permisoOperacionFechaEmision:
              DateTime.tryParse(state.permisoOperacionFechaEmision),
          permisoOperacionFechaVencimiento:
              DateTime.tryParse(state.permisoOperacionFechaVencimiento),
          cicloVentaMensual: state.cicloVentaMensual,
          cicloVentaDiaria: state.cicloVentaDiaria,
          nivelProduccion: state.nivelProduccion,
          cuentasPorCobrar: state.cuentasPorCobrar,
          cicloDeComprasSemanales: state.cicloDeComprasSemanales,
          comprasProveedorArticulo: state.comprasProveedorArticulo,
          costoDePersonal: state.costoDePersonal,
          ingeresosFamilaresFueraNegocio: state.ingeresosFamilaresFueraNegocio,
          otrosCreditos: state.otrosCreditos,
          pasivos: state.pasivos,
          activos: state.activos,
        ),
      );
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
      cedulaReferencia1:
          _prefer(state.cedulaReferencia1, prev?.cedulaReferencia1),
      cedulaReferencia2:
          _prefer(state.cedulaReferencia2, prev?.cedulaReferencia2),
      cedulaReferencia3:
          _prefer(state.cedulaReferencia3, prev?.cedulaReferencia3),
      cliente1: _prefer(state.cliente1, prev?.cliente1),
      cliente2: _prefer(state.cliente2, prev?.cliente2),
      cliente3: _prefer(state.cliente3, prev?.cliente3),
      database: _prefer(state.database, prev?.database),
      direccionReferencia1:
          _prefer(state.direccionReferencia1, prev?.direccionReferencia1),
      direccionReferencia2:
          _prefer(state.direccionReferencia2, prev?.direccionReferencia2),
      direccionReferencia3:
          _prefer(state.direccionReferencia3, prev?.direccionReferencia3),
      lugarTrabajoReferencia1:
          _prefer(state.lugarTrabajoReferencia1, prev?.lugarTrabajoReferencia1),
      lugarTrabajoReferencia2:
          _prefer(state.lugarTrabajoReferencia2, prev?.lugarTrabajoReferencia2),
      lugarTrabajoReferencia3:
          _prefer(state.lugarTrabajoReferencia3, prev?.lugarTrabajoReferencia3),
      nombreInstitucionLicencia: _prefer(
          state.nombreInstitucionLicencia, prev?.nombreInstitucionLicencia),
      nombreReferencia1:
          _prefer(state.nombreReferencia1, prev?.nombreReferencia1),
      nombreReferencia2:
          _prefer(state.nombreReferencia2, prev?.nombreReferencia2),
      nombreReferencia3:
          _prefer(state.nombreReferencia3, prev?.nombreReferencia3),
      numeroLicencia: _prefer(state.numeroLicencia, prev?.numeroLicencia),
      parentescoReferenciaCodigo1: _prefer(
          state.parentescoReferenciaCodigo1, prev?.parentescoReferenciaCodigo1),
      parentescoReferenciaCodigo2: _prefer(
          state.parentescoReferenciaCodigo2, prev?.parentescoReferenciaCodigo2),
      parentescoReferenciaCodigo3: _prefer(
          state.parentescoReferenciaCodigo3, prev?.parentescoReferenciaCodigo3),
      permisoOperacionNombreInstitucion: _prefer(
          state.permisoOperacionNombreInstitucion,
          prev?.permisoOperacionNombreInstitucion),
      permisoOperacionNumero:
          _prefer(state.permisoOperacionNumero, prev?.permisoOperacionNumero),
      proveedor1: _prefer(state.proveedor1, prev?.proveedor1),
      proveedor2: _prefer(state.proveedor2, prev?.proveedor2),
      proveedor3: _prefer(state.proveedor3, prev?.proveedor3),
      resultadoVerificacion1:
          _prefer(state.resultadoVerificacion1, prev?.resultadoVerificacion1),
      resultadoVerificacion2:
          _prefer(state.resultadoVerificacion2, prev?.resultadoVerificacion2),
      resultadoVerificacion3:
          _prefer(state.resultadoVerificacion3, prev?.resultadoVerificacion3),
      telefonoReferencia1:
          _prefer(state.telefonoReferencia1, prev?.telefonoReferencia1),
      telefonoReferencia2:
          _prefer(state.telefonoReferencia2, prev?.telefonoReferencia2),
      telefonoReferencia3:
          _prefer(state.telefonoReferencia3, prev?.telefonoReferencia3),
      fechaEmisionLicencia: _preferDate(
        state.fechaEmisionLicencia,
        prev?.fechaEmisionLicencia,
      ),
      fechaVencimientoLicencia: _preferDate(
        state.fechaVencimientoLicencia,
        prev?.fechaVencimientoLicencia,
      ),
      fechaVerificacion1: _preferDate(
        state.fechaVerificacion1,
        prev?.fechaVerificacion1,
      ),
      fechaVerificacion2: _preferDate(
        state.fechaVerificacion2,
        prev?.fechaVerificacion2,
      ),
      fechaVerificacion3: _preferDate(
        state.fechaVerificacion3,
        prev?.fechaVerificacion3,
      ),
      permisoOperacionFechaEmision: _preferDate(
        state.permisoOperacionFechaEmision,
        prev?.permisoOperacionFechaEmision,
      ),
      permisoOperacionFechaVencimiento: _preferDate(
        state.permisoOperacionFechaVencimiento,
        prev?.permisoOperacionFechaVencimiento,
      ),
      adelantoProveedores: state.adelantoProveedores == 0
          ? (prev?.adelantoProveedores ?? 0)
          : state.adelantoProveedores,
      cuentasAhorro: state.cuentasAhorro == 0
          ? (prev?.cuentasAhorro ?? 0)
          : state.cuentasAhorro,
      agua: state.agua == 0 ? (prev?.agua ?? 0) : state.agua,
      combustible:
          state.combustible == 0 ? (prev?.combustible ?? 0) : state.combustible,
      gastosPersonalAlimentacion: state.gastosPersonalAlimentacion == 0
          ? (prev?.gastosPersonalAlimentacion ?? 0)
          : state.gastosPersonalAlimentacion,
      aguaFam: state.aguaFam == 0 ? (prev?.aguaFam ?? 0) : state.aguaFam,
      alquilerFam:
          state.alquilerFam == 0 ? (prev?.alquilerFam ?? 0) : state.alquilerFam,
      aseoLimpiezaFam: state.aseoLimpiezaFam == 0
          ? (prev?.aseoLimpiezaFam ?? 0)
          : state.aseoLimpiezaFam,
      ventasContado: state.ventasContado == 0
          ? (prev?.ventasContado ?? 0)
          : state.ventasContado,
      recuperaciones: state.recuperaciones == 0
          ? (prev?.recuperaciones ?? 0)
          : state.recuperaciones,
      alimentacionFam: state.alimentacionFam == 0
          ? (prev?.alimentacionFam ?? 0)
          : state.alimentacionFam,
      educacionFam: state.educacionFam == 0
          ? (prev?.educacionFam ?? 0)
          : state.educacionFam,
      transporteFam: state.transporteFam == 0
          ? (prev?.transporteFam ?? 0)
          : state.transporteFam,
      otrosGastosFam: state.otrosGastosFam == 0
          ? (prev?.otrosGastosFam ?? 0)
          : state.otrosGastosFam,
      pagoCreditosFam: state.pagoCreditosFam == 0
          ? (prev?.pagoCreditosFam ?? 0)
          : state.pagoCreditosFam,
      alquilerlocal: state.alquilerlocal == 0
          ? (prev?.alquilerlocal ?? 0)
          : state.alquilerlocal,
      aniosConocerReferido1: state.aniosConocerReferido1 == 0
          ? (prev?.aniosConocerReferido1 ?? 0)
          : state.aniosConocerReferido1,
      aniosConocerReferido2: state.aniosConocerReferido2 == 0
          ? (prev?.aniosConocerReferido2 ?? 0)
          : state.aniosConocerReferido2,
      aniosConocerReferido3: state.aniosConocerReferido3 == 0
          ? (prev?.aniosConocerReferido3 ?? 0)
          : state.aniosConocerReferido3,
      caja: state.caja == 0 ? (prev?.caja ?? 0) : state.caja,
      reservas: state.reservas == 0 ? (prev?.reservas ?? 0) : state.reservas,
      consumoFamiliar: state.consumoFamiliar == 0
          ? (prev?.consumoFamiliar ?? 0)
          : state.consumoFamiliar,
      costoVentaPorcentaje: state.costoVentaPorcentaje == 0
          ? (prev?.costoVentaPorcentaje ?? 0)
          : state.costoVentaPorcentaje,
      costoVentaProduccion: state.costoVentaProduccion == 0
          ? (prev?.costoVentaProduccion ?? 0)
          : state.costoVentaProduccion,
      diasBuenosVenta: state.diasBuenosVenta == 0
          ? (prev?.diasBuenosVenta ?? 0)
          : state.diasBuenosVenta,
      diasNormalesVenta: state.diasNormalesVenta == 0
          ? (prev?.diasNormalesVenta ?? 0)
          : state.diasNormalesVenta,
      diasMalosVenta: state.diasMalosVenta == 0
          ? (prev?.diasMalosVenta ?? 0)
          : state.diasMalosVenta,
      impuesto: state.impuesto == 0 ? (prev?.impuesto ?? 0) : state.impuesto,
      incobrables:
          state.incobrables == 0 ? (prev?.incobrables ?? 0) : state.incobrables,
      ingresoAnual: state.ingresoAnual == 0
          ? (prev?.ingresoAnual ?? 0)
          : state.ingresoAnual,
      ingresosFueraNegocio: state.ingresosFueraNegocio == 0
          ? (prev?.ingresosFueraNegocio ?? 0)
          : state.ingresosFueraNegocio,
      otros: state.otros == 0 ? (prev?.otros ?? 0) : state.otros,
      pagoCuotaCredito: state.pagoCuotaCredito == 0
          ? (prev?.pagoCuotaCredito ?? 0)
          : state.pagoCuotaCredito,
      pasivosMasPatrimonio: state.pasivosMasPatrimonio == 0
          ? (prev?.pasivosMasPatrimonio ?? 0)
          : state.pasivosMasPatrimonio,
      patrimonio:
          state.patrimonio == 0 ? (prev?.patrimonio ?? 0) : state.patrimonio,
      resultadoLiquido: state.resultadoLiquido == 0
          ? (prev?.resultadoLiquido ?? 0)
          : state.resultadoLiquido,
      saldoDisponibleUf: state.saldoDisponibleUf == 0
          ? (prev?.saldoDisponibleUf ?? 0)
          : state.saldoDisponibleUf,
      porcentajeProdAltaRotacion: state.porcentajeProdAltaRotacion == 0
          ? (prev?.porcentajeProdAltaRotacion ?? 0)
          : state.porcentajeProdAltaRotacion,
      porcentajeProdBajaRotacion: state.porcentajeProdBajaRotacion == 0
          ? (prev?.porcentajeProdBajaRotacion ?? 0)
          : state.porcentajeProdBajaRotacion,
      salud: state.salud == 0 ? (prev?.salud ?? 0) : state.salud,
      semanasBuenas: state.semanasBuenas == 0
          ? (prev?.semanasBuenas ?? 0)
          : state.semanasBuenas,
      semanasMalas: state.semanasMalas == 0
          ? (prev?.semanasMalas ?? 0)
          : state.semanasMalas,
      semanasNormales: state.semanasNormales == 0
          ? (prev?.semanasNormales ?? 0)
          : state.semanasNormales,
      totalCostoPersonal: state.totalCostoPersonal == 0
          ? (prev?.totalCostoPersonal ?? 0)
          : state.totalCostoPersonal,
      totalCostosOperativos: state.totalCostosOperativos == 0
          ? (prev?.totalCostosOperativos ?? 0)
          : state.totalCostosOperativos,
      totalCreditosInstAmigos: state.totalCreditosInstAmigos == 0
          ? (prev?.totalCreditosInstAmigos ?? 0)
          : state.totalCreditosInstAmigos,
      subContratos: state.subContratos == 0
          ? (prev?.subContratos ?? 0)
          : state.subContratos,
      totalAbono:
          state.totalAbono == 0 ? (prev?.totalAbono ?? 0) : state.totalAbono,
      totalActivos: state.totalActivos == 0
          ? (prev?.totalActivos ?? 0)
          : state.totalActivos,
      totalActivosCorrientes: state.totalActivosCorrientes == 0
          ? (prev?.totalActivosCorrientes ?? 0)
          : state.totalActivosCorrientes,
      totalActivosFijos: state.totalActivosFijos == 0
          ? (prev?.totalActivosFijos ?? 0)
          : state.totalActivosFijos,
      totalClientes: state.totalClientes == 0
          ? (prev?.totalClientes ?? 0)
          : state.totalClientes,
      totalComprasMensuales: state.totalComprasMensuales == 0
          ? (prev?.totalComprasMensuales ?? 0)
          : state.totalComprasMensuales,
      totalConsumoFamiliar: state.totalConsumoFamiliar == 0
          ? (prev?.totalConsumoFamiliar ?? 0)
          : state.totalConsumoFamiliar,
      totalCuentasXCobrar: state.totalCuentasXCobrar == 0
          ? (prev?.totalCuentasXCobrar ?? 0)
          : state.totalCuentasXCobrar,
      totalDisponibleActivo: state.totalDisponibleActivo == 0
          ? (prev?.totalDisponibleActivo ?? 0)
          : state.totalDisponibleActivo,
      totalIngresos: state.totalIngresos == 0
          ? (prev?.totalIngresos ?? 0)
          : state.totalIngresos,
      totalIngresosFueraNegocio: state.totalIngresosFueraNegocio == 0
          ? (prev?.totalIngresosFueraNegocio ?? 0)
          : state.totalIngresosFueraNegocio,
      totalInventario: state.totalInventario == 0
          ? (prev?.totalInventario ?? 0)
          : state.totalInventario,
      totalPasivos: state.totalPasivos == 0
          ? (prev?.totalPasivos ?? 0)
          : state.totalPasivos,
      totalProveedoresAdelantos: state.totalProveedoresAdelantos == 0
          ? (prev?.totalProveedoresAdelantos ?? 0)
          : state.totalProveedoresAdelantos,
      totalVentasDiarias: state.totalVentasDiarias == 0
          ? (prev?.totalVentasDiarias ?? 0)
          : state.totalVentasDiarias,
      totalVentasMensuales: state.totalVentasMensuales == 0
          ? (prev?.totalVentasMensuales ?? 0)
          : state.totalVentasMensuales,
      totalVentasSegunCompras: state.totalVentasSegunCompras == 0
          ? (prev?.totalVentasSegunCompras ?? 0)
          : state.totalVentasSegunCompras,
      totalUltimaCompra: state.totalUltimaCompra == 0
          ? (prev?.totalUltimaCompra ?? 0)
          : state.totalUltimaCompra,
      totalVentasMensualSegunNumClientes:
          state.totalVentasMensualSegunNumClientes == 0
              ? (prev?.totalVentasMensualSegunNumClientes ?? 0)
              : state.totalVentasMensualSegunNumClientes,
      totalVentasSegunNivelProduccion:
          state.totalVentasSegunNivelProduccion == 0
              ? (prev?.totalVentasSegunNivelProduccion ?? 0)
              : state.totalVentasSegunNivelProduccion,
      transporte:
          state.transporte == 0 ? (prev?.transporte ?? 0) : state.transporte,
      utilidadBruta: state.utilidadBruta == 0
          ? (prev?.utilidadBruta ?? 0)
          : state.utilidadBruta,
      valorAltaRotacion: state.valorAltaRotacion == 0
          ? (prev?.valorAltaRotacion ?? 0)
          : state.valorAltaRotacion,
      valorBajaRotacion: state.valorBajaRotacion == 0
          ? (prev?.valorBajaRotacion ?? 0)
          : state.valorBajaRotacion,
      vestimentaCalzadoFam: state.vestimentaCalzadoFam == 0
          ? (prev?.vestimentaCalzadoFam ?? 0)
          : state.vestimentaCalzadoFam,
      numeroSolicitud: state.numeroSolicitud == 0
          ? (prev?.numeroSolicitud ?? 0)
          : state.numeroSolicitud,
    );
  }

  void onFieldChanged(AnalisisNuevaMayorMilHnState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';
  DateTime? _preferDate(String? current, DateTime? previous) {
    final parsed = DateTime.tryParse(current ?? '');
    return parsed ?? previous;
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
          totalVentasDiaria: 0,
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
      ].map((mes) => Ciclo(mes: mes, venta: 0, valorizacion: 'N/A')).toList();

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
        cicloVentaMensual:
            CicloVentaHN(totalVentasDiaria: 0, ciclo: defaultCiclo),
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
          totalVentasDiaria: 0,
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
        'Miércoles',
        'Jueves',
        'Viernes',
        'Sábado',
        'Domingo',
      ]
          .map((dia) => CicloVenta(
              dia: dia, venta: 0, valorizacion: 'N/A', maquinaCreacion: ''))
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
          totalVentasDiaria: updatedCiclo.fold(0, (sum, e) => sum + e.venta),
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
          totalVentasDiaria: updatedCiclo.fold(0, (sum, e) => sum + e.venta),
          cicloVentas: updatedCiclo,
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
    final mesNormal = uniqueCiclos[uniqueCiclos.length ~/ 2];
    final mesMalo = uniqueCiclos.last;

    return {
      'mesBueno': mesBueno.venta,
      'mesNormal': mesNormal.venta,
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
    final diasNormales = uniqueCiclos[uniqueCiclos.length ~/ 2];
    final diasMalos = uniqueCiclos.last;

    return {
      'diasBuenos': diasBuenos.venta,
      'diasNormales': diasNormales.venta,
      'diasMalos': diasMalos.venta,
    };
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
        uuid: const Uuid().v4(),
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
        uuid: const Uuid().v4(),
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
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      cuentasPorCobrar: cuentasPorCobrarList,
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
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      nivelProduccion: nivelProduccionList,
    ));
  }
}
