import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitud_catalogo/solicitud_catalogo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class DownsloadingCatalogosWidget extends StatelessWidget {
  const DownsloadingCatalogosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SolicitudCatalogoCubit, SolicitudCatalogoState>(
        builder: (context, state) {
          return switch (state) {
            SolicitudCatalogoLoading() => const DownloadCatalogoLoading(
                lottieAsset: 'assets/images/save_catalogos.json',
                text: 'Sincronizando...',
              ),
            SolicitudCatalogoSuccess() => const DownloadCatalogoLoading(
                lottieAsset: 'assets/images/success2_catalogo.json',
                text: 'Sincronización completada con éxito.',
                repeat: false,
                isSucess: true,
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
  const DownloadCatalogoLoading({
    super.key,
    required this.lottieAsset,
    required this.text,
    this.repeat = true,
    this.isSucess = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
                onPressed: () {
                  context.pop();
                },
              ),
            )
          ]
        ],
      ),
    );
  }
}
