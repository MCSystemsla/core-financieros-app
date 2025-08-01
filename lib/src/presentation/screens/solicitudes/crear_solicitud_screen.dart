import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_by_cedula_solicitud.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
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
  nueva('NUEVAMENOR'),
  asalariado('ASALARIADO'),
  represtamo('REPRESTAMO');

  final String codigo;

  const TypeForm(this.codigo);
}

class CrearSolicitudScreen extends StatelessWidget {
  final TypeForm typeForm;
  final UserByCedulaSolicitud? userByCedulaSolicitud;

  const CrearSolicitudScreen({
    super.key,
    required this.typeForm,
    this.userByCedulaSolicitud,
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
          )..initAutoSave(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudReprestamoCubit(
            repository,
            localDbProvider,
          )..initAutoSave(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudAsalariadoCubit(
            repository,
            localDbProvider,
          )..initAutoSave(),
        ),
        BlocProvider(
          create: (ctx) => GeolocationCubit(
            GeolocationService(),
          ),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: switch (typeForm) {
            TypeForm.nueva => NuevaMenorForm(
                pageController: pageController,
              ),
            TypeForm.asalariado => AsalariadoForm(
                controller: pageController,
              ),
            TypeForm.represtamo => ReprestamoForm(
                userByCedulaSolicitud: userByCedulaSolicitud ??
                    UserByCedulaSolicitud(
                      cedula: '',
                      tipoDocumento: '',
                    ),
                controller: pageController,
              ),
          },
        ),
      ),
    );
  }
}
