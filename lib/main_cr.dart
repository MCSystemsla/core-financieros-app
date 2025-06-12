import 'package:core_financiero_app/app.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

const flavor = Flavor.costaRica;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  // await FirebaseService().initializeApp();
  await setUpGlobalLocator(flavor: flavor);
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'es',
    supportedLocales: ['es', 'en'],
  );
  runApp(
    LocalizedApp(
      delegate,
      const App(
        flavor: flavor,
      ),
    ),
  );
}
