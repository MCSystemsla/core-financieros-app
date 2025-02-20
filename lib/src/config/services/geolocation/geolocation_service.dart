import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

///  Clase que se encarga de obtener la ubicación actual del usuario.
class GeolocationService {
  final BuildContext context;

  GeolocationService({required this.context});

  Future<Position?> getCurrentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        if (!context.mounted) return null;
        CustomAlertDialog(
          context: context,
          title: 'GPS desactivado. Actívalo para obtener la ubicación.',
          onDone: () async {
            await Geolocator.requestPermission();
          },
        ).showDialog(context, dialogType: DialogType.warning);
        return null;
      }

      final permission = await _handlePermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        if (!context.mounted) return null;
        CustomAlertDialog(
          context: context,
          title: 'Permiso de ubicación no concedido.',
          onDone: () async {
            await Geolocator.openLocationSettings();
          },
        ).showDialog(context, dialogType: DialogType.error);
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      if (!context.mounted) return null;
      CustomAlertDialog(
        context: context,
        title: 'Error al obtener la ubicación: $e',
        onDone: () async {
          await Geolocator.openLocationSettings();
        },
      ).showDialog(context, dialogType: DialogType.error);
      return null;
    }
  }

  /// Maneja la solicitud de permisos de ubicación.
  Future<LocationPermission> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }
}
