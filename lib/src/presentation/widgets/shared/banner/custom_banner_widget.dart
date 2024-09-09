import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CustomBannerWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final String image;
  const CustomBannerWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size.height * 0.2,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            ),
          ),
        ),
        Container(
          height: size.height * 0.2,
          width: size.width,
          color: Colors.black38,
        ),
        SafeArea(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                ),
              ),
              const Gap(10),
              CircleAvatar(
                maxRadius: 40,
                backgroundColor: AppColors.whiteWithOpacity14,
                child: icon,
              ),
              const Gap(25),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
