import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import '../../bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';

enum TypeForm {
  nueva,
  asalariado,
  represtamo,
}

class CrearSolicitudScreen extends StatelessWidget {
  final TypeForm? typeForm;
  final String? cedula;
  final Item? tipoDocumento;
  final Item? paisEmiror;
  final UserByCedulaSolicitud? userByCedulaSolicitud;

  const CrearSolicitudScreen({
    super.key,
    this.typeForm,
    this.cedula,
    this.userByCedulaSolicitud,
    this.tipoDocumento,
    this.paisEmiror,
  });

  @override
  Widget build(BuildContext context) {
    final repository = SolicitudCreditoRepositoryImpl();
    final localDbProvider = global<ObjectBoxService>();
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudNuevaMenorCubit(
            repository,
            localDbProvider,
          ),
        ),
        BlocProvider(
          create: (ctx) => SolicitudReprestamoCubit(
            repository,
            localDbProvider,
          ),
        ),
        BlocProvider(
          create: (ctx) => SolicitudAsalariadoCubit(
            repository,
            localDbProvider,
          ),
        ),
        BlocProvider(
          create: (ctx) => GeolocationCubit(
            GeolocationService(),
          ),
        ),
      ],
      child: Scaffold(
        body: switch (typeForm) {
          TypeForm.nueva => NuevaMenorForm(
              pageController: pageController,
              cedula: cedula ?? '',
              tipoDocumento: tipoDocumento ?? const Item(name: '', value: ''),
              paisEmisor: paisEmiror ?? const Item(name: '', value: ''),
            ),
          TypeForm.asalariado => AsalariadoForm(
              controller: pageController,
              userByCedulaSolicitud: userByCedulaSolicitud ??
                  UserByCedulaSolicitud(
                    cedula: cedula ?? '',
                    tipoDocumento: tipoDocumento?.value ?? '',
                    paisEmisor: paisEmiror,
                  ),
            ),
          TypeForm.represtamo => ReprestamoForm(
              userByCedulaSolicitud: userByCedulaSolicitud!,
              controller: pageController,
            ),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
