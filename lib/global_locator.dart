import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/services/biometric/biometric_auth_service.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:logger/logger.dart';

import 'src/presentation/bloc/biometric/biometric_cubit.dart';

late GetIt global;
final getIt = GetIt.instance;

Future<void> setUpGlobalLocator({required Flavor flavor}) async {
  global = GetIt.I;

  global.registerLazySingleton(() => Logger());
  global.registerFactory<APIRepository>(() => DefaultAPIRepository());
  final objectBoxService = await ObjectBoxService.init();
  global.registerSingleton<ObjectBoxService>(objectBoxService);
  global.registerSingleton<BiometricCubit>(
    BiometricCubit(BiometricAuthService()),
  );
  global.registerSingleton<FlavorCubit>(
    FlavorCubit()..setFlavor(flavor),
  );

  _injectStorage();
}

void _injectStorage() {
  // global.registerSingleton<FCMTokenStorage>(FCMTokenStorage());
}
