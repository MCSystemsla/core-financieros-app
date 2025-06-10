import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';

class NoImagesKivaSendedDialog extends OdsDialog {
  @override
  // ignore: overridden_fields
  final String title;
  const NoImagesKivaSendedDialog({
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
        text: 'Volver a intentarlo',
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
  }) {
    return super.showDialog(
      context,
      animType: animType,
      dialogType: dialogType,
    );
  }
}
