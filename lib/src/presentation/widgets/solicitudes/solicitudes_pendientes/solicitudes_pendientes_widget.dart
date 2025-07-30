// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/offline/crear_solicitud_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_offline_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/offline/represtamo_offline_view.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';

class SolicitudesPendientesWidget extends StatelessWidget {
  final ResponseLocalDb solicitud;
  const SolicitudesPendientesWidget({
    super.key,
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    double calcularPorcentajeLlenado(ResponseLocalDb respuesta) {
      var valores = [
        respuesta.nombre1,
        respuesta.nombre2,
        respuesta.apellido1,
        respuesta.apellido2,
        respuesta.cedula,
        respuesta.objPaisEmisorCedula,
        respuesta.fechaEmisionCedula,
        respuesta.fechaVencimientoCedula,
        respuesta.fechaNacimiento,
        respuesta.telefono,
        respuesta.celular,
        respuesta.direccionCasa,
        respuesta.barrioCasa,
        respuesta.objMunicipioCasaId,
        respuesta.objDepartamentoCasaId,
        respuesta.objPaisCasaId,
        respuesta.profesion,
        respuesta.ocupacion,
        respuesta.nacionalidad,
        respuesta.objCondicionCasaId,
        respuesta.anosResidirCasa,
        respuesta.email,
        respuesta.monto,
        respuesta.objMonedaId,
        respuesta.objPropositoId,
        respuesta.objFrecuenciaId,
        respuesta.cuota,
        respuesta.objActividadId,
        respuesta.objActividadId1,
        respuesta.objActividadId2,
        respuesta.objSectorId,
        respuesta.nombreNegocio,
        respuesta.tiempoFuncionamientoNegocio,
        respuesta.direccionNegocio,
        respuesta.barrioNegocio,
        respuesta.objMunicipioNegocioId,
        respuesta.objCondicionNegocioId,
        respuesta.horarioTrabajo,
        respuesta.horarioVisita,
        respuesta.personasACargo,
        respuesta.objEstadoCivilId,
        respuesta.nombreConyugue,
        respuesta.trabajaConyugue,
        respuesta.trabajoConyugue,
        respuesta.direccionTrabajoConyugue,
        respuesta.telefonoTrabajoConyugue,
        respuesta.beneficiarioSeguro,
        respuesta.cedulaBeneficiarioSeguro,
        respuesta.objParentescoBeneficiarioSeguroId,
        respuesta.beneficiarioSeguro1,
        respuesta.cedulaBeneficiarioSeguro1,
        respuesta.objParentescoBeneficiarioSeguroId1,
        respuesta.objEstadoSolicitudId,
        respuesta.objOficialCreditoId,
        respuesta.objProductoId,
        respuesta.observacion,
        respuesta.sucursal,
        respuesta.ubicacionLongitud,
        respuesta.ubicacionLatitud,
        respuesta.ubicacionGradosLongitud,
        respuesta.ubicacionGradosLatitud,
        respuesta.objEscolaridadId,
        respuesta.cantidadHijos,
        respuesta.nombrePublico,
        respuesta.objSexoId,
        respuesta.objPaisNacimientoId,
        respuesta.nacionalidadConyugue,
        respuesta.database,
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
        respuesta.objRubroActividad,
        respuesta.objActividadPredominante,
        respuesta.esFamiliarEmpleado,
        respuesta.nombreFamiliar,
        respuesta.cedulaFamiliar,
        respuesta.objTipoDocumentoId,
        respuesta.objRubroActividad2,
        respuesta.objRubroActividad3,
        respuesta.objRubroActividadPredominante,
        respuesta.tipoPersona,
        respuesta.objTipoPersonaId,
        respuesta.telefonoBeneficiario,
        respuesta.telefonoBeneficiarioSeguro1,
        respuesta.plazoSolicitud,
        respuesta.fechaPrimerPagoSolicitud
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
              builder: (context) => CrearSolicitudOfflineScreen(
                responseLocalDb: solicitud,
              ),
            ),
          );
        },
        title:
            '${solicitud.nombre1} ${solicitud.nombre2} ${solicitud.apellido1} ${solicitud.apellido2}'
                .capitalizeAll,
        cedula: solicitud.cedula ?? 'N/A',
        dateToStart: solicitud.createdAt?.toLocal().selectorFormat(),
        dateToEnd: solicitud.createdAt
            ?.toUtc()
            .toLocal()
            .add(const Duration(days: 30))
            .formatDateToTimePeriod(),
        percentage: (solicitud.isDone ?? false)
            ? 100
            : calcularPorcentajeLlenado(solicitud),
      ),
    );
  }
}

class SolicitudesReprestamoPendientesWidget extends StatelessWidget {
  final ReprestamoResponsesLocalDb solicitud;
  const SolicitudesReprestamoPendientesWidget({
    super.key,
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    double calcularPorcentajeLlenado(ReprestamoResponsesLocalDb respuesta) {
      var valores = [
        respuesta.database,
        respuesta.cedula,
        respuesta.monto,
        respuesta.objMonedaId,
        respuesta.objPropositoId,
        respuesta.objFrecuenciaId,
        respuesta.cuota,
        respuesta.objActividadId,
        respuesta.objActividadId1,
        respuesta.objActividadId2,
        respuesta.objSectorId,
        respuesta.beneficiarioSeguro,
        respuesta.cedulaBeneficiarioSeguro,
        respuesta.objParentescoBeneficiarioSeguroId,
        respuesta.objProductoId,
        respuesta.observacion,
        respuesta.ubicacionLongitud,
        respuesta.ubicacionLatitud,
        respuesta.sucursal,
        respuesta.ubicacion,
        respuesta.esPeps,
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
        respuesta.objRubroActividad,
        respuesta.objActividadPredominante,
        respuesta.objTipoDocumentoId,
        respuesta.objRubroActividad2,
        respuesta.objRubroActividad3,
        respuesta.objRubroActividadPredominante,
        respuesta.tipoPersona,
        respuesta.objTipoPersonaId,
        respuesta.telefonoBeneficiario,
        respuesta.celularReprestamo,
        respuesta.esFamiliarEmpleado,
        respuesta.nombreFamiliar,
        respuesta.cedulaFamiliar,
        respuesta.plazoSolicitud,
        respuesta.fechaPrimerPagoSolicitud,
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
              builder: (_) => ReprestamoOfflineView(
                solicitudReprestamoOffline: solicitud,
              ),
            ),
          );
        },
        title: solicitud.nombreCompletoCliente ?? 'N/A',
        cedula: solicitud.cedula ?? 'N/A',
        dateToStart: solicitud.createdAt?.toLocal().selectorFormat(),
        dateToEnd: solicitud.createdAt
            ?.toUtc()
            .toLocal()
            .add(const Duration(days: 30))
            .formatDateToTimePeriod(),
        percentage: (solicitud.isDone ?? false)
            ? 100
            : calcularPorcentajeLlenado(solicitud),
      ),
    );
  }
}

class SolicitudesAsalariadoPendientesWidget extends StatelessWidget {
  final AsalariadoResponsesLocalDb solicitud;
  const SolicitudesAsalariadoPendientesWidget({
    super.key,
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    double calcularPorcentajeLlenado(AsalariadoResponsesLocalDb respuesta) {
      var valores = [
        respuesta.nombre1,
        respuesta.nombre2,
        respuesta.apellido1,
        respuesta.apellido2,
        respuesta.cedula,
        respuesta.objPaisEmisorCedula,
        respuesta.fechaEmisionCedula,
        respuesta.fechaVencimientoCedula,
        respuesta.fechaNacimiento,
        respuesta.telefono,
        respuesta.celular,
        respuesta.direccionCasa,
        respuesta.barrioCasa,
        respuesta.objMunicipioCasaId,
        respuesta.objDepartamentoCasaId,
        respuesta.objPaisCasaId,
        respuesta.profesion,
        respuesta.ocupacion,
        respuesta.nacionalidad,
        respuesta.objCondicionCasaId,
        respuesta.anosResidirCasa,
        respuesta.email,
        respuesta.monto,
        respuesta.objMonedaId,
        respuesta.objPropositoId,
        respuesta.objFrecuenciaId,
        respuesta.cuota,
        respuesta.objSectorId,
        respuesta.personasACargo,
        respuesta.objEstadoCivilId,
        respuesta.nombreConyugue,
        respuesta.trabajaConyugue,
        respuesta.trabajoConyugue,
        respuesta.direccionTrabajoConyugue,
        respuesta.telefonoTrabajoConyugue,
        respuesta.beneficiarioSeguro,
        respuesta.cedulaBeneficiarioSeguro,
        respuesta.objParentescoBeneficiarioSeguroId,
        respuesta.objEstadoSolicitudId,
        respuesta.objOficialCreditoId,
        respuesta.objProductoId,
        respuesta.observacion,
        respuesta.sucursal,
        respuesta.ubicacionLongitud,
        respuesta.ubicacionLatitud,
        respuesta.ubicacionGradosLongitud,
        respuesta.ubicacionGradosLatitud,
        respuesta.objEscolaridadId,
        respuesta.cantidadHijos,
        respuesta.nombrePublico,
        respuesta.objSexoId,
        respuesta.objPaisNacimientoId,
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
        respuesta.objRubroActividad,
        respuesta.objActividadPredominante,
        respuesta.esFamiliarEmpleado,
        respuesta.nombreFamiliar,
        respuesta.cedulaFamiliar,
        respuesta.objTipoDocumentoId,
        respuesta.objRubroActividad2,
        respuesta.objRubroActividad3,
        respuesta.objRubroActividadPredominante,
        respuesta.tipoPersona,
        respuesta.objTipoPersonaId,
        respuesta.telefonoBeneficiario,
        respuesta.codigoRed,
        respuesta.plazoSolicitud,
        respuesta.fechaPrimerPagoSolicitud,
        respuesta.nombreTrabajo,
        respuesta.direccionTrabajo,
        respuesta.barrioTrabajo,
        respuesta.objActividadEconomicaId,
        respuesta.objActividadEconomicaId1,
        respuesta.objActividadEconomicaId2,
        respuesta.cargo,
        respuesta.direccionFamiliarCercano,
        respuesta.duenoVivienda,
        respuesta.fechaVenceAvaluoAsalariado,
        respuesta.fuenteOtrosIngresos,
        respuesta.fuenteOtrosIngresosConyugue,
        respuesta.lugarTrabajoAnterior,
        respuesta.nombreFamiliarCercano,
        respuesta.objParentescoFamiliarCercanoId,
        respuesta.otrosIngresosConyugue,
        respuesta.otrosIngresosCordoba,
        respuesta.pagoAlquiler,
        respuesta.profesionConyugue,
        respuesta.salarioNetoCordoba,
        respuesta.sueldoMesConyugue,
        respuesta.telefonoFamiliarCercano,
        respuesta.telefonoTrabajo,
        respuesta.tiempoLaborar,
        respuesta.tiempoLaborarConyugue,
        respuesta.totalIngresoMes,
        respuesta.totalIngresoMesConyugue,
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
              builder: (_) => AsalariadoOfflineView(
                asalariadoResponsesLocalDb: solicitud,
              ),
            ),
          );
        },
        title:
            '${solicitud.nombre1} ${solicitud.nombre2} ${solicitud.apellido1}'
                .capitalizeAll,
        cedula: solicitud.cedula ?? 'N/A',
        dateToStart: solicitud.createdAt?.toLocal().selectorFormat(),
        dateToEnd: solicitud.createdAt
            ?.toUtc()
            .toLocal()
            .add(const Duration(days: 30))
            .formatDateToTimePeriod(),
        percentage: (solicitud.isDone ?? false)
            ? 100
            : calcularPorcentajeLlenado(solicitud),
      ),
    );
  }
}

class AdvanceCardState extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String cedula;
  final String? dateToStart;
  final String? dateToEnd;
  final double percentage;
  final Color backgroundColor;
  const AdvanceCardState({
    required this.title,
    required this.cedula,
    required this.dateToStart,
    required this.dateToEnd,
    required this.percentage,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * .9,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            elevation: 0,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        onPressed: onPressed,
        child: Row(
          children: [
            SizedBox(
              width: size.width * .56,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    width: size.width * .56,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Cedula: $cedula',
                    style: const TextStyle(color: AppColors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Fecha de creacion: ${dateToStart ?? "--/--/----"}',
                    style: const TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Esta solicitud sera eliminada automaticamente: ${dateToEnd ?? "--/--/----"}',
                    style: const TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 5)
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Porcentaje (%)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.getPrimaryColor(),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Char(
                      percent: percentage,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Char extends StatelessWidget {
  final double percent;
  const Char({required this.percent, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.square(
          dimension: 60,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: percent),
            duration: const Duration(milliseconds: 1200),
            builder: (context, value, _) => CircularProgressIndicator(
              value: (value / 100),
              backgroundColor: AppColors.getPrimaryColor().withOpacity(.3),
              color: AppColors.getSecondaryColor(),
              strokeWidth: 9,
            ),
          ),
        ),
        Text(percent.toStringAsFixed(0)),
      ],
    );
  }
}
