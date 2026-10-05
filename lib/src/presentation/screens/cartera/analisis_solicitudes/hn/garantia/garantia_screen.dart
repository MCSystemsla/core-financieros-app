import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_garantia/fiadores_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/tipos_garantia_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';

import '../../../../../bloc/analisis/hn/analisis_anular_garantia/analisis_anular_garantia_cubit.dart';

class GarantiaHNScreen extends StatelessWidget {
  final int numeroSolicitud;
  final String solicitudCodigo;
  final String cedulaCliente;
  final String tipoPersonaCodigo;
  const GarantiaHNScreen({
    super.key,
    required this.numeroSolicitud,
    required this.solicitudCodigo,
    required this.cedulaCliente,
    required this.tipoPersonaCodigo,
  });

  @override
  Widget build(BuildContext context) {
    final repository = AnalisisRepositoryHNImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => AnalisisGarantiaCubit(repository)
            ..getGarantiasByNumero(numeroSolicitud: numeroSolicitud),
        ),
        BlocProvider(
          create: (ctx) => AnalisisArticuloCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => FiadoresGarantiaCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => AnalisisAnularGarantiaCubit(repository),
        ),
      ],
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              ScreenHeaderWidget(
                title: 'Garantía',
                subtitle:
                    'Solicitud #$numeroSolicitud. Registra las garantías que respaldan el crédito y asigna un bien a cada una.',
                onBack: () => Navigator.pop(context),
              ),
              const Gap(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TiposGarantiaHNWidget(
                  numeroSolicitud: numeroSolicitud,
                  solicitudCodigo: solicitudCodigo,
                  cedulaCliente: cedulaCliente,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
