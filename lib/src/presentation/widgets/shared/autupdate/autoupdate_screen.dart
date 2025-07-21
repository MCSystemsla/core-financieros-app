import 'dart:developer';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/result_model.dart';
import 'package:flutter_app_update/update_model.dart';
import 'package:gap/gap.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';

class AutoupdateScreen extends StatefulWidget {
  final String apkUrl;
  final String versionName;
  const AutoupdateScreen({
    super.key,
    required this.apkUrl,
    required this.versionName,
  });

  @override
  State<AutoupdateScreen> createState() => _AutoupdateScreenState();
}

class _AutoupdateScreenState extends State<AutoupdateScreen> {
  double _progress = 0;
  ResultType? resultType;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    _startUpdate();
    _listenToProgress();
  }

  @override
  void dispose() {
    AzhonAppUpdate.cancel;
    AzhonAppUpdate.dispose();
    super.dispose();
  }

  void _startUpdate() {
    final updateModel = UpdateModel(
      widget.apkUrl,
      '${widget.versionName}.apk',
      'ic_launcher',
      '',
      showBgdToast: false,
    );

    AzhonAppUpdate.update(updateModel).then((value) {
      debugPrint('✅ Actualización completada: $value');
    }).catchError((e) async {
      debugPrint('❌ Error durante la actualización: $e');
      if (!mounted) return;

      await ErrorReporter.registerError(
        errorMessage: 'Error en actualización: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
    });
  }

  _listenToProgress() {
    AzhonAppUpdate.listener((ResultModel model) {
      if (!mounted) return;

      setState(() {
        _progress = model.progress?.toDouble() ?? 0;
        resultType = model.type;
        errorMsg = model.type == ResultType.error ? model.exception : null;
      });

      log('⬇️ Progreso de descarga: $_progress bytes');
    });
  }

  void _retryUpdate() {
    setState(() {
      _progress = 0;
      resultType = null;
      errorMsg = null;
    });
    _startUpdate();
  }

  @override
  Widget build(BuildContext context) {
    const double estimatedTotalBytes = 98 * 1024 * 1024; // 98 MB aprox

    final double percentage =
        (_progress / estimatedTotalBytes * 100).clamp(0, 100);

    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.downloading_rounded,
                  size: 110,
                  color: AppColors.getPrimaryColor(),
                ),
                const Gap(20),
                Text(
                  resultType == ResultType.done
                      ? 'La aplicación se ha actualizado correctamente'
                      : 'Actualizando la aplicación, por favor no cierres la aplicación...',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(20),
                if (resultType == ResultType.downloading)
                  LinearProgressIndicator(
                    value: percentage / 100,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    color: AppColors.getPrimaryColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                if (resultType == ResultType.error) ...[
                  const Gap(20),
                  Text(
                    'Error al actualizar la aplicación:\n$errorMsg',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(20),
                  CustomElevatedButton(
                    text: 'Reintentar',
                    color: AppColors.getFourthgColorWithOpacity(),
                    onPressed: _retryUpdate,
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
