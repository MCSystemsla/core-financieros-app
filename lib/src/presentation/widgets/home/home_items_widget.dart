import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/home/home_item_card.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeItemsWidget extends StatelessWidget {
  const HomeItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<HomeItemCard> homeItemData = [
      HomeItemCard(
        title: 'home.item5'.tr(),
        subtitle: 'Descripcion'.tr(),
        icon: const Icon(
          Icons.wallet_rounded,
          color: AppColors.white,
        ),
        color: AppColors.primaryColorWithOpacity(),
        onTap: () => context.push('/cartera'),
      ),
      // HomeItemCard(
      //   title: 'home.item1'.tr(),
      //   subtitle: 'Descripcion'.tr(),
      //   icon: const Icon(
      //     Icons.account_balance,
      //     color: AppColors.white,
      //   ),
      //   color: AppColors.purple,
      //   onTap: () => context.push('/tesoreria'),
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
      // HomeItemCard(
      //   title: 'home.item4'.tr(),
      //   subtitle: 'Descripcion'.tr(),
      //   icon: const Icon(
      //     Icons.assignment,
      //     color: AppColors.white,
      //   ),
      //   color: AppColors.blueIndigo,
      //   onTap: () => context.push('/requerimiento'),
      // ),
    ];

    return SingleChildScrollView(
      child: Container(
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
