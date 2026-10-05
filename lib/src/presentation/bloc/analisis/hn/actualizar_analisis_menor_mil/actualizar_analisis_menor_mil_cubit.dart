import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/get_data_analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/get_analisis_menor_mil_data/get_analisis_menor_mil_data_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:equatable/equatable.dart';

part 'actualizar_analisis_menor_mil_state.dart';

class ActualizarAnalisisMenorMilCubit
    extends Cubit<ActualizarAnalisisMenorMilState> {
  final AnalisisRepositoryHn _repository;
  ActualizarAnalisisMenorMilCubit(this._repository)
      : super(ActualizarAnalisisMenorMilInitial());

  Future<void> actualizarAnalisisMenorMil({
    required AnalisisSolicitudesInterceptorType tipoSolicitud,
  }) async {
    final relacionMaxRazonCuotaParam = switch (tipoSolicitud) {
      AnalisisSolicitudesInterceptorType.nueva =>
        'RELACIONMAXRAZONCUOTACREDITONUEVO',
      AnalisisSolicitudesInterceptorType.represtamo =>
        'RELACIONMAXRAZONCUOTACREDITOREPRESTAMO',
      _ => throw Exception('Tipo de solicitud no soportado $tipoSolicitud'),
    };

    final relacionMinRazonCuota = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: relacionMaxRazonCuotaParam);

    final dppPorcentaje =
        double.tryParse(relacionMinRazonCuota?.valor ?? '0') ?? 0;
    final dpp = (dppPorcentaje / 100) * state.disponibilidadFamiliar;

    emit(state.copyWith(status: Status.inProgress));
    try {
      await _repository.updateAnalisisMenorMil(
        analisis: AnalisisMenorMilHN(
          numeroSolicitud: state.numeroSolicitud,
          caja: state.caja,
          banco: state.banco,
          cuentasXCobrar: state.cuentasXCobrar,
          inventario: state.totalInventario,
          otrosActivos: state.otrosActivos,
          totalAc: state.totalActivosCirculantes,
          activoFijo: state.activoFijo,
          totalActivo: state.totalActivo,
          proveedores: state.proveedores,
          cuentasXPagar: state.cuentasXPagar,
          otrasDeudas: state.otrasDeudas,
          totalPasivo: state.totalPasivo,
          capital: state.capital,
          pasivoCapital: state.pasivoCapital,
          ventasContado: state.ventasContado,
          recuperaciones: state.recuperaciones,
          otrosIngresos: state.otrosIngresos,
          gastosUnidadFamiliar: state.gastosUnidadFamiliar,
          totalIngresos: state.totalIngresos,
          costoVentaPorcentaje: state.costoVentaPorcentaje,
          costoVenta: state.costoVenta,
          gastosOperativos: state.gastosOperativos,
          margenBrutoNegocio: state.margenBrutoNegocio,
          disponidadFamiliar: state.disponibilidadFamiliar,
          dppPorcentaje: dppPorcentaje,
          dpp: dpp,
          numeroRuc: state.numeroRuc,
          nombreInstitucionRuc: state.nombreInstitucionRuc,
          fechaEmisionRuc: DateTime.tryParse(state.fechaEmisionRuc),
          fechaVencimientoRuc: DateTime.tryParse(state.fechaVencimientoRuc),
          numeroMatricula: state.numeroMatricula,
          nombreInstitucionMatricula: state.nombreInstitucionMatricula,
          fechaEmisionMatricula: DateTime.tryParse(state.fechaEmisionMatricula),
          fechaVencimientoMatricula:
              DateTime.tryParse(state.fechaVencimientoMatricula),
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
          fechaVerificacion1:
              DateTime.tryParse(state.fechaVerificacion1) ?? DateTime.now(),
          nombreReferencia1: state.nombreReferencia1,
          cedulaReferencia1: state.cedulaReferencia1,
          direccionReferencia1: state.direccionReferencia1,
          telefonoReferencia1: state.telefonoReferencia1,
          lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
          aniosConocerReferido1: state.aniosConocerReferido1,
          parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
          resultadoVerificacion1: state.resultadoVerificacion1,
          objEmpleadoVerificaReferenciaId1:
              state.objEmpleadoVerificaReferenciaId1,
          fechaVerificacion2:
              DateTime.tryParse(state.fechaVerificacion2) ?? DateTime.now(),
          nombreReferencia2: state.nombreReferencia2,
          cedulaReferencia2: state.cedulaReferencia2,
          direccionReferencia2: state.direccionReferencia2,
          telefonoReferencia2: state.telefonoReferencia2,
          lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
          aniosConocerReferido2: state.aniosConocerReferido2,
          parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
          resultadoVerificacion2: state.resultadoVerificacion2,
          objEmpleadoVerificaReferenciaId2:
              state.objEmpleadoVerificaReferenciaId2,
          fechaVerificacion3: DateTime.tryParse(state.fechaVerificacion3),
          nombreReferencia3: state.nombreReferencia3,
          cedulaReferencia3: state.cedulaReferencia3,
          direccionReferencia3: state.direccionReferencia3,
          telefonoReferencia3: state.telefonoReferencia3,
          lugarTrabajoReferencia3: state.lugarTrabajoReferencia3,
          aniosConocerReferido3: state.aniosConocerReferido3,
          parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
          resultadoVerificacion3: state.resultadoVerificacion3,
          objEmpleadoVerificaReferenciaId3:
              state.objEmpleadoVerificaReferenciaId3,
          permisoOperacionNumero: state.permisoOperacionNumero,
          permisoOperacionNombreInstitucion:
              state.permisoOperacionNombreInstitucion,
          permisoOperacionFechaEmision:
              DateTime.tryParse(state.permisoOperacionFechaEmision),
          permisoOperacionFechaVencimiento:
              DateTime.tryParse(state.permisoOperacionFechaVencimiento),
          inventarioTb: state.inventarioTb
              .map(
                (e) => InventarioHN(
                  id: int.tryParse(e.id ?? ''),
                  cantidad: e.cantidad ?? 0,
                  articulo: e.articulo ?? '',
                  costoCompra: e.costoCompra ?? 0,
                  precioVenta: (e.precioVenta ?? 0).toInt(),
                  costoVentaPorcentaje:
                      (e.costoVentaPorcentaje ?? 0).toDouble(),
                  total: (e.total ?? 0).toInt(),
                  uuid: e.id ?? '',
                ),
              )
              .toList(),
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void onFieldChanged(ActualizarAnalisisMenorMilState Function() copyWithFn) {
    emit(copyWithFn());
  }

  void cargarDatosIniciales(
    GetAnalisisMenorMilDataState data, {
    required int numeroSolicitud,
  }) {
    String idToString(int id) => id == 0 ? '' : id.toString();

    emit(
      state.copyWith(
        numeroSolicitud: numeroSolicitud,
        caja: data.caja.toDouble(),
        banco: data.banco.toDouble(),
        cuentasXCobrar: data.cuentasXCobrar.toDouble(),
        otrosActivos: data.otrosActivos.toDouble(),
        activoFijo: data.activoFijo.toDouble(),
        proveedores: data.proveedores.toDouble(),
        cuentasXPagar: data.cuentasXPagar.toDouble(),
        otrasDeudas: data.otrasDeudas.toDouble(),
        ventasContado: data.ventasContado.toDouble(),
        recuperaciones: data.recuperaciones.toDouble(),
        otrosIngresos: data.otrosIngresos.toDouble(),
        gastosUnidadFamiliar: data.gastosUnidadFamiliar.toDouble(),
        gastosOperativos: data.gastosOperativos.toDouble(),
        numeroRuc: data.numeroRuc,
        nombreInstitucionRuc: data.nombreInstitucionRuc,
        fechaEmisionRuc: data.fechaEmisionRuc,
        fechaVencimientoRuc: data.fechaVencimientoRuc,
        numeroMatricula: data.numeroMatricula,
        nombreInstitucionMatricula: data.nombreInstitucionMatricula,
        fechaEmisionMatricula: data.fechaEmisionMatricula,
        fechaVencimientoMatricula: data.fechaVencimientoMatricula,
        numeroLicencia: data.numeroLicencia,
        nombreInstitucionLicencia: data.nombreInstitucionLicencia,
        fechaEmisionLicencia: data.fechaEmisionLicencia,
        fechaVencimientoLicencia: data.fechaVencimientoLicencia,
        cliente1: data.cliente1,
        cliente2: data.cliente2,
        cliente3: data.cliente3,
        proveedor1: data.proveedor1,
        proveedor2: data.proveedor2,
        proveedor3: data.proveedor3,
        fechaVerificacion1: data.fechaVerificacion1,
        nombreReferencia1: data.nombreReferencia1,
        cedulaReferencia1: data.cedulaReferencia1,
        direccionReferencia1: data.direccionReferencia1,
        telefonoReferencia1: data.telefonoReferencia1,
        lugarTrabajoReferencia1: data.lugarTrabajoReferencia1,
        aniosConocerReferido1: data.aniosConocerReferido1.toInt(),
        parentescoReferenciaCodigo1: data.parentescoReferenciaCodigo1,
        resultadoVerificacion1: data.resultadoVerificacion1,
        objEmpleadoVerificaReferenciaId1:
            idToString(data.objEmpleadoVerificaReferenciaId1),
        fechaVerificacion2: data.fechaVerificacion2,
        nombreReferencia2: data.nombreReferencia2,
        cedulaReferencia2: data.cedulaReferencia2,
        direccionReferencia2: data.direccionReferencia2,
        telefonoReferencia2: data.telefonoReferencia2,
        lugarTrabajoReferencia2: data.lugarTrabajoReferencia2,
        aniosConocerReferido2: data.aniosConocerReferido2.toInt(),
        parentescoReferenciaCodigo2: data.parentescoReferenciaCodigo2,
        resultadoVerificacion2: data.resultadoVerificacion2,
        objEmpleadoVerificaReferenciaId2:
            idToString(data.objEmpleadoVerificaReferenciaId2),
        fechaVerificacion3: data.fechaVerificacion3,
        nombreReferencia3: data.nombreReferencia3,
        cedulaReferencia3: data.cedulaReferencia3,
        direccionReferencia3: data.direccionReferencia3,
        telefonoReferencia3: data.telefonoReferencia3,
        lugarTrabajoReferencia3: data.lugarTrabajoReferencia3,
        aniosConocerReferido3: data.aniosConocerReferido3,
        parentescoReferenciaCodigo3: data.parentescoReferenciaCodigo3,
        resultadoVerificacion3: data.resultadoVerificacion3,
        objEmpleadoVerificaReferenciaId3:
            idToString(data.objEmpleadoVerificaReferenciaId3),
        permisoOperacionNumero: data.permisoOperacionNumero,
        permisoOperacionNombreInstitucion:
            data.permisoOperacionNombreInstitucion,
        permisoOperacionFechaEmision: data.permisoOperacionFechaEmision,
        permisoOperacionFechaVencimiento: data.permisoOperacionFechaVencimiento,
        inventarioTb: data.inventarioTb,
      ),
    );
  }

  /// Limpia la referencia 3 cuando el asesor la quita del formulario.
  void limpiarReferencia3() {
    emit(
      state.copyWith(
        fechaVerificacion3: '',
        nombreReferencia3: '',
        cedulaReferencia3: '',
        direccionReferencia3: '',
        telefonoReferencia3: '',
        lugarTrabajoReferencia3: '',
        aniosConocerReferido3: 0,
        parentescoReferenciaCodigo3: '',
        resultadoVerificacion3: '',
        objEmpleadoVerificaReferenciaId3: '',
      ),
    );
  }
}
