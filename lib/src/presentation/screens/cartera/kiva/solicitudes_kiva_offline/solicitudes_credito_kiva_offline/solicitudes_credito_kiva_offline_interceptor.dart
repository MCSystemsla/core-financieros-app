import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/energia_limpia_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/estandar_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/micredito_estudio_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mujer_emprender_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolicitudesCreditoKivaOfflineInterceptor extends StatelessWidget {
  final String nombreFormularioKiva;
  const SolicitudesCreditoKivaOfflineInterceptor({
    super.key,
    required this.nombreFormularioKiva,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UploadUserFileCubit(
        ResponsesRepositoryImpl(),
      ),
      child: Scaffold(
        body: switch (nombreFormularioKiva) {
          'ScrKivaCreditoEstandar' => EstandarScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaCreditoEstandarRecurrente' => EstandarScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaMejoraVivienda' => MejoraDeViviendaScreen(
              typeProducto: nombreFormularioKiva,
            ),
          'ScrKivaMejoraViviendaRecurrente' => MejoraDeViviendaScreen(
              typeProducto: nombreFormularioKiva,
            ),
          'ScrKivaMiCrediEstudio' => MiCreditoEstudioScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaMiCrediEstudioRecurrente' => MiCreditoEstudioScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaMujerEmprende' => MujerEmprenderScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaMujerEmprendeRecurrente' => MujerEmprenderScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaAguaSaneamiento' => SaneamientoScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaAguaSaneamientoRecurrente' => SaneamientoScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaEnergiaLimpia' => EnergiaLimpiaScreen(
              typeProduct: nombreFormularioKiva,
            ),
          'ScrKivaEnergiaLimpiaRecurrente' => EnergiaLimpiaScreen(
              typeProduct: nombreFormularioKiva,
            ),
          _ => const SizedBox(),
        },
      ),
    );
  }
}
