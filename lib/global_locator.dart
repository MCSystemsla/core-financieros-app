import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:get_it/get_it.dart';

import 'package:logger/logger.dart';

late GetIt global;
final getIt = GetIt.instance;

void setUpGlobalLocator() async {
  global = GetIt.I;

  global.registerLazySingleton(() => Logger());
  global.registerFactory<APIRepository>(() => DefaultAPIRepository());
  final objectBoxService = await ObjectBoxService.init();
  global.registerSingleton<ObjectBoxService>(objectBoxService);

  // global.registerFactory<InternetConnectionCubit>(
  //   () => InternetConnectionCubit()..getInternetStatusConnection(),
  // );

  _injectStorage();
}

void _injectStorage() {
  // global.registerSingleton<FCMTokenStorage>(FCMTokenStorage());
}
