// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'device_storage_cubit.dart';

enum StorageDeviceStatus { unknown, available, full, low, userGetContinue }

class DeviceStorageState extends Equatable {
  final double freeStorage;
  final int freeStoragePercent;
  final double totalStorage;
  final int totalStoragePercent;
  final StorageDeviceStatus isStorageFull;
  final double usedStoragePercent;

  const DeviceStorageState({
    this.freeStorage = 0,
    this.freeStoragePercent = 0,
    this.totalStorage = 0,
    this.totalStoragePercent = 0,
    this.isStorageFull = StorageDeviceStatus.unknown,
    this.usedStoragePercent = 0,
  });

  @override
  List<Object> get props => [
        freeStorage,
        freeStoragePercent,
        totalStorage,
        totalStoragePercent,
        isStorageFull,
        usedStoragePercent
      ];

  DeviceStorageState copyWith({
    double? freeStorage,
    int? freeStoragePercent,
    double? totalStorage,
    int? totalStoragePercent,
    StorageDeviceStatus? isStorageFull,
    double? usedStoragePercent,
  }) {
    return DeviceStorageState(
      freeStorage: freeStorage ?? this.freeStorage,
      freeStoragePercent: freeStoragePercent ?? this.freeStoragePercent,
      totalStorage: totalStorage ?? this.totalStorage,
      totalStoragePercent: totalStoragePercent ?? this.totalStoragePercent,
      isStorageFull: isStorageFull ?? this.isStorageFull,
      usedStoragePercent: usedStoragePercent ?? this.usedStoragePercent,
    );
  }
}

class DeviceStorageInitial extends DeviceStorageState {}
