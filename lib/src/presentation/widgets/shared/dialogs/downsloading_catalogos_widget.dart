import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitud_catalogo/solicitud_catalogo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class DownsloadingCatalogosWidget extends StatefulWidget {
  final VoidCallback? onDownloadComplete;
  const DownsloadingCatalogosWidget({super.key, this.onDownloadComplete});

  @override
  State<DownsloadingCatalogosWidget> createState() =>
      _DownsloadingCatalogosWidgetState();
}

class _DownsloadingCatalogosWidgetState
    extends State<DownsloadingCatalogosWidget> {
  @override
  void initState() {
    context.read<SolicitudCatalogoCubit>().saveAllCatalogos(
          isConnected:
              context.read<InternetConnectionCubit>().state.isConnected,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SolicitudCatalogoCubit, SolicitudCatalogoState>(
        builder: (context, state) {
          return switch (state) {
            SolicitudCatalogoLoading() => const DownloadCatalogoLoading(
                lottieAsset: ImageAsset.downloadCatalogoLoading,
                text: 'Sincronizando...',
              ),
            SolicitudCatalogoSuccess() => DownloadCatalogoLoading(
                lottieAsset: ImageAsset.downloadCatalogosSuccess,
                text: 'Sincronización completada con éxito.',
                repeat: false,
                isSucess: true,
                onDownloadComplete: widget.onDownloadComplete,
              ),
            SolicitudCatalogoError() => Text('Error: ${state.error}'),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}

class DownloadCatalogoLoading extends StatelessWidget {
  final String lottieAsset;
  final String text;
  final bool? repeat;
  final bool? isSucess;
  final bool isUploadingForms;
  final VoidCallback? onDownloadComplete;
  const DownloadCatalogoLoading({
    super.key,
    required this.lottieAsset,
    required this.text,
    this.repeat = true,
    this.isSucess = false,
    this.isUploadingForms = false,
    this.onDownloadComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              lottieAsset,
              repeat: repeat,
              height: 200,
            ),
            const Gap(10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (isSucess ?? false) ...[
              const Gap(20),
              SizedBox(
                width: 200,
                child: CustomElevatedButton(
                  color: AppColors.getPrimaryColor(),
                  text: 'OK',
                  onPressed: onDownloadComplete ??
                      () {
                        if (isUploadingForms) {
                          return context.pushReplacement('/');
                        }
                        if (context.canPop()) return context.pop();
                        context.push('/');
                      },
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
