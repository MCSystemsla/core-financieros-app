import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UploadImageWidget extends StatelessWidget {
  final String title;
  const UploadImageWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(15),
          SizedBox(
            height: size.height * .18,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.getPrimaryColor(),
                surfaceTintColor: AppColors.lightGray,
                backgroundColor: AppColors.lightGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: AppColors.lightGray,
                    width: 1,
                  ),
                ),
              ),
              onPressed: () {},
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: const Image(
                    width: 150,
                    height: double.infinity,
                    image: AssetImage(
                      ImageAsset.imgForm,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
