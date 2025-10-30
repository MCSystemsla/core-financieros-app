// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitud_asalariado_hn_db_local.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/offline/asalariado/crear_solicitud_asalariado_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/offline/nueva/crear_solicitud_offline_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/ni/solicitudes_pendientes_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';

class SolciitudesEnviadasHNWidget extends StatelessWidget {
  final SolicitudNuevaMenorHnLocalDb solicitud;
  const SolciitudesEnviadasHNWidget({
    super.key,
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    double calcularPorcentajeLlenado(SolicitudNuevaMenorHnLocalDb respuesta) {
      var valores = [
        respuesta.nombre1,
        respuesta.apellido1,
        respuesta.cedula,
        respuesta.paisEmisorCedulaCodigo,
        respuesta.fechaEmisionCedula,
        respuesta.fechaVencimientoCedula,
        respuesta.fechaNacimiento,
        respuesta.telefono,
        respuesta.celular,
        respuesta.direccionCasa,
        respuesta.barrioCasa,
        respuesta.municipioCasaCodigo,
        respuesta.departamentoCasaCodigo,
        respuesta.paisCasaCodigo,
        respuesta.profesion,
        respuesta.ocupacion,
        respuesta.condicionCasaCodigo,
        respuesta.anosResidirCasa,
        respuesta.monto,
        respuesta.monedaCodigo,
        respuesta.propositoCodigo,
        respuesta.frecuenciaCodigo,
        respuesta.cuota,
        respuesta.sectorCodigo,
        respuesta.nombreNegocio,
        respuesta.tiempoFuncionamientoNegocio,
        respuesta.direccionNegocio,
        respuesta.barrioNegocio,
        respuesta.municipioNegocioCodigo,
        respuesta.condicionNegocioCodigo,
        respuesta.horarioTrabajo,
        respuesta.horarioVisita,
        respuesta.personasACargo,
        respuesta.estadoCivilCodigo,
        respuesta.nombreConyugue,
        respuesta.trabajaConyugue,
        respuesta.trabajoConyugue,
        respuesta.direccionTrabajoConyugue,
        respuesta.telefonoTrabajoConyugue,
        respuesta.productoCodigo,
        respuesta.observacion,
        respuesta.escolaridadCodigo,
        respuesta.cantidadHijos,
        respuesta.nombrePublico,
        respuesta.sexoCodigo,
        respuesta.paisNacimientoCodigo,
        respuesta.nacionalidadConyugue,
        respuesta.ubicacion,
        respuesta.espeps,
        respuesta.nombreDeEntidadPeps,
        respuesta.paisPeps,
        respuesta.periodoPeps,
        respuesta.cargoOficialPeps,
        respuesta.tieneFamiliarPeps,
        respuesta.nombreFamiliarPeps2,
        respuesta.parentescoFamiliarPeps2Codigo,
        respuesta.cargoFamiliarPeps2,
        respuesta.nombreEntidadPeps2,
        respuesta.periodoPeps2,
        respuesta.paisPeps2,
        respuesta.esFamiliarEmpleado,
        respuesta.nombreFamiliar,
        respuesta.cedulaFamiliar,
        respuesta.tipoDocumentoCodigo,
        respuesta.tipoPersonaCodigo,
        respuesta.plazoSolicitud,
        respuesta.fechaPrimerPagoSolicitud,
        respuesta.codigoUsa,
        respuesta.nombre3,
        respuesta.apellido3,
        respuesta.rtn,
        respuesta.telefonoNegocio,
        respuesta.celularNegocio,
        respuesta.actividadDescripcionConyugue,
        respuesta.exeperiencia,
        respuesta.puestoNegocio,
        respuesta.actividadEconomicaCnbs1Codigo,
        respuesta.actividadEconomicaCnbs2Codigo,
        respuesta.actividaEconomicaDescipcion1,
        respuesta.actividaEconomicaDescipcion2,
        respuesta.actividaEconomicaDescipcion3,
        respuesta.ejerceApnfd,
        respuesta.esApnfd,
        respuesta.nacinalidadCodigo,
        respuesta.nacinalidad2Codigo,
        respuesta.nacinalidad3Codigo,
        respuesta.departamentoDestinoCodigo,
        respuesta.tipoPersonaCnbsCodigo,
        respuesta.tipoClienteCodigo,
        respuesta.aldeaDestinoCodigo,
        respuesta.municipioDestinoCodigo,
        respuesta.aldeaNegocioCodigo,
        respuesta.departamentoNegocioCodigo,
        respuesta.nivelAproximadoIngresosCodigo,
        respuesta.documentoConyuge,
        respuesta.ocupacionCodigo,
        respuesta.profesionCodigo,
        respuesta.aldeaCasaCodigo,
        respuesta.ubicacionCodigo,
        respuesta.medidasConocimientoCodigo,
        respuesta.caserioCasa,
        respuesta.caserioNegocio,
        respuesta.caserioDestino,
        respuesta.barrioDestino,
        respuesta.descripcionDestino,
        respuesta.ingresosNetos,
        respuesta.nombre2,
        respuesta.apellido2,
        respuesta.email,
        respuesta.actividadEconomicaCnbs3Codigo,
      ];

      int camposLlenos = valores
          .where((valor) => valor != null && valor.toString().trim().isNotEmpty)
          .length;
      int totalCampos = valores.length;

      return (camposLlenos / totalCampos) * 100;
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: AdvanceCardState(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CrearSolicitudNuevaOfflineHnScreen(
                solicitudNuevaMenorHnLocalDb: solicitud,
              ),
            ),
          );
        },
        title:
            '${solicitud.nombre1} ${solicitud.nombre2} ${solicitud.apellido1} ${solicitud.apellido2}'
                .capitalizeAll,
        cedula: solicitud.cedula ?? 'N/A',
        dateToStart: solicitud.createdAt.toLocal().selectorFormat(),
        dateToEnd: solicitud.createdAt
            .toUtc()
            .toLocal()
            .add(const Duration(days: 30))
            .formatDateToTimePeriod(),
        percentage:
            (solicitud.isDone) ? 100 : calcularPorcentajeLlenado(solicitud),
      ),
    );
  }
}

class SolicitudesAsalariadoPendientesWidgetHN extends StatelessWidget {
  final SolicitudAsalariadoHnDbLocal solicitud;
  const SolicitudesAsalariadoPendientesWidgetHN({
    super.key,
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    double calcularPorcentajeLlenado(SolicitudAsalariadoHnDbLocal respuesta) {
      var valores = [
        respuesta.nombre1,
        respuesta.nombre2,
        respuesta.apellido1,
        respuesta.apellido2,
        respuesta.cedula,
        respuesta.paisEmisorCedulaCodigo,
        respuesta.fechaEmisionCedula,
        respuesta.fechaVencimientoCedula,
        respuesta.fechaNacimiento,
        respuesta.telefono,
        respuesta.celular,
        respuesta.direccionCasa,
        respuesta.barrioCasa,
        respuesta.municipioCasaCodigo,
        respuesta.departamentoCasaCodigo,
        respuesta.paisCasaCodigo,
        respuesta.nacinalidad,
        respuesta.condicionCasaCodigo,
        respuesta.anosResidirCasa,
        respuesta.email,
        respuesta.monto,
        respuesta.monedaCodigo,
        respuesta.propositoCodigo,
        respuesta.frecuenciaCodigo,
        respuesta.cuota,
        respuesta.sectorCodigo,
        respuesta.personasACargo,
        respuesta.estadoCivilCodigo,
        respuesta.nombreConyugue,
        respuesta.trabajaConyugue,
        respuesta.trabajoConyugue,
        respuesta.direccionTrabajoConyugue,
        respuesta.telefonoTrabajoConyugue,
        respuesta.productoCodigo,
        respuesta.observacion,
        respuesta.escolaridadCodigo,
        respuesta.cantidadHijos,
        respuesta.nombrePublico,
        respuesta.sexoCodigo,
        respuesta.paisNacimientoCodigo,
        respuesta.nacionalidadConyugue,
        respuesta.ubicacion,
        respuesta.espeps,
        respuesta.nombreDeEntidadPeps,
        respuesta.paisPeps,
        respuesta.periodoPeps,
        respuesta.cargoOficialPeps,
        respuesta.tieneFamiliarPeps,
        respuesta.nombreFamiliarPeps2,
        respuesta.parentescoFamiliarPeps2,
        respuesta.cargoFamiliarPeps2,
        respuesta.nombreEntidadPeps2,
        respuesta.periodoPeps2,
        respuesta.paisPeps2,
        respuesta.actividadPredominanteCodigo,
        respuesta.esFamiliarEmpleado,
        respuesta.nombreFamiliar,
        respuesta.cedulaFamiliar,
        respuesta.tipoDocumentoCodigo,
        respuesta.tipoPersonaCodigo,
        respuesta.plazoSolicitud,
        respuesta.fechaPrimerPagoSolicitud,
        respuesta.nombreTrabajo,
        respuesta.direccionTrabajo,
        respuesta.barrioTrabajo,
        respuesta.cargo,
        respuesta.direccionFamiliarCercano,
        respuesta.fuenteOtrosIngresos,
        respuesta.fuenteOtrosIngresosConyugue,
        respuesta.lugarTrabajoAnterior,
        respuesta.nombreFamiliarCercano,
        respuesta.parentescoFamiliarCercanoCodigo,
        respuesta.otrosIngresosConyugue,
        respuesta.otrosIngresosCordoba,
        respuesta.profesionConyugue,
        respuesta.salarioNetoCordoba,
        respuesta.sueldoMesConyugue,
        respuesta.telefonoFamiliarCercano,
        respuesta.telefonoTrabajo,
        respuesta.tiempoLaborar,
        respuesta.tiempoLaborarConyugue,
        respuesta.totalIngresoMes,
        respuesta.totalIngresoMesConyugue,
        respuesta.rtn,
        respuesta.codigoUsa,
        respuesta.tipoPersonaCnbsidCodigo,
        respuesta.estatusClienteCodigo,
        respuesta.tipoClienteCodigo,
        respuesta.actividadEconomicaCiuu1Codigo,
        respuesta.actividadEconomicaCiuu2Codigo,
        respuesta.actividadEconomicaCiuu3Codigo,
        respuesta.nivelAproximadoDeIngresosCodigo,
        respuesta.ocupacionCodigo,
        respuesta.profesionCodigo,
        respuesta.actividadEconomicaDescripcion1,
        respuesta.actividadEconomicaDescripcion2,
        respuesta.actividadEconomicaDescripcion3,
        respuesta.ejerceApnfd,
        respuesta.esApnfd,
        respuesta.paisDestinoCodigo,
        respuesta.departamentoDestinoCodigo,
        respuesta.municipioDestinoId,
        respuesta.aldeaDestinoCodigo,
        respuesta.caserioDestino,
        respuesta.barrioDestino,
        respuesta.caseriCasa,
        respuesta.aldeaCodigo,
        respuesta.descripcionDestino,
      ];

      int camposLlenos = valores
          .where((valor) => valor != null && valor.toString().trim().isNotEmpty)
          .length;
      int totalCampos = valores.length;

      return (camposLlenos / totalCampos) * 100;
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: AdvanceCardState(
        backgroundColor:
            solicitud.errorMsg == null || solicitud.errorMsg!.isEmpty
                ? Colors.white
                : AppColors.red.withOpacity(.3).withBlue(170),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CrearSolicitudAsalariadoOfflineScreen(
                solicitudAsalariadoHnDbLocal: solicitud,
              ),
            ),
          );
        },
        title:
            '${solicitud.nombre1} ${solicitud.nombre2} ${solicitud.apellido1}'
                .capitalizeAll,
        cedula: solicitud.cedula ?? 'N/A',
        dateToStart: solicitud.createdAt.toLocal().selectorFormat(),
        dateToEnd: solicitud.createdAt
            .toUtc()
            .toLocal()
            .add(const Duration(days: 30))
            .formatDateToTimePeriod(),
        percentage:
            (solicitud.isDone) ? 100 : calcularPorcentajeLlenado(solicitud),
      ),
    );
  }
}
