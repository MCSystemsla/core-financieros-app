import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/supervisiones_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervisiones_credito_form7.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_6.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_5.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/supervisiones/supervision_credito/supervision_credito_cubit.dart';

class SupervisionesFormCreditoHnScreen extends StatelessWidget {
  final SupervisionData data;
  final String nombreCoordinador;
  final num cuota;
  final num razonEndeudamiento;
  final String tipoSolicitud;
  const SupervisionesFormCreditoHnScreen({
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
    return BlocProvider(
      create: (ctx) => SupervisionCreditoCubit(
        SupervisionesRepositoryHnImpl(),
      )..setSolicitudSolicitudCreditoInfor(
          numeroSolicitud: int.tryParse(data.numeroSolicitud) ?? 0,
          tipoSolicitud: data.tipoSolicitud),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Supervision Credito'),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pagecontroller,
          children: [
            SupervisionCreditoForm1(
              pagecontroller: pagecontroller,
              data: data,
            ),
            SupervisionCreditoForm2(
              pagecontroller: pagecontroller,
              data: data,
            ),
            SupervisionCreditoForm3(
              pagecontroller: pagecontroller,
              data: data,
            ),
            SupervisionCreditoForm4(
              pagecontroller: pagecontroller,
            ),
            SupervisionCreditoForm5(
              pagecontroller: pagecontroller,
            ),
            SupervisionCreditoForm6(
              pagecontroller: pagecontroller,
              data: data,
            ),
            SupervisionesCreditoForm7(
              pagecontroller: pagecontroller,
              data: data,
            ),
          ],
        ),
      ),
    );
  }
}
