import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_coordinador/supervision_coordinador_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervision_form_hn_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/supervisiones_form_hn_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupervisionesFormHnScreen extends StatelessWidget {
  final SupervisionData data;
  const SupervisionesFormHnScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final pagecontroller = PageController();
    return BlocProvider(
      create: (ctx) => SupervisionCoordinadorCubit(
        SupervisionesRepositoryHnImpl(),
      )..setDataFromSolicitud(
          numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Supervision'),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pagecontroller,
          children: [
            SupervisionFormHN1(
              pageController: pagecontroller,
              data: data,
            ),
            SupervisionFormHN2(
              pageController: pagecontroller,
            ),
            SupervisionFormHN3(
              pageController: pagecontroller,
            ),
            SupervisionFormHN4(
              pageController: pagecontroller,
            ),
          ],
        ),
      ),
    );
  }
}
