import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:logger/logger.dart';

late GetIt global;

void setUpGlobalLocator() {
  global = GetIt.I;

  global.registerLazySingleton(() => Logger());
  global.registerFactory<APIRepository>(() => DefaultAPIRepository());
  global.registerFactory<InternetConnectionCubit>(
    () => InternetConnectionCubit(),
  );

  _injectStorage();
}

void _injectStorage() {
  // global.registerSingleton<FCMTokenStorage>(FCMTokenStorage());
}
