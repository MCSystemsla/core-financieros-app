import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
        },
      ),
    ];
  }

  @override
  Future showDialog(
    BuildContext context, {
    AnimType animType = AnimType.scale,
    DialogType dialogType = DialogType.noHeader,
    Widget? customHeader,
    bool dismissOnBackKeyPress = true,
  }) {
    return AwesomeDialog(
      context: context,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      headerAnimationLoop: false,
      animType: animType,
      dialogType: dialogType,
      customHeader: customHeader,
      dialogBorderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.zero,
      body: _UpdateAppDialogBody(dialog: this),
    ).show();
  }
}

/// Cuerpo visual del diálogo de actualización obligatoria (rediseño 2026).
///
/// Solo presentación: la acción del botón sigue siendo la que devuelve
/// [UpdateAppDialog.actions].
class _UpdateAppDialogBody extends StatefulWidget {
  final UpdateAppDialog dialog;
  const _UpdateAppDialogBody({required this.dialog});

  @override
  State<_UpdateAppDialogBody> createState() => _UpdateAppDialogBodyState();
}

class _UpdateAppDialogBodyState extends State<_UpdateAppDialogBody> {
  String? _installedVersion;

  @override
  void initState() {
    super.initState();
    _loadInstalledVersion();
  }

  Future<void> _loadInstalledVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() => _installedVersion = info.version);
    } catch (_) {
      // Sin la versión instalada el diálogo muestra solo la versión nueva.
    }
  }

  @override
  Widget build(BuildContext context) {
    final action = widget.dialog.actions(context)?.firstOrNull;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              height: 52,
              width: 52,
              decoration: const BoxDecoration(
                color: RedesignColors.greenTint,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.system_update,
                size: 25,
                color: RedesignColors.green,
              ),
            ),
          ),
          const Gap(14),
          const Text(
            'Actualiza para continuar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              height: 1.25,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              color: RedesignColors.ink,
            ),
          ),
          const Gap(10),
          _VersionPair(
            installed: _installedVersion,
            newVersion: widget.dialog.versionName,
          ),
          const Gap(10),
          Text(
            widget.dialog.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: RedesignColors.inkMuted,
            ),
          ),
          if (action != null) ...[
            const Gap(18),
            action,
          ],
        ],
      ),
    );
  }
}

class _VersionPair extends StatelessWidget {
  final String? installed;
  final String newVersion;
  const _VersionPair({required this.installed, required this.newVersion});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (installed != null) ...[
          Text(
            installed!,
            style: const TextStyle(
              fontSize: 12.5,
              color: RedesignColors.inkMuted,
              decoration: TextDecoration.lineThrough,
              decorationColor: RedesignColors.chevron,
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 17,
            color: RedesignColors.chevron,
          ),
        ],
        Text(
          newVersion,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: RedesignColors.green,
          ),
        ),
      ],
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
