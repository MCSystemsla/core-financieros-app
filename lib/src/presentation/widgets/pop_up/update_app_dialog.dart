import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/autupdate/autoupdate_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/update_model.dart';

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
      // TODO: ARREGLAR AUTOUPDATER PARA LA NUEVA VERSION
      CustomElevatedButton(
        text: 'Actualizar'.tr(),
        color: AppColors.getPrimaryColor(),
        onPressed: () {
          UpdateModel model = UpdateModel(
            apkUrl,
            '$versionName.apk',
            'ic_launcher',
            '',
            showBgdToast: false,
          );
          AzhonAppUpdate.update(model).then((value) {
            debugPrint('Resultado de la actualización: $value');
          }).catchError((e) async {
            debugPrint('Error de la actualización de la aplicación: $e');
            await ErrorReporter.registerError(
              errorMessage: 'Error de la actualización de la aplicación: $e',
              statusCode: '400',
              username: LocalStorage().currentUserName,
            );
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AutoupdateScreen()),
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
