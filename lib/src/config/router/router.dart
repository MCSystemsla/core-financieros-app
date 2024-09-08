import 'dart:developer';

import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final router = GoRouter(
  initialLocation: '/loading',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/no-internet',
      builder: (context, state) => const NoInternetScreen(),
      routes: [
        GoRoute(
          path: 'form/saneamiento',
          builder: (context, state) => const SaneamientoScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/pla',
      builder: (context, state) => const PLAScreen(),
    ),
    GoRoute(
      path: '/ahorro',
      builder: (context, state) => const AhorroScreen(),
    ),
    GoRoute(
      path: '/tesoreria',
      builder: (context, state) => const TesoreriaScreen(),
    ),
    GoRoute(
      path: '/requerimiento',
      builder: (context, state) => const RequerimientoScreen(),
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingScreen(),
      redirect: (context, state) async {
        bool isConnected = await InternetConnectionChecker().hasConnection;
        if (!isConnected) {
          log('Internet access is currently unavailable.');
          return '/no-internet/form/saneamiento';
        }
        return '/login';
      },
    ),
  ],
);
