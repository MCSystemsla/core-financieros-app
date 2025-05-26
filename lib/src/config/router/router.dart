import 'dart:developer';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/offline_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return SaneamientoScreen(
                typeProduct: typeProduct,
              );
            }),
        GoRoute(
          path: 'form/mejora-de-vivienda',
          builder: (context, state) {
            final typeProduct =
                context.read<KivaRouteCubit>().state.currentRoute;

            return MejoraDeViviendaScreen(
              typeProducto: typeProduct,
            );
          },
        ),
        GoRoute(
          path: 'form/seguimiento',
          builder: (context, state) => const SeguimientoScreen(),
        ),
        GoRoute(
            path: 'form/migrantes-economicos',
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return MigrantesEconomicosScreen(
                typeProduct: typeProduct,
              );
            }),
        GoRoute(
            path: 'form/micredito-estudio',
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return MiCreditoEstudioScreen(
                typeProduct: typeProduct,
              );
            }),
        GoRoute(
            path: 'form/mujer-emprende',
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return MujerEmprenderScreen(
                typeProduct: typeProduct,
              );
            }),
        GoRoute(
            path: 'form/energia-limpia',
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;

              return EnergiaLimpiaScreen(
                typeProduct: typeProduct,
              );
            }),
        GoRoute(
            path: 'form/estandar',
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return EstandarScreen(typeProduct: typeProduct);
            }),
        GoRoute(
            path: 'form/offline-confirmation',
            builder: (context, state) {
              final typeProduct = context.watch<KivaRouteCubit>().state;

              return ConfirmationOfflineResponsesScreen(
                typeProduct: typeProduct.currentRoute,
              );
            }),
      ],
      redirect: (context, state) {
        final String tipoProducto = state.extra.toString();
        log('tipo producto: $tipoProducto');
        if (tipoProducto == 'ScrKivaMiCrediEstudio' ||
            tipoProducto == 'ScrKivaMiCrediEstudioRecurrente') {
          return '/online/form/micredito-estudio';
        }
        if (tipoProducto == 'ScrKivaCreditoEstandar' ||
            tipoProducto == 'ScrKivaCreditoEstandarRecurrente') {
          return '/online/form/estandar';
        }
        if (tipoProducto == 'ScrKivaMejoraVivienda' ||
            tipoProducto == 'ScrKivaMejoraViviendaRecurrente') {
          return '/online/form/mejora-de-vivienda';
        }

        if (tipoProducto == 'ScrKivaAguaSaneamiento' ||
            tipoProducto == 'ScrKivaAguaSaneamientoRecurrente') {
          return '/online/form/saneamiento';
        }
        if (tipoProducto == 'ASER NUEVO' || tipoProducto == 'ASER RECURRENTE') {
          return '/online/form/energia-limpia';
        }
        if (tipoProducto == 'ScrKivaEnergiaLimpia' ||
            tipoProducto == 'ScrKivaEnergiaLimpiaRecurrente') {
          return '/online/form/energia-limpia';
        }
        if (tipoProducto == 'ScrKivaMujerEmprende' ||
            tipoProducto == 'ScrKivaMujerEmprendeRecurrente') {
          return '/online/form/mujer-emprende';
        }
        if (tipoProducto == 'ScrKivaMigrantesEconomicos' ||
            tipoProducto == 'ScrKivaMigrantesEconomicos' ||
            tipoProducto == 'ScrKivaMigrantesEconomicosRecurrentes' ||
            tipoProducto == 'ScrKivaMigrantesEconomicosRecurrentes') {
          return '/online/form/migrantes-economicos';
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
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return SaneamientoScreen(
                typeProduct: typeProduct,
              );
            }),
        GoRoute(
            path: 'form/mejora-de-vivienda',
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return MejoraDeViviendaScreen(
                typeProducto: typeProduct,
              );
            }),
        GoRoute(
          path: 'form/seguimiento',
          builder: (context, state) => const SeguimientoScreen(),
        ),
        GoRoute(
            path: 'form/migrantes-economicos',
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return MigrantesEconomicosScreen(
                typeProduct: typeProduct,
              );
            }),
        GoRoute(
            path: 'form/micredito-estudio',
            builder: (context, state) {
              final typeProduct =
                  context.read<KivaRouteCubit>().state.currentRoute;
              return MiCreditoEstudioScreen(typeProduct: typeProduct);
            }),
      ],
    ),
    GoRoute(
      path: '/solicitudes',
      builder: (context, state) => const SelectSolicitudScreen(),
      routes: [
        GoRoute(
          path: '/solicitud-credito',
          builder: (context, state) {
            return const CrearSolicitudScreen();
          },
        ),
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
