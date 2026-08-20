// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/greeting/greeting.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/home/home_item_card.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/cartera_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/otp/otp_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/tutorials/tutorials_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/push_with_sync_check/push_with_sync_check.dart';
import 'package:core_financiero_app/src/utils/extensions/type_action/type_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeItemsWidget extends StatelessWidget {
  const HomeItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final connection = context.read<InternetConnectionCubit>().state;
    final actions = LocalStorage().currentActions;
    final flavor = global<FlavorCubit>().state.flavor;

    List<HomeItemCard> homeItemData = [
      HomeItemCard(
        visible: actions.contains(TypeAction.menuCartera.codigo),
        title: 'home.item5'.tr(),
        subtitle: 'Solicitudes, análisis y comité',
        icon: const Icon(
          Icons.account_balance_wallet_outlined,
          color: AppColors.white,
          size: 22,
        ),
        color: const Color(0xff3FB6A8),
        gradientColor: const Color(0xff2E9C93),
        onTap: () => context.pushWithSyncCheck(
          connectionStatus: connection.connectionStatus,
          destination: const CarteraScreen(),
        ),
      ),
      HomeItemCard(
        visible: (connection.connectionStatus == ConnectionStatus.connected &&
            flavor == Flavor.honduras &&
            actions.contains(TypeAction.moduloOtp.codigo)),
        title: 'OTP',
        subtitle: 'Validación del cliente',
        icon: const Icon(
          Icons.phone_iphone_rounded,
          color: AppColors.white,
          size: 22,
        ),
        color: const Color(0xff7A3FD4),
        gradientColor: const Color(0xff6A2FC4),
        onTap: () => context.pushWithSyncCheck(
          connectionStatus: connection.connectionStatus,
          destination: const OtpScreen(),
        ),
      ),
      HomeItemCard(
        visible: (connection.connectionStatus == ConnectionStatus.connected &&
            (flavor == Flavor.nicaragua || flavor == Flavor.costaRica)),
        title: 'Tutoriales',
        subtitle: 'Guías de uso de la app',
        icon: const Icon(
          Icons.play_circle_outline_rounded,
          color: AppColors.white,
          size: 22,
        ),
        color: const Color(0xff4C5DD1),
        gradientColor: const Color(0xff3B49B0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TutorialsScreen(),
            ),
          );
        },
      ),
    ];
    final visibleItems = homeItemData.where((e) => e.visible).toList();

    if (visibleItems.isEmpty) {
      return const EmptyListWidget(
        message:
            'No tienes ningun permiso para acceder a los servicios de la aplicación.',
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _GreetingsWidget(),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 12),
            child: Text(
              'MÓDULOS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: Color(0xff8A7F72),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.86,
              ),
              itemCount: visibleItems.length,
              itemBuilder: (BuildContext context, int index) => _ItemWidget(
                homeItemCard: visibleItems[index],
              ),
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}

class _GreetingsWidget extends StatelessWidget {
  const _GreetingsWidget();

  @override
  Widget build(BuildContext context) {
    final (greeting, icon) = getGreetings();
    final currentUserName = LocalStorage().currentUserName;
    final currentRoUser = LocalStorage().rolUser;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6), // toque sutil
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          const Gap(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Gap(2),
              Text(
                currentUserName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getPrimaryColor(),
                ),
              ),
              const Gap(2),
              Text(
                currentRoUser,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final HomeItemCard homeItemCard;
  const _ItemWidget({
    required this.homeItemCard,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = homeItemCard.color;
    final endColor = homeItemCard.gradientColor ??
        Color.lerp(baseColor, Colors.black, 0.18)!;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [baseColor, endColor],
          ),
          boxShadow: [
            BoxShadow(
              color: baseColor.withOpacity(0.32),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => homeItemCard.onTap(),
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Badge(
                    isLabelVisible: false,
                    smallSize: 11,
                    backgroundColor: const Color(0xffCE1818),
                    child: homeItemCard.icon,
                  ),
                ),
                const Spacer(),
                Text(
                  homeItemCard.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const Gap(4),
                Text(
                  homeItemCard.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.85),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
