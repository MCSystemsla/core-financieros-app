import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/result_model.dart';
import 'package:gap/gap.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';

class AutoupdateScreen extends StatefulWidget {
  const AutoupdateScreen({super.key});

  @override
  State<AutoupdateScreen> createState() => _AutoupdateScreenState();
}

class _AutoupdateScreenState extends State<AutoupdateScreen> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();

    // Escuchamos progreso de descarga
    AzhonAppUpdate.listener((ResultModel model) {
      if (!mounted) return;
      setState(() {
        _progress = model.progress?.toDouble() ?? 0;
      });
      log('Progreso de la actualización: $_progress%');
    });
  }

  @override
  void dispose() {
    AzhonAppUpdate.cancel;
    AzhonAppUpdate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double estimatedTotalBytes = 100 * 1024 * 1024; // 100 MB aprox

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
                  'Actualizando la aplicación...',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(20),
                LinearProgressIndicator(
                  value: percentage / 100,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  color: AppColors.getPrimaryColor(),
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
