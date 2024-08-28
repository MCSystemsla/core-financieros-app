import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/router/router.dart';
import 'package:core_financiero_app/src/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

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
          create: (context) =>
              LangCubit(currentLang: LocalStorage().currentLanguage),
          lazy: false,
        ),
      ],
      child: BlocConsumer<LangCubit, LangState>(
        listener: (context, state) {
          changeLocale(context, state.currentLang);
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
              locale: Locale(state.currentLang),
            ),
          );
        },
      ),
    );
  }
}
