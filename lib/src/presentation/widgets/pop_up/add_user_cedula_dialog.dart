import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddUserCedulaDialog extends OdsDialog {
  @override
  // ignore: overridden_fields
  final String title;
  const AddUserCedulaDialog({
    super.key,
    this.onDone,
    required this.context,
    required this.title,
  }) : super(
          title: title,
        );

  final VoidCallback? onDone;
  final BuildContext context;

  @override
  List<CustomElevatedButton>? actions(BuildContext context) {
    return [
      CustomElevatedButton(
        text: 'Ir a Formulario'.tr(),
        color: AppColors.getPrimaryColor(),
        onPressed: onDone,
      ),
      CustomElevatedButton(
        text: 'Regresar'.tr(),
        color: AppColors.red,
        onPressed: () => context.pop(),
      ),
    ];
  }

  @override
  Future showDialog(
    BuildContext context, {
    AnimType animType = AnimType.scale,
    DialogType dialogType = DialogType.warning,
    Widget? customHeader,
  }) {
    return super.showDialog(
      context,
      animType: animType,
      dialogType: dialogType,
    );
  }
}
