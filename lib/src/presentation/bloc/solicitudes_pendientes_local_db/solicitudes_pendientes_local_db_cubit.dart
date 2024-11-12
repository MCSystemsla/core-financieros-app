import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
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

  Future<void> saveSolicitudesPendientes(
      {required List<SolicitudesPendientes> solicitudes}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      for (var solicitud in solicitudes) {
        final existingIds = await state.isar!.solicitudesPendientes
            .filter()
            .solicitudIdEqualTo(solicitud.solicitudId)
            .findFirst();
        final isnumerosIdExists = await state.isar!.solicitudesPendientes
            .filter()
            .numeroEqualTo(solicitud.numero)
            .findFirst();
        final issucursalExists = await state.isar!.solicitudesPendientes
            .filter()
            .sucursalEqualTo(solicitud.sucursal)
            .findFirst();
        if (existingIds != null &&
            isnumerosIdExists != null &&
            issucursalExists != null) {
          _logger
              .i('Ya existe esta solicitud con el ID ${solicitud.solicitudId}');
        } else {
          await state.isar!.writeTxn(() {
            return state.isar!.solicitudesPendientes.put(solicitud);
          });
          _logger.i('Solicitud con ID ${solicitud.solicitudId} guardada.');
        }
        emit(state.copyWith(status: Status.done));
      }
    } catch (e) {
      _logger.e(e);
      emit(state.copyWith(status: Status.error));
    }
  }
}
