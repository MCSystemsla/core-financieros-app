import 'dart:io';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/upload_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;
  final XFile? selectedImage;
  const UploadImageWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.selectedImage,
  });

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(
            widget.title,
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
              onPressed: () => widget.onPressed(),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: widget.selectedImage != null
                      ? FadeInImage(
                          placeholder: const AssetImage(ImageAsset.loader),
                          image: FileImage(File(widget.selectedImage!.path)))
                      : SvgPicture.asset(
                          ImageAsset.imgForm,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectImageDialog(
      BuildContext context, Function(XFile) onSelected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UploadImageDialog(onSelected: onSelected);
      },
    );
  }
}
