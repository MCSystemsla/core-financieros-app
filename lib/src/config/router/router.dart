import 'dart:developer';

import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final router = GoRouter(
  initialLocation: '/loading',
  // initialLocation: '/online/form/mejora-de-vivienda',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/online',
      routes: [
        GoRoute(
          path: 'form/saneamiento',
          builder: (context, state) => const SaneamientoScreen(),
        ),
        GoRoute(
          path: 'form/mejora-de-vivienda',
          builder: (context, state) {
            return const MejoraDeViviendaScreen();
          },
        ),
        GoRoute(
          path: 'form/seguimiento',
          builder: (context, state) => const SeguimientoScreen(),
        ),
        GoRoute(
          path: 'form/migrantes-economicos',
          builder: (context, state) => const MigrantesEconomicosScreen(),
        ),
        GoRoute(
          path: 'form/micredito-estudio',
          builder: (context, state) => const MiCreditoEstudioScreen(),
        ),
        GoRoute(
          path: 'form/mujer-emprende',
          builder: (context, state) => const MujerEmprenderScreen(),
        ),
        GoRoute(
          path: 'form/energia-limpia',
          builder: (context, state) => const EnergiaLimpiaScreen(),
        ),
        GoRoute(
          path: 'form/estandar',
          builder: (context, state) => const EstandarScreen(),
        ),
      ],
      redirect: (context, state) async {
        final String tipoProducto = state.extra.toString();
        log('tipo producto: $tipoProducto');
        if (tipoProducto == 'MICREDIESTUDIO NUEVO' ||
            tipoProducto == 'MICREDIESTUDIO RECURRENTE') {
          return '/online/form/micredito-estudio';
        }
        if (tipoProducto == 'ESTANDAR NUEVO' ||
            tipoProducto == 'ESTANDAR RECURRENTE') {
          return '/online/form/estandar';
        }
        if (tipoProducto == 'VIVIENDA NUEVA' ||
            tipoProducto == 'VIVIENDA REPRESTAMO') {
          return '/online/form/mejora-de-vivienda';
        }

        if (tipoProducto == 'AGUA Y SANEAMIENTO NUEVO' ||
            tipoProducto == 'AGUA Y SANEAMIENTO RECURRENTE') {
          return '/online/form/saneamiento';
        }
        if (tipoProducto == 'ASER NUEVO' || tipoProducto == 'ASER RECURRENTE') {
          return '/online/form/energia-limpia';
        }
        if (tipoProducto == 'ASER NUEVO' || tipoProducto == 'ASER RECURRENTE') {
          return '/online/form/energia-limpia';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/no-internet',
      builder: (context, state) => const NoInternetScreen(),
      routes: [
        GoRoute(
          path: 'form/saneamiento',
          builder: (context, state) => const SaneamientoScreen(),
        ),
        GoRoute(
          path: 'form/mejora-de-vivienda',
          builder: (context, state) => const MejoraDeViviendaScreen(),
        ),
        GoRoute(
          path: 'form/seguimiento',
          builder: (context, state) => const SeguimientoScreen(),
        ),
        GoRoute(
          path: 'form/migrantes-economicos',
          builder: (context, state) => const MigrantesEconomicosScreen(),
        ),
        GoRoute(
          path: 'form/micredito-estudio',
          builder: (context, state) => const MiCreditoEstudioScreen(),
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
      path: '/cartera',
      builder: (context, state) => const CarteraScreen(),
      routes: [
        GoRoute(
          path: 'formulario-kiva',
          builder: (context, state) => const KivaFormScreen(),
        ),
      ],
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
    GoRoute(
      path: '/credito',
      builder: (context, state) => const CreditoScreen(),
    )
  ],
);
