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
    const String versionJsonUrl =
        'https://drive.google.com/uc?export=download&id=1S5Tt-AdrbsKwRp_XBq7K2xRrlRMKJ_Lb';

    try {
      emit(AutoupdateLoading());
      final response = await http.get(Uri.parse(versionJsonUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final nuevaVersion = data['version'];
        final apkUrl = data['apkUrl'];

        final info = await PackageInfo.fromPlatform();
        final versionActual = info.version;
        log('Version actual: $versionActual');
        if (nuevaVersion != versionActual) {
          log('Necesitas Actualizar');
          if (!context.mounted) return;
          emit(AutoupdateSuccess(
            apkVersion: apkUrl,
            apkVersionName: nuevaVersion,
          ));

          return;
        }
        emit(AutoupdateFoundVersion(versionName: versionActual));
      }
    } catch (e) {
      log('Error al verificar versión: $e');
    }
  }
}
