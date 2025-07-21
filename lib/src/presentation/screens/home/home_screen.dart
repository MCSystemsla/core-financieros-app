import 'package:animate_do/animate_do.dart';
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

    final shouldSync = CatalogoSync.needToSync();

    setState(() {
      _shouldSync = shouldSync && connection.isConnected;
    });

    if (!_shouldSync && !bioCubit.state.isAuthenticated) {
      await bioCubit.authenticate(context);
    }

    setState(() {
      _isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.read<InternetConnectionCubit>().state;
    if (_isChecking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_shouldSync) {
      return DownsloadingCatalogosWidget(
        onDownloadComplete: () {
          global<BiometricCubit>().authenticate(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
          setState(() {
            _shouldSync = false;
          });
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
            floatingActionButton:
                isConnected.connectionStatus == ConnectionStatus.connected
                    ? SlideInUp(
                        child: FloatingActionButton.extended(
                          label: const Row(
                            children: [
                              Icon(Icons.update_rounded),
                              Gap(5),
                              Text('Sincronizar'),
                            ],
                          ),
                          onPressed: () => {
                            context.pushTransparentRoute(
                              DownsloadingCatalogosWidget(
                                onDownloadComplete: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          },
                        ),
                      )
                    : const SizedBox(),
            body: FadeIn(
              child: const Column(
                children: [
                  HomeBannerWidget(),
                  Expanded(
                    child: HomeItemsWidget(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
