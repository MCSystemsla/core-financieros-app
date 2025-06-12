import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'autoupdate_state.dart';

class AutoupdateCubit extends Cubit<AutoupdateState> {
  AutoupdateCubit() : super(AutoupdateInitial());

  Future<void> verificarActualizacion(BuildContext context) async {
    const String versionJsonUrl = String.fromEnvironment('versionUrl');

    if (versionJsonUrl.isEmpty) {
      log('URL de versión no definida');
      return;
    }

    emit(AutoupdateLoading());

    try {
      final response = await http.get(Uri.parse(versionJsonUrl));

      if (response.statusCode != 200) {
        log('Error al obtener versión: código ${response.statusCode}');
        emit(AutoupdateError());
        return;
      }

      final data = json.decode(response.body);
      final nuevaVersion = data['version']?.toString();
      final apkUrl = data['apkUrl']?.toString();

      if (nuevaVersion == null || apkUrl == null) {
        log('Formato JSON inválido');
        emit(AutoupdateError());
        return;
      }

      final info = await PackageInfo.fromPlatform();
      final versionActual = info.version;
      log('Versión actual: $versionActual - Nueva versión: $nuevaVersion');

      if (nuevaVersion != versionActual) {
        if (!context.mounted) return;

        emit(AutoupdateSuccess(
          apkVersion: apkUrl,
          apkVersionName: nuevaVersion,
        ));
        await registerUserAreUpdatedVersion(version: nuevaVersion);
        return;
      }
      emit(AutoupdateFoundVersion(versionName: versionActual));
    } catch (e, stack) {
      log('Excepción al verificar actualización $e',
          error: e, stackTrace: stack);
      emit(AutoupdateError());
    }
  }

  Future<void> registerUserAreUpdatedVersion({
    required String version,
  }) async {
    const String versionJsonUrl =
        'https://script.google.com/macros/s/AKfycbw3NKCUx8wj2BhiIdvJwfTPHW905PCqMlchLNP80nXY4wUTPuOa2Y1IihsbXjRIDp23jQ/exec';
    await http.post(
      Uri.parse(versionJsonUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {'version': version},
      ),
    );
  }
}
