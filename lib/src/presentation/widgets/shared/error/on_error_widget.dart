import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class OnErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String errorMsg;
  final List<String> errors;
  final bool needToGoBack;
  final String btnTitle;
  const OnErrorWidget({
    super.key,
    required this.onPressed,
    this.errorMsg = '',
    this.needToGoBack = false,
    this.btnTitle = 'Volver a intentarlo',
    this.errors = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            ImageAsset.error,
            width: 280,
          ),
          const Gap(5),
          Text(
            'Ha ocurrido un error. Por favor, inténtalo de nuevo.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Gap(5),
          Text(
            '$errorMsg\n${errors.isNotEmpty ? errors.join('\n') : ''}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomElevatedButton(
              onPressed: onPressed,
              text: btnTitle,
              color: AppColors.getPrimaryColor(),
            ),
          ),
          if (needToGoBack) ...[
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomElevatedButton(
                onPressed: () => context.pop(),
                text: 'Regresar',
                color: AppColors.getSecondaryColor(),
              ),
            )
          ],
        ],
      ),
    );
  }
}
