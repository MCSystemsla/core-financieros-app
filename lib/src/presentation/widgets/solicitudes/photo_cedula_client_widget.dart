import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PhotoCedulaClientWidget extends StatelessWidget {
  const PhotoCedulaClientWidget({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(30),
          UploadImageWidget(
            // selectedImage: ,
            onPressed: () {},
            title: 'Foto Cedula Frontal',
          ),
          const Gap(30),
          UploadImageWidget(
            title: 'Foto Cedula Trasera',
            onPressed: () {},
          ),
          const Gap(30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: CustomElevatedButton(
              text: 'Siguiente',
              // ignore: deprecated_member_use
              color: AppColors.greenLatern.withOpacity(0.4),
              onPressed: () async {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomOutLineButton(
              onPressed: () {
                context.pushReplacement('/solicitudes');
              },
              text: 'Cancelar',
              textColor: AppColors.red,
              color: AppColors.red,
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
