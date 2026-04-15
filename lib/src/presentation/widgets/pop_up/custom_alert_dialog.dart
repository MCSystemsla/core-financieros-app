import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends OdsDialog {
  @override
  // ignore: overridden_fields
  final String title;
  @override
  // ignore: overridden_fields
  final String subtitle;
  const CustomAlertDialog({
    super.key,
    this.onDone,
    required this.context,
    required this.title,
    this.subtitle = '',
  }) : super(
          title: title,
          subtitle: subtitle,
        );

  final VoidCallback? onDone;
  final BuildContext context;

  @override
  List<CustomElevatedButton>? actions(BuildContext context) {
    return [
      CustomElevatedButton(
        text: 'Ok'.tr(),
        color: AppColors.getPrimaryColor(),
        onPressed: onDone,
      ),
    ];
  }

  @override
  Future showDialog(
    BuildContext context, {
    AnimType animType = AnimType.scale,
    DialogType dialogType = DialogType.warning,
    Widget? customHeader,
    bool dismissOnBackKeyPress = true,
  }) {
    return super.showDialog(
      context,
      animType: animType,
      dialogType: dialogType,
    );
  }
}
