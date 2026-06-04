import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'app_maintanance_state.dart';

class AppMaintananceCubit extends Cubit<AppMaintananceState> {
  AppMaintananceCubit() : super(AppMaintananceInitial());
  final _logger = Logger();
  Future<void> checkMaintenanceStatus() async {
    final flavor = global<FlavorCubit>().state.flavor.name;
    const String appMaintananceUrl =
        'https://drive.google.com/uc?export=download&id=1vxMU2Ql60f-M3rRuR5SiJG7RXoUsCJto';

    try {
      final resp = await http.get(Uri.parse(appMaintananceUrl));
      final data = json.decode(resp.body);
      final bool isMaintance = data[flavor]['isMaintenance'];
      final DateTime from = DateTime.parse(data[flavor]['from']).toLocal();
      final DateTime to = DateTime.parse(data[flavor]['to']).toLocal();
      final String message = data[flavor]['message'];
      if (resp.statusCode != 200) {
        emit(const OnAppMaintananceError(
          errorMsg: 'Error al obtener la aplicación de mantenimiento',
        ));
        return;
      }
      if (isMaintance) {
        emit(OnMaintenanceModeDetected(
          isMaintenanceMode: isMaintance,
          message: message,
          from: from,
          to: to,
        ));
        return;
      }
      emit(OnAppMaintananceSuccess());
    } catch (e, stack) {
      _logger.e(
        'Error al obtener la aplicación de mantenimiento $e',
        stackTrace: stack,
      );
      emit(OnAppMaintananceError(
        errorMsg: e.toString(),
      ));
    }
  }
}
