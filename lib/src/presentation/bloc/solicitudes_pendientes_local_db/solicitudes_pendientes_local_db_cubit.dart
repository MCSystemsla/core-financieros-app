import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

part 'solicitudes_pendientes_local_db_state.dart';

class SolicitudesPendientesLocalDbCubit
    extends Cubit<SolicitudesPendientesLocalDbState> {
  SolicitudesPendientesLocalDbCubit()
      : super(SolicitudesPendientesLocalDbInitial());
  final _logger = Logger();
  Future<void> initDB() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        inspector: true,
        [SolicitudesPendientesSchema],
        directory: dir.path,
      );
      if (isar.isOpen) {
        emit(state.copyWith(isar: isar));
        _logger.i('La base de datos Isar está activa.');
      }
    } catch (e) {
      _logger.e(e);
    }
  }

  Future<void> saveSolicitudesPendientes() async {
    List<SolicitudesPendientes> solicitudes = [
      SolicitudesPendientes()
        ..solicitudId = '001'
        ..nombre = 'Juan Perez'
        ..estado = 'Pendiente'
        ..moneda = 'USD'
        ..monto = 100.0
        ..producto = 'Préstamo'
        ..fecha = DateTime.now()
        ..numero = '123456'
        ..idAsesor = 21
        ..sucursal = 'Sucursal Centro',
      SolicitudesPendientes()
        ..solicitudId = '002'
        ..nombre = 'Ana Gomez'
        ..estado = 'Aprobada'
        ..moneda = 'USD'
        ..monto = 250.0
        ..idAsesor = 21
        ..producto = 'Tarjeta de Crédito'
        ..fecha = DateTime.now().subtract(const Duration(days: 1))
        ..numero = '654321'
        ..sucursal = 'Sucursal Norte',
    ];
    final resp = await state.isar!.writeTxn(
      () {
        return state.isar!.solicitudesPendientes.putAll(solicitudes);
      },
    );
    log(resp.toString());
  }
}
