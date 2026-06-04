// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/local_db/solicitud_represtamo_hn_local_db.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/offline/represtamo/crear_solicitud_represtamo_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/slide_pageview_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/ni/solicitudes_pendientes_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SolicitudesReprestamoPendientesItemsHN extends StatelessWidget {
  final PageController controller;
  final List<SolicitudReprestamoHnLocalDb> solicitudesReprestamoOfflinePending;
  final List<SolicitudReprestamoHnLocalDb> solicitudesReprestamoOfflineDone;
  const SolicitudesReprestamoPendientesItemsHN({
    super.key,
    required this.solicitudesReprestamoOfflinePending,
    required this.solicitudesReprestamoOfflineDone,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const Gap(15),
          SlidePageviewView(
            controller: controller,
            title: 'Solicitudes Represtamo',
          ),
          const TabBar(
            unselectedLabelColor: Colors.grey,
            isScrollable: false,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: [
              Tab(
                icon: Icon(Icons.hourglass_bottom),
                text: 'En progreso',
              ),
              Tab(
                icon: Icon(Icons.check_circle),
                text: 'Finalizados',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _SolicitudesPendientesWidget(
                  solicitudesReprestamoOffline:
                      solicitudesReprestamoOfflinePending,
                ),
                _SolicitudesEnviadasWidget(
                  solicitudesReprestamoOffline:
                      solicitudesReprestamoOfflineDone,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SolicitudesEnviadasWidget extends StatelessWidget {
  final List<SolicitudReprestamoHnLocalDb> solicitudesReprestamoOffline;
  const _SolicitudesEnviadasWidget({
    required this.solicitudesReprestamoOffline,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudesReprestamoOffline.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            height: 170,
            ImageAsset.noDataBg,
          ),
          const Gap(25),
          Text(
            'No hay solicitudes finalizadas',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: solicitudesReprestamoOffline.length,
      itemBuilder: (_, int index) {
        return SolicitudesReprestamoPendientesWidgetHN(
          solicitud: solicitudesReprestamoOffline[index],
        );
      },
    );
  }
}

class _SolicitudesPendientesWidget extends StatelessWidget {
  final List<SolicitudReprestamoHnLocalDb> solicitudesReprestamoOffline;
  const _SolicitudesPendientesWidget({
    required this.solicitudesReprestamoOffline,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudesReprestamoOffline.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            height: 170,
            ImageAsset.noDataBg,
          ),
          const Gap(25),
          Text(
            'No hay solicitudes en proceso',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: solicitudesReprestamoOffline.length,
      itemBuilder: (_, int index) {
        return SolicitudesReprestamoPendientesWidgetHN(
          solicitud: solicitudesReprestamoOffline[index],
        );
      },
    );
  }
}

class SolicitudesReprestamoPendientesWidgetHN extends StatelessWidget {
  final SolicitudReprestamoHnLocalDb solicitud;
  const SolicitudesReprestamoPendientesWidgetHN({
    super.key,
    required this.solicitud,
  });

  @override
  Widget build(BuildContext context) {
    double calcularPorcentajeLlenado(SolicitudReprestamoHnLocalDb respuesta) {
      var valores = [
        respuesta.cedula,
        respuesta.monto,
        respuesta.monedaCodigo,
        respuesta.propositoCodigo,
        respuesta.frecuenciaCodigo,
        respuesta.cuota,
        respuesta.beneficiarioSeguro,
        respuesta.cedulaBeneficiarioSeguro,
        respuesta.parentescoBeneficiarioSeguroCodigo,
        respuesta.productoCodigo,
        respuesta.observacion,
        respuesta.ubicacion,
        respuesta.esPeps,
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
        respuesta.tipoDocumentoCodigo,
        respuesta.celularReprestamo,
        respuesta.esFamiliarEmpleado,
        respuesta.nombreFamiliar,
        respuesta.cedulaFamiliar,
        respuesta.plazoSolicitud,
        respuesta.fechaPrimerPagoSolicitud,
        respuesta.tipoPersonaCodigo,
        respuesta.cargaAnalisisAutomatico,
        respuesta.motivoRevisionCodigo,
        respuesta.actividadEconomicaCiuu1,
        respuesta.actividadEconomicaCiuu2,
        respuesta.actividadEconomicaCiuu3,
        respuesta.codigoUsa,
        respuesta.apnfd,
        respuesta.actividadEconomicaRealizaCiuu1,
        respuesta.actividadEconomicaRealizaCiuu2,
        respuesta.actividadEconomicaRealizaCiuu3,
        respuesta.tieneIdentificacionEstadosUnidos,
        respuesta.tieneVinculoEstadosUnidos,
        respuesta.vinculoEstadosUnidosDescripcion,
        respuesta.ejerceActividadApfnd,
        respuesta.medidasConocimientoCodigo,
        respuesta.nombreEmpleadoFamiliar,
        respuesta.cuotaClientePuedePagar,
        respuesta.nombreCompleto,
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
              builder: (_) => CrearSolicitudReprestamoOfflineScreen(
                solicitudReprestamoHnLocalDb: solicitud,
              ),
            ),
          );
        },
        title: solicitud.nombreCompleto ?? 'N/A',
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
