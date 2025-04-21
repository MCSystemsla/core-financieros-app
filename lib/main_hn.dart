import 'dart:developer';

import 'package:core_financiero_app/app.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

const flavor = Flavor.honduras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  // await FirebaseService().initializeApp();
  await setUpGlobalLocator();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'es',
    supportedLocales: ['es', 'en'],
  );
  log('FLAVOR: $flavor ');

  runApp(
    LocalizedApp(
      delegate,
      BlocProvider(
        create: (_) => FlavorCubit()..setFlavor(flavor),
        child: const App(
          flavor: flavor,
        ),
      ),
    ),
  );
}
