// ignore_for_file: deprecated_member_use
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/greeting/greeting.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/home/home_item_card.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
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
        subtitle: 'Descripcion',
        icon: const Icon(
          Icons.wallet_rounded,
          color: AppColors.white,
        ),
        color: AppColors.primaryColorWithOpacity(),
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
        subtitle: 'Descripcion',
        icon: const Icon(
          Icons.phone_android,
          color: AppColors.white,
        ),
        color: Colors.deepPurple,
        onTap: () => context.pushWithSyncCheck(
          connectionStatus: connection.connectionStatus,
          destination: const OtpScreen(),
        ),
      ),
      HomeItemCard(
        visible: (connection.connectionStatus == ConnectionStatus.connected &&
            (flavor == Flavor.nicaragua || flavor == Flavor.costaRica)),
        title: 'Tutoriales',
        subtitle: 'Descripcion',
        icon: const Icon(
          Icons.assignment,
          color: AppColors.white,
        ),
        color: AppColors.blueIndigo,
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
          Container(
            margin: const EdgeInsets.all(5),
            child: GridView.builder(
              padding: const EdgeInsets.all(2),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: visibleItems.length,
              itemBuilder: (BuildContext context, int index) => _ItemWidget(
                homeItemCard: visibleItems[index],
              ),
            ),
          ),
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
    return InkWell(
      onTap: () => homeItemCard.onTap(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: 150,
            width: 136,
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage(ImageAsset.homeItemBg),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: homeItemCard.color,
            ),
            height: 150,
            width: 136,
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.14),
                  child: Badge(
                    isLabelVisible: false,
                    smallSize: 11,
                    backgroundColor: const Color(0xffCE1818),
                    child: homeItemCard.icon,
                  ),
                ),
                Text(
                  homeItemCard.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  homeItemCard.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
