import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/router/router.dart';
import 'package:core_financiero_app/src/config/services/biometric/biometric_auth_service.dart';
import 'package:core_financiero_app/src/config/theme/app_theme.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/auth_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/autoupdate/autoupdate_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitud_catalogo/solicitud_catalogo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'src/presentation/bloc/biometric/biometric_cubit.dart';
import 'src/presentation/bloc/lang/lang_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudCatalogoCubit(
            SolicitudCreditoRepositoryImpl(),
            global<ObjectBoxService>(),
            DepartamentosRepositoryImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => LangCubit(
              currentLang: Locale(
            LocalStorage().currentLanguage,
          )),
          lazy: false,
        ),
        BlocProvider(
          create: (ctx) => KivaRouteCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (ctx) =>
              InternetConnectionCubit()..getInternetStatusConnection(),
        ),
        BlocProvider(
          lazy: false,
          create: (ctx) => SolicitudesPendientesLocalDbCubit()..initDB(),
        ),
        BlocProvider(
          create: (ctx) => UserByCedulaCubit(SolicitudCreditoRepositoryImpl()),
        ),
        BlocProvider(create: (ctx) => AuthCubit(AuthRepositoryImpl())),
        BlocProvider(create: (ctx) => BiometricCubit(BiometricAuthService())),
        BlocProvider(
            lazy: false,
            create: (ctx) =>
                AutoupdateCubit()..verificarActualizacion(context)),
      ],
      child: BlocConsumer<LangCubit, LangState>(
        listener: (context, state) async {
          await localizationDelegate.changeLocale(state.currentLang);
        },
        builder: (context, state) {
          return LocalizationProvider(
            state: LocalizationProvider.of(context).state,
            child: MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              title: 'Core Financiero App',
              theme: AppTheme.getTheme(context),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                localizationDelegate,
              ],
              supportedLocales: localizationDelegate.supportedLocales,
              locale: Locale(state.currentLang.languageCode),
            ),
          );
        },
      ),
    );
  }
}
