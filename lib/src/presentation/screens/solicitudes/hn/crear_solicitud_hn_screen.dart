import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/actividades_economicas_alias_filtered_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/asalariado_hn_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/nueva_menor_hn_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/represtamo_hn_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/solicitudes/hn/cubit/calculo_cuota_hn/calculo_cuota_hn_cubit.dart';
import '../../../bloc/solicitudes/hn/cubit/grupos_activos/grupos_activos_cubit.dart';
import '../../../bloc/solicitudes/hn/cubit/user_have_cedula/user_have_cedula_cubit.dart';

class CrearSolicitudHnScreen extends StatelessWidget {
  final TypeForm typeForm;
  const CrearSolicitudHnScreen({
    super.key,
    required this.typeForm,
  });

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<SolicitudesHnBoxService>();
    final repository = SolicitudesCreditoHnRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudAslariadoHnCubit(
            repository,
            localDbProvider,
          )..initAutoSave(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudNuevaMenorHnCubit(
            repository,
            localDbProvider,
          )..initAutoSave(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudReprestamoHnCubit(
            repository,
            localDbProvider,
          )..initAutoSave(),
        ),
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => GeolocationCubit(
            GeolocationService(),
          ),
        ),
        BlocProvider(
          create: (ctx) => GruposActivosCubit(
            repository,
          )..getGruposActivos(),
        ),
        BlocProvider(
          create: (ctx) => UserHaveCedulaCubit(
            repository,
          ),
        ),
        BlocProvider(
          create: (ctx) => CalculoCuotaHnCubit(),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.build),
              onPressed: () {
                buildActividadesEconomicasAliasFilteredDropdown(
                  context: context,
                );
              },
            ),
            body: switch (typeForm) {
              TypeForm.nueva => const NuevaMenorHnForm(),
              TypeForm.asalariado => const AsalariadoHnForm(),
              TypeForm.represtamo => const ReprestamoHnForm(),
            }),
      ),
    );
  }
}
