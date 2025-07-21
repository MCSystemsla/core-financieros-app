import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/autupdate/autoupdate_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';

class UpdateAppDialog extends OdsDialog {
  @override
  // ignore: overridden_fields
  final String title;
  final String versionName;
  final String apkUrl;
  const UpdateAppDialog({
    super.key,
    required this.context,
    required this.title,
    required this.versionName,
    required this.apkUrl,
  }) : super(
          title: title,
        );

  final BuildContext context;

  @override
  List<CustomElevatedButton>? actions(BuildContext context) {
    return [
      CustomElevatedButton(
        text: 'Actualizar'.tr(),
        color: AppColors.getPrimaryColor(),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AutoupdateScreen(
                apkUrl: apkUrl,
                versionName: versionName,
              ),
            ),
          );
        },
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
