import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/catalogo_sync/catalogo_sync.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/biometric/biometric_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/device_storage/device_storage_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/no_images_kivas_on_history/no_images_kivas_on_history_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_banner_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_items_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/low_storage_warning/low_storage_warning_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/alert/no_images_kivas_on_history_alert.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/download_catalogos_dialog_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isChecking = true;
  bool _shouldSync = false;

  @override
  void initState() {
    super.initState();
    _checkRequirements();
  }

  Future<void> _checkRequirements() async {
    final bioCubit = global<BiometricCubit>();
    final connection = context.read<InternetConnectionCubit>().state;

    if (!bioCubit.state.isAuthenticated) {
      await bioCubit.authenticate(context);
    }

    if (!mounted || !bioCubit.state.isAuthenticated) return;

    final needsSync = CatalogoSync.needToSync();

    setState(() {
      _shouldSync = needsSync &&
          connection.connectionStatus == ConnectionStatus.connected;
      _isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flavor = global<FlavorCubit>().state.flavor;

    if (_isChecking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_shouldSync) {
      return saveCatalogoByFlavor(
        context,
        flavor: flavor,
        onDownloadComplete: () {
          setState(() {
            _shouldSync = false;
            _isChecking = false;
          });
        },
      );
    }
    return BlocBuilder<BiometricCubit, BiometricState>(
      bloc: global<BiometricCubit>(),
      builder: (context, state) {
        return BlocBuilder<DeviceStorageCubit, DeviceStorageState>(
          builder: (context, state) {
            return switch (state.isStorageFull) {
              // StorageDeviceStatus.full => _HomeScreenView(),
              StorageDeviceStatus.full => LowStorageWarning(
                  freeStorage: state.freeStorage,
                  totalStorage: state.totalStorage / 1000,
                  usedStoragePercent: state.usedStoragePercent,
                ),
              StorageDeviceStatus.available => _HomeScreenView(),
              StorageDeviceStatus.userGetContinue => _HomeScreenView(),
              _ => const SizedBox(),
            };
          },
        );
      },
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flavor = global<FlavorCubit>().state.flavor;
    final isConnected = context.read<InternetConnectionCubit>().state;

    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (ctx) => NoImagesKivasOnHistoryCubit(
          ResponsesRepositoryImpl(),
        )..getNoImagesKivasOnHistory(),
        child: Scaffold(
          floatingActionButton:
              isConnected.connectionStatus == ConnectionStatus.connected
                  ? SlideInUp(
                      child: FloatingActionButton.extended(
                        label: const Row(
                          children: [
                            Icon(Icons.sync_rounded),
                            Gap(6),
                            Text('Sincronizar'),
                          ],
                        ),
                        onPressed: () {
                          context.pushTransparentRoute(
                            saveCatalogoByFlavor(
                              context,
                              flavor: flavor,
                              onDownloadComplete: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
          body: BlocBuilder<NoImagesKivasOnHistoryCubit,
              NoImagesKivasOnHistoryState>(
            builder: (context, state) {
              return switch (state) {
                OnNoImagesKivasOnHistoryHaveRequestPending() =>
                  NoImagesKivasOnHistoryAlert(
                    solicitudesKivaPending: state.data.data!.length,
                  ),
                _ => FadeIn(
                    child: const Column(
                      children: [
                        HomeBannerWidget(),
                        Expanded(
                          child: HomeItemsWidget(),
                        ),
                      ],
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}

Widget saveCatalogoByFlavor(
  BuildContext context, {
  required Flavor flavor,
  required VoidCallback onDownloadComplete,
}) {
  return switch (flavor) {
    Flavor.nicaragua => DownsloadingCatalogosWidget(
        onDownloadComplete: onDownloadComplete,
      ),
    Flavor.costaRica => DownsloadingCatalogosWidget(
        onDownloadComplete: onDownloadComplete,
      ),
    Flavor.honduras => DownloadCatalogosDialogHn(
        onDownloadComplete: onDownloadComplete,
      ),
    _ => throw Exception('No se reconoce el flavor: $flavor'),
  };
}
