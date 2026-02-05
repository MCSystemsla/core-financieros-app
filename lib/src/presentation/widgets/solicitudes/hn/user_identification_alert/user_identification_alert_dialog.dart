import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/solicitudes/hn/cubit/user_have_cedula/user_have_cedula_cubit.dart';

class UserIdentificationAlertDialog extends StatelessWidget {
  const UserIdentificationAlertDialog({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              ImageAsset.identification,
              height: 180,
            ),
            const Gap(25),
            Text(
              'Este usuario tiene ya una identificacion ingresada',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(16),
            Text(
              'Este usuario posee un documento de identificación previamente almacenado.',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const Gap(30),
            CustomElevatedButton(
              onPressed: () {
                context
                    .read<UserHaveCedulaCubit>()
                    .isUserSelectionUpdateImage(true);
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              text: 'Actualizar Imagenes de Identificacion',
              color: AppColors.getPrimaryColor(),
            ),
            const Gap(10),
            CustomElevatedButton(
              onPressed: () {
                context
                    .read<UserHaveCedulaCubit>()
                    .isUserSelectionUpdateImage(false);
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              text: 'No deseo actualizar',
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
