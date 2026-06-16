import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_garantia/fiadores_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/tipos_garantia_hn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';

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
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Garantía'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _AnalisisSolicitudesTitle(),
              const Gap(10),
              TiposGarantiaHNWidget(
                numeroSolicitud: numeroSolicitud,
                solicitudCodigo: solicitudCodigo,
                cedulaCliente: cedulaCliente,
              ),
              const Gap(10),
              // DetalleGarantiaTableHNWidget(
              //   numeroSolicitud: numeroSolicitud,
              //   tipoPersonaCodigo: tipoPersonaCodigo,
              //   cedulaCliente: cedulaCliente,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnalisisSolicitudesTitle extends StatelessWidget {
  const _AnalisisSolicitudesTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Garantía de crédito',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Gap(10),
          Text(
            'Evaluación detallada de las solicitudes de crédito para determinar su viabilidad y cumplimiento de criterios financieros',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}
