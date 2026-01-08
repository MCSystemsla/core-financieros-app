import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/offline_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitudes_by_flavor_interceptor.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/loading',
  // initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/solicitudes',
      builder: (context, state) => const SolicitudesByFlavorInterceptor(),
      routes: [
        GoRoute(
          path: '/solicitudes-pendientes',
          builder: (context, state) {
            return const SolicitudesPendientesScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/cartera',
      builder: (context, state) => const CarteraScreen(),
      routes: [
        GoRoute(
          path: 'kiva-offline',
          builder: (context, state) => const OfflineFormKivaScreen(),
        ),
        GoRoute(
          path: 'formulario-kiva',
          builder: (context, state) => const KivaFormScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingScreen(),
    ),
  ],
);
