import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitud_catalogo/solicitud_catalogo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_banner_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_items_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    return Scaffold(
      floatingActionButton: isConnected
          ? FloatingActionButton.extended(
              label: const Row(
                children: [
                  Icon(Icons.document_scanner_outlined),
                  Gap(5),
                  Text('Descargar Catalogos'),
                ],
              ),
              onPressed: () => {
                context
                    .pushTransparentRoute(const DownsloadingCatalogosWidget()),
                context.read<SolicitudCatalogoCubit>().saveAllCatalogos(
                      isConnected: isConnected,
                    ),
              },
            )
          : const SizedBox(),
      body: const Column(
        children: [
          HomeBannerWidget(),
          Expanded(
            child: HomeItemsWidget(),
          ),
        ],
      ),
    );
  }
}
