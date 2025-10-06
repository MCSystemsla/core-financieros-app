import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/slide_pageview_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/ni/solicitudes_pendientes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SolicitudesReprestamoPendientesItems extends StatelessWidget {
  final PageController controller;
  final List<ReprestamoResponsesLocalDb> solicitudesReprestamoOfflinePending;
  final List<ReprestamoResponsesLocalDb> solicitudesReprestamoOfflineDone;
  const SolicitudesReprestamoPendientesItems({
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
                      solicitudesReprestamoOfflinePending,
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
  final List<ReprestamoResponsesLocalDb> solicitudesReprestamoOffline;
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
        return SolicitudesReprestamoPendientesWidget(
          solicitud: solicitudesReprestamoOffline[index],
        );
      },
    );
  }
}

class _SolicitudesPendientesWidget extends StatelessWidget {
  final List<ReprestamoResponsesLocalDb> solicitudesReprestamoOffline;
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
            'No hay solicitudes pendientes',
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
        return SolicitudesReprestamoPendientesWidget(
          solicitud: solicitudesReprestamoOffline[index],
        );
      },
    );
  }
}
