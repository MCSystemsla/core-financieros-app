import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:geolocator/geolocator.dart';

///  Clase que se encarga de obtener la ubicación actual del usuario.
class GeolocationService {
  GeolocationService();

  Future<Position?> getCurrentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return null;
      }

      final permission = await _handlePermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      await ErrorReporter.registerError(
        errorMessage: 'Error obteniendo la ubicación del usuario: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
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
