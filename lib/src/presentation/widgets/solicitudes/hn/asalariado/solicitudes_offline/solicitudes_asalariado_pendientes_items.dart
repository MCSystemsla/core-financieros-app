import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitud_asalariado_hn_db_local.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/slide_pageview_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/hn/solicitudes_pendientes_widget_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SolicitudesAsalariadoPendientesItemsHN extends StatelessWidget {
  final PageController controller;
  final List<SolicitudAsalariadoHnDbLocal> solicitudesAsalariadoInProgress;
  final List<SolicitudAsalariadoHnDbLocal> solicitudesAsalariadoDone;

  const SolicitudesAsalariadoPendientesItemsHN({
    super.key,
    required this.controller,
    required this.solicitudesAsalariadoInProgress,
    required this.solicitudesAsalariadoDone,
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
            title: 'Solicitudes Asalariado',
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
                _SolicitudesPendientesWidgetAsalariadoHN(
                  solicitudesAsalariado: solicitudesAsalariadoInProgress,
                ),
                _SolicitudesEnviadasWidget(
                  solicitudesAsalariado: solicitudesAsalariadoDone,
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
  final List<SolicitudAsalariadoHnDbLocal> solicitudesAsalariado;

  const _SolicitudesEnviadasWidget({
    required this.solicitudesAsalariado,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudesAsalariado.isEmpty) {
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
      itemCount: solicitudesAsalariado.length,
      itemBuilder: (BuildContext context, int index) {
        return _SolicitudesPendientesWidgetAsalariadoHN(
          solicitudesAsalariado: solicitudesAsalariado,
        );
      },
    );
  }
}

class _SolicitudesPendientesWidgetAsalariadoHN extends StatelessWidget {
  final List<SolicitudAsalariadoHnDbLocal> solicitudesAsalariado;
  const _SolicitudesPendientesWidgetAsalariadoHN({
    required this.solicitudesAsalariado,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudesAsalariado.isEmpty) {
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
      itemCount: solicitudesAsalariado.length,
      itemBuilder: (_, int index) {
        return SolicitudesAsalariadoPendientesWidgetHN(
          solicitud: solicitudesAsalariado[index],
        );
      },
    );
  }
}
