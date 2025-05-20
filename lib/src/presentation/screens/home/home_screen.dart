import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/catalogo_sync/catalogo_sync.dart';
import 'package:core_financiero_app/src/presentation/bloc/biometric/biometric_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_banner_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_items_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final bioProvider = global<BiometricCubit>();

    if (!bioProvider.state.isAuthenticated) {
      bioProvider.authenticate(context);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.read<InternetConnectionCubit>().state;
    final shouldSync = CatalogoSync.needToSync();
    if (shouldSync && isConnected.isConnected) {
      return DownsloadingCatalogosWidget(
        onDownloadComplete: () {
          global<BiometricCubit>().authenticate(context);
          context.push('/');
        },
      );
    }
    return BlocConsumer<BiometricCubit, BiometricState>(
      bloc: global<BiometricCubit>(),
      listener: (context, state) {
        if (!state.isAuthenticated) {
          global<BiometricCubit>().authenticate(context);
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            floatingActionButton: isConnected.isConnected
                ? FloatingActionButton.extended(
                    label: const Row(
                      children: [
                        Icon(Icons.update_rounded),
                        Gap(5),
                        Text('Sincronizar'),
                      ],
                    ),
                    onPressed: () => {
                      context.pushTransparentRoute(
                          const DownsloadingCatalogosWidget()),
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
          ),
        );
      },
    );
  }
}
