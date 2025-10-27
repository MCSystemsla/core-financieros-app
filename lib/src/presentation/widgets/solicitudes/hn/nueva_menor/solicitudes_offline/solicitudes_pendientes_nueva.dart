import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/slide_pageview_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/hn/solicitudes_pendientes_widget_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SolicitudesPendientesItemsNuevaHN extends StatelessWidget {
  final PageController controller;
  final List<SolicitudNuevaMenorHnLocalDb> solicitudesOfflinePending;
  final List<SolicitudNuevaMenorHnLocalDb> solicitudesOfflineDone;
  const SolicitudesPendientesItemsNuevaHN({
    super.key,
    required this.solicitudesOfflinePending,
    required this.solicitudesOfflineDone,
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
            title: 'Solicitudes Nuevas',
          ),
          const Gap(20),
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
                  solicitudesOffline: solicitudesOfflinePending,
                ),
                _SolicitudesEnviadasWidget(
                  solicitudesOffline: solicitudesOfflineDone,
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
  final List<SolicitudNuevaMenorHnLocalDb> solicitudesOffline;

  const _SolicitudesEnviadasWidget({
    required this.solicitudesOffline,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudesOffline.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      itemCount: solicitudesOffline.length,
      itemBuilder: (BuildContext context, int index) {
        return SolciitudesEnviadasHNWidget(
          solicitud: solicitudesOffline[index],
        );
      },
    );
  }
}

class _SolicitudesPendientesWidget extends StatelessWidget {
  final List<SolicitudNuevaMenorHnLocalDb> solicitudesOffline;
  const _SolicitudesPendientesWidget({
    required this.solicitudesOffline,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudesOffline.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      itemCount: solicitudesOffline.length,
      itemBuilder: (BuildContext context, int index) {
        return SolciitudesEnviadasHNWidget(
          solicitud: solicitudesOffline[index],
        );
      },
    );
  }
}
