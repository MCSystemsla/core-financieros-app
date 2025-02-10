import 'package:core_financiero_app/src/config/helpers/catalogo_sync/catalogo_sync.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
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
    final shouldSync = CatalogoSync.needToSync();
    if (shouldSync) {
      return const DownsloadingCatalogosWidget();
    }
    return Scaffold(
      floatingActionButton: isConnected
          ? FloatingActionButton.extended(
              label: const Row(
                children: [
                  Icon(Icons.update_rounded),
                  Gap(5),
                  Text('Sincronizar'),
                ],
              ),
              onPressed: () => {
                context
                    .pushTransparentRoute(const DownsloadingCatalogosWidget()),
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
