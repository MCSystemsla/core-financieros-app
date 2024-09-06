import 'dart:developer';

import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final router = GoRouter(
  // initialLocation: '/loading',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/no-internet',
      builder: (context, state) => const NoInternetScreen(),
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
        // bool isConnected = global<InternetConnectionCubit>().state.isConnected;
        // const bool isAuthenticated = true;
        if (!isConnected) {
          log('Internet access is currently unavailable.');
          return '/no-internet';
        }
        // // ignore: dead_code
        // if (!isAuthenticated) {
        //   return '/login';
        //   // ignore: dead_code
        // } else {
        //   return '/';
        // }

        // ignore: dead_code
        return '/login';
      },
    ),
  ],
  // routes: [

  //   GoRoute(
  //     path: '/onboarding',
  //     builder: (context, state) => const OnboardingScreen(),
  //   ),
  //   GoRoute(
  //     path: '/news',
  //     builder: (context, state) => const NewsScreen(),
  //     routes: [
  //       GoRoute(
  //         path: 'details',
  //         builder: (context, state) {
  //           final Article data = state.extra as Article;
  //           return NewsDetailScreen(article: data);
  //         },
  //       ),
  //     ],
  //   ),
  //   GoRoute(
  //     path: '/kilowath_calculation',
  //     builder: (context, state) => const KilowathCalculationScreen(),
  //   ),
  //   GoRoute(
  //     path: '/educational_data',
  //     builder: (context, state) => const EducationalDataScreen(),
  //     routes: [
  //       GoRoute(
  //           path: 'section/:id',
  //           builder: (context, state) {
  //             final String educationalDataId = state.pathParameters['id']!;
  //             final String educationalDataName = state.extra as String;
  //             return EducationalDataSectionScreen(
  //               educationalDataId: int.parse(educationalDataId),
  //               educationalDataName: educationalDataName,
  //             );
  //           })
  //     ],
  //   ),
  //   GoRoute(
  //       path: '/how_to_reduce_energy_consume',
  //       builder: (context, state) => const HowToReduceEnergyConsumeScreen(),
  //       routes: [
  //         GoRoute(
  //           path: 'detail',
  //           builder: (context, state) {
  //             final Advice data = state.extra as Advice;
  //             return ReduceDetailScreen(advice: data);
  //           },
  //         )
  //       ]),
  //   GoRoute(
  //     path: '/section',
  //     builder: (context, state) => const SectionScreen(),
  //   ),
  //   GoRoute(
  //     path: '/success_stories',
  //     builder: (context, state) => const SuccessStoriesScreen(),
  //   ),
  //   GoRoute(
  //     path: '/metric',
  //     builder: (context, state) => const MetricScreen(),
  //   ),
  //   GoRoute(
  //     path: '/notification',
  //     builder: (context, state) => const NotificationScreen(),
  //   ),
  //   GoRoute(
  //     path: '/detail',
  //     builder: (context, state) {
  //       final DetailItem data = state.extra as DetailItem;
  //       return DetailScreen(resource: data);
  //     },
  //   ),
);

class DetailItem {
  final int id;
  final String title;
  final String content;
  final String imgUrl;
  final DateTime createdAt;

  DetailItem({
    required this.id,
    required this.title,
    required this.content,
    required this.imgUrl,
    required this.createdAt,
  });
}
