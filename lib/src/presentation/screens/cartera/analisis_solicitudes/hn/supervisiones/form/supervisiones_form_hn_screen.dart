import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_coordinador/supervision_coordinador_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_montos/supervision_montos_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervision_form_hn_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupervisionesFormHnScreen extends StatelessWidget {
  final SupervisionData data;
  final String nombreCoordinador;
  final num cuota;
  final num razonEndeudamiento;
  final String tipoSolicitud;
  const SupervisionesFormHnScreen({
    super.key,
    required this.data,
    required this.nombreCoordinador,
    required this.cuota,
    required this.razonEndeudamiento,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final pagecontroller = PageController();
    final repository = SupervisionesRepositoryHnImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SupervisionCoordinadorCubit(
            repository,
          )..setDataFromSolicitud(
              numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
            ),
        ),
        BlocProvider(
          create: (ctx) => SupervisionMontosCubit(
            repository,
          )..getMontosSupervision(
              numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Supervision'),
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pagecontroller,
            children: [
              SupervisionFormHN1(
                pageController: pagecontroller,
                data: data,
                nombreCoordinador: nombreCoordinador,
              ),
              SupervisionFormHN2(
                pageController: pagecontroller,
              ),
              SupervisionFormHN3(
                pageController: pagecontroller,
                cuota: cuota,
                razonEndeudamiento: razonEndeudamiento,
              ),
              SupervisionFormHN4(
                pageController: pagecontroller,
                tipoSolicitud: tipoSolicitud,
                montoSolicitud: data.monto.toInt(),
                cuotaSolicitud: data.cuota.toInt(),
                plazoSolicitud: data.plazoSolicitud,
                producto: data.producto,
                frecuenciaPago: data.frecuenciaPago,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
