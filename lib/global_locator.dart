import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:get_it/get_it.dart';

import 'package:logger/logger.dart';

late GetIt global;

void setUpGlobalLocator() {
  global = GetIt.I;

  global.registerLazySingleton(() => Logger());
  global.registerFactory<APIRepository>(() => DefaultAPIRepository());
  // global.registerFactory<InternetConnectionCubit>(
  //   () => InternetConnectionCubit()..getInternetStatusConnection(),
  // );

  _injectStorage();
}

void _injectStorage() {
  // global.registerSingleton<FCMTokenStorage>(FCMTokenStorage());
}
