import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/slide_pageview_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/ni/solicitudes_pendientes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SolicitudesAsalariadoPendientesItems extends StatelessWidget {
  final PageController controller;
  final List<AsalariadoResponsesLocalDb> solicitudesAsalariadoInProgress;
  final List<AsalariadoResponsesLocalDb> solicitudesAsalariadoDone;

  const SolicitudesAsalariadoPendientesItems({
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
                _SolicitudesPendientesWidget(
                  solicitudesAsalariado: solicitudesAsalariadoInProgress,
                ),
                _SolicitudesEnviadasWidget(
                  solicitudesAsalariado: solicitudesAsalariadoDone,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SolicitudesEnviadasWidget extends StatelessWidget {
  final List<AsalariadoResponsesLocalDb> solicitudesAsalariado;

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
        return SolicitudesEnviadasAsalariadoWidget(
          solicitud: solicitudesAsalariado[index],
        );
      },
    );
  }
}

class _SolicitudesPendientesWidget extends StatelessWidget {
  final List<AsalariadoResponsesLocalDb> solicitudesAsalariado;
  const _SolicitudesPendientesWidget({
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
            'No hay solicitudes pendientes',
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
        return SolicitudesAsalariadoPendientesWidget(
          solicitud: solicitudesAsalariado[index],
        );
      },
    );
  }
}
