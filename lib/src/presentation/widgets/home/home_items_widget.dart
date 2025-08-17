// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/catalogo_sync/catalogo_sync.dart';
import 'package:core_financiero_app/src/config/helpers/greeting/greeting.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/home/home_item_card.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/cartera_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/tutorials/tutorials_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeItemsWidget extends StatelessWidget {
  const HomeItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final actions = LocalStorage().currentActions;

    List<HomeItemCard> homeItemData = [
      if (actions.contains('MENUCARTERAMOVIL'))
        HomeItemCard(
          title: 'home.item5'.tr(),
          subtitle: 'Descripcion'.tr(),
          icon: const Icon(
            Icons.wallet_rounded,
            color: AppColors.white,
          ),
          color: AppColors.primaryColorWithOpacity(),
          onTap: () async {
            final shouldSync = CatalogoSync.needToSync();
            if (!context.mounted) return;
            if (shouldSync) {
              CustomAlertDialog(
                onDone: () => context.pop(),
                context: context,
                title: 'Necesitas Sincronizar para avanzar',
              ).showDialog(context);
            }
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CarteraScreen()),
            );
          },
        ),
      HomeItemCard(
        title: 'Tutoriales'.tr(),
        subtitle: 'Descripcion'.tr(),
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
      // HomeItemCard(
      //   title: 'Tutoriales'.tr(),
      //   subtitle: 'Descripcion'.tr(),
      //   icon: const Icon(
      //     Icons.account_balance,
      //     color: AppColors.white,
      //   ),
      //   color: AppColors.purple,
      //   onTap: () {},
      // ),
      // HomeItemCard(
      //   title: 'home.item2'.tr(),
      //   subtitle: 'Descripcion'.tr(),
      //   icon: const Icon(
      //     Icons.savings,
      //     color: AppColors.white,
      //   ),
      //   color: AppColors.cian,
      //   onTap: () => context.push('/ahorro'),
      // ),
      // HomeItemCard(
      //   title: 'home.item3'.tr(),
      //   subtitle: 'Descripcion'.tr(),
      //   icon: const Icon(
      //     Icons.calculate_rounded,
      //     color: AppColors.white,
      //   ),
      //   color: AppColors.getFourthgColorWithOpacity(),
      //   onTap: () => context.push('/pla'),
      // ),
    ];

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
              itemCount: homeItemData.length,
              itemBuilder: (BuildContext context, int index) => _ItemWidget(
                homeItemCard: homeItemData[index],
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const Gap(10),
          Text(
            '$greeting,',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Gap(5),
          Text(
            currentUserName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.getPrimaryColor(),
            ),
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
