import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline1_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline2_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline3_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline5_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline6_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline7_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offlne4_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrearSolicitudOfflineScreen extends StatelessWidget {
  final ResponseLocalDb responseLocalDb;
  const CrearSolicitudOfflineScreen({super.key, required this.responseLocalDb});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudNuevaMenorCubit(
            SolicitudCreditoRepositoryImpl(),
            global<ObjectBoxService>(),
          ),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            const Navbar(),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  // NuevaMenorOfflne4Widget(
                  //   pageController: pageController,
                  //   responseLocalDb: responseLocalDb,
                  // ),
                  NuevaMenorOffline1(
                    responseLocalDb: responseLocalDb,
                    pageController: pageController,
                  ),
                  NuevaMenorOffline2Widget(
                    controller: pageController,
                    responseLocalDb: responseLocalDb,
                  ),
                  NuevaMenorOffline3Widget(
                    controller: pageController,
                    responseLocalDb: responseLocalDb,
                  ),
                  NuevaMenorOfflne4Widget(
                    pageController: pageController,
                    responseLocalDb: responseLocalDb,
                  ),
                  NuevaMenorOffline5Widget(
                    pageController: pageController,
                    responseLocalDb: responseLocalDb,
                  ),
                  NuevaMenorOffline6Widget(
                    pageController: pageController,
                    responseLocalDb: responseLocalDb,
                  ),
                  NuevaMenorOffline7Widget(
                    pageController: pageController,
                    responseLocalDb: responseLocalDb,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
