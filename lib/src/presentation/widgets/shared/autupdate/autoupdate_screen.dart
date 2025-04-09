import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/result_model.dart';

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
      log('Progreso de la actualización: ${model.progress?.toString().substring(0, 2)}%');
      progress = model.progress?.toString().substring(0, 2) ?? '0%';
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
          child: Text('Actualizando... ${progress.toString().substring(0, 2)}'),
        ),
      ),
    );
  }
}
