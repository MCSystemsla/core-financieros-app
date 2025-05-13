import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/slide_pageview_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_pendientes/solicitudes_pendientes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SolicitudesAsalariadoPendientesItems extends StatelessWidget {
  final PageController controller;
  final List<AsalariadoResponsesLocalDb> solicitudesAsalariado;
  const SolicitudesAsalariadoPendientesItems({
    super.key,
    required this.controller,
    required this.solicitudesAsalariado,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(15),
        SlidePageviewView(
          controller: controller,
          title: 'Solicitudes Asalariado',
        ),
        solicitudesAsalariado.isEmpty
            ? Expanded(
                child: Column(
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
                ),
              )
            : Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: solicitudesAsalariado.length,
                  itemBuilder: (_, int index) {
                    return SolicitudesAsalariadoPendientesWidget(
                      solicitud: solicitudesAsalariado[index],
                    );
                  },
                ),
              ),
      ],
    );
  }
}
