// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/banner/custom_banner_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/pinput/custom_pinput_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CarteraScreen extends StatefulWidget {
  const CarteraScreen({super.key});

  @override
  State<CarteraScreen> createState() => _CarteraScreenState();
}

class _CarteraScreenState extends State<CarteraScreen> {
  // @override
  // void initState() {
  //   final isInternetConnectionProvider =
  //       context.read<InternetConnectionCubit>();
  //   isInternetConnectionProvider.getInternetStatusConnection();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final actions = LocalStorage().currentActions;
    final isInternetConnection =
        context.read<InternetConnectionCubit>().state.isConnected;
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.push('/');
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBannerWidget(
                icon: const Icon(
                  Icons.wallet_rounded,
                  color: AppColors.white,
                ),
                title: 'home.item5'.tr(),
                image: ImageAsset.carteraBg,
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'cartera.description'.tr(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 19,
                      ),
                ),
              ),
              // _Card(
              //   onTap: () => context.push('/credito'),
              //   title: 'cartera.credit'.tr(),
              //   subtitle: 'cartera.credit_title'.tr(),
              //   firstColor: AppColors.getSecondaryColor(),
              //   secondColor: AppColors.getPrimaryColor().withOpacity(0.4),
              //   icon: const Icon(
              //     Icons.credit_card,
              //     color: AppColors.white,
              //     size: 35,
              //   ),
              // ),
              // TODO: CAMBIAR ESTO CUANDO SALGA SOLICITUDES
              // _Card(
              //   onTap: () {
              //     context.push('/solicitudes');
              //   },
              //   title: 'Solicitudes',
              //   subtitle: 'Modulo Solicitudes de Credito',
              //   firstColor: AppColors.blueIndigo,
              //   secondColor: AppColors.getPrimaryColor().withOpacity(0.4),
              //   icon: const Icon(
              //     Icons.description,
              //     color: AppColors.white,
              //     size: 35,
              //   ),
              // ),
              if (actions.contains('LLENARKIVAMOVIL'))
                _Card(
                  onTap: () async {
                    if (!context.mounted) return;
                    isInternetConnection
                        ? context.push('/cartera/formulario-kiva')
                        : context.push('/cartera/kiva-offline');
                  },
                  title: 'cartera.kiva'.tr(),
                  subtitle: 'cartera.kiva_description'.tr(),
                  firstColor: AppColors.blueIndigo,
                  secondColor:
                      AppColors.getFourthgColorWithOpacity().withOpacity(0.4),
                  icon: const Icon(
                    Icons.dynamic_form_outlined,
                    color: AppColors.white,
                    size: 35,
                  ),
                ),
              if (isInternetConnection && actions.contains('LLENARKIVAMOVIL'))
                _Card(
                  onTap: () {
                    context.pushTransparentRoute(const CustomPinputWidget());
                  },
                  title: 'KIVA Histórico',
                  subtitle: 'Modulo Solicitudes Kiva Enviadas',
                  firstColor: AppColors.blueIndigo,
                  secondColor: AppColors.getSecondaryColor().withOpacity(0.4),
                  icon: const Icon(
                    Icons.send_to_mobile_rounded,
                    color: AppColors.white,
                    size: 35,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  final Color firstColor;
  final Color secondColor;
  final VoidCallback onTap;
  const _Card({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.firstColor,
    required this.secondColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.all(14),
      width: size.width,
      height: 200,
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          shadowColor: AppColors.primaryColorWithOpacity(),
          foregroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: firstColor,
                  ),
                ),
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(130),
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: secondColor,
                  ),
                ),
                SizedBox(
                  height: height,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        icon,
                        const Gap(7),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          width: size.width * 0.95,
                          child: Text(
                            subtitle,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
