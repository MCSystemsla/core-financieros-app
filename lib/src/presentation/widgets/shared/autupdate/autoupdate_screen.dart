import 'dart:developer';

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/result_model.dart';
import 'package:gap/gap.dart';

class AutoupdateScreen extends StatefulWidget {
  const AutoupdateScreen({super.key});

  @override
  State<AutoupdateScreen> createState() => _AutoupdateScreenState();
}

class _AutoupdateScreenState extends State<AutoupdateScreen> {
  String progress = '0%';
  @override
  void initState() {
    AzhonAppUpdate.listener((ResultModel model) {
      progress = model.progress.toString();
      log('Progreso de la actualización: $progress');
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    AzhonAppUpdate.cancel;
    AzhonAppUpdate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.downloading_sharp,
                size: 110,
                color: AppColors.getPrimaryColor(),
              ),
              const Gap(20),
              Text(
                'Actualizando... ${progress.toString().substring(0, 2)}%',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
