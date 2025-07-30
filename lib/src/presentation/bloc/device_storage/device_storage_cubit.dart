import 'package:bloc/bloc.dart';
import 'package:disk_space_plus/disk_space_plus.dart';
import 'package:equatable/equatable.dart';

part 'device_storage_state.dart';

class DeviceStorageCubit extends Cubit<DeviceStorageState> {
  DeviceStorageCubit() : super(DeviceStorageInitial());

  void initDeviceStorage() async {
    DiskSpacePlus diskSpacePlus = DiskSpacePlus();

    try {
      final espacioDisponible = await diskSpacePlus.getFreeDiskSpace;
      final espacioTotal = await diskSpacePlus.getTotalDiskSpace;
      if (espacioTotal == null || espacioDisponible == null) return;
      final percentUsedPercentage =
          ((espacioTotal - espacioDisponible) / espacioTotal) * 100;
      final isStorageFull =
          isStorageCriticallyLow(free: espacioDisponible, total: espacioTotal);
      emit(state.copyWith(
        freeStorage: espacioDisponible,
        usedStoragePercent: percentUsedPercentage,
        totalStorage: espacioTotal,
        isStorageFull: isStorageFull
            ? StorageDeviceStatus.full
            : StorageDeviceStatus.available,
      ));
    } catch (e) {
      emit(state.copyWith(isStorageFull: StorageDeviceStatus.unknown));
    }
  }

  bool isStorageCriticallyLow({
    double minMB = 1000, // 1 GB in MB
    double minPercent = 10, // 10% of total storage
    required double free,
    required double total,
  }) {
    final percentFree = (free / total) * 100;

    return free < minMB || percentFree < minPercent;
  }

  void userGetContinue() {
    emit(state.copyWith(isStorageFull: StorageDeviceStatus.userGetContinue));
  }
}
