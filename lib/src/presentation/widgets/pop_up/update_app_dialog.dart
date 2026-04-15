import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/autupdate/autoupdate_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAppDialog extends OdsDialog {
  @override
  // ignore: overridden_fields
  final String title;
  final String versionName;
  final String apkUrl;
  final Flavor flavor;
  const UpdateAppDialog({
    super.key,
    required this.context,
    required this.title,
    required this.versionName,
    required this.apkUrl,
    required this.flavor,
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
        onPressed: () async {
          const playStoreUrls = {
            Flavor.honduras:
                'https://play.google.com/store/apps/details?id=com.mcsystem.core_financiero_app.hnd',
            Flavor.nicaragua:
                'https://play.google.com/store/apps/details?id=com.mcsystem.core_financiero_app.ni',
            Flavor.costaRica:
                'https://play.google.com/store/apps/details?id=com.mcsystem.core_financiero_app.cr',
          };

          final url = playStoreUrls[flavor];

          if (url != null) {
            await openGooglePlayUpdate(url: url);
            return;
          }
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
    DialogType dialogType = DialogType.infoReverse,
    Widget? customHeader,
    bool dismissOnBackKeyPress = true,
  }) {
    return super.showDialog(
      context,
      animType: animType,
      dialogType: dialogType,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
    );
  }
}

Future<void> openGooglePlayUpdate({required String url}) async {
  final Uri playStoreUrl = Uri.parse(url);

  final canLaunch = await canLaunchUrl(playStoreUrl);
  if (!canLaunch) return; // Si no se puede abrir, simplemente sale

  await launchUrl(
    playStoreUrl,
    mode:
        LaunchMode.externalApplication, // Intenta abrir en la app de Play Store
  );
}
