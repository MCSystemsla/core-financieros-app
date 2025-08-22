import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/analisis_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/analisis_solicitud_nueva_menor/analisis_solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/solicitud_by_numero/solicitud_by_numero_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/constancia_y_creditos_analisis_solicitud.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/creditos_analisis_solicitud.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/referencias_analisis_solicitud.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/analisis_form_solicitud.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/stepper/analisis_solicitud_stepper.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/analisis_credit_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisSolicitudFormScreen extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;

  const AnalisisSolicitudFormScreen({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
  });

  @override
  State<AnalisisSolicitudFormScreen> createState() =>
      _AnalisisSolicitudFormScreenState();
}

class _AnalisisSolicitudFormScreenState
    extends State<AnalisisSolicitudFormScreen> {
  final pageController = PageController();
  int activeStep = 0;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      final page = pageController.page?.round() ?? 0;
      if (page == activeStep) return;
      setState(() => activeStep = page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudByNumeroCubit(
            AnalisisRepositoryImpl(),
          )..getSolicitudByNumeroSolicitud(
              numeroSolicitud: widget.numeroSolicitud,
            ),
        ),
        BlocProvider(
          create: (ctx) => AnalisisSolicitudNuevaMenorCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nueva Menor'),
        ),
        body: Column(
          children: [
            AnalisisCreditCard(
              enabled: false,
              index: widget.index,
              animate: false,
              title: widget.title,
              subtitle: widget.subtitle,
              description: widget.description,
              numeroSolicitud: widget.numeroSolicitud,
            ),
            const Gap(20),
            Expanded(
              child: AnalisisSolicitudStepper(
                activeStep: activeStep,
              ),
            ),
            const Gap(20),
            BlocBuilder<SolicitudByNumeroCubit, SolicitudByNumeroState>(
              builder: (context, state) {
                return switch (state) {
                  OnSolicitudByNumeroStateLoading() => const LoadingWidget(),
                  OnSolicitudByNumeroStateError() =>
                    Text('Error : //${state.errorMsg} '),
                  OnSolicitudByNumeroStateSuccess() => Expanded(
                      flex: 3,
                      child: AnalisisFormsPageView(
                        pageController: pageController,
                        solicitud: state.data,
                      ),
                    ),
                  _ => const SizedBox(),
                };
              },
            )
          ],
        ),
      ),
    );
  }
}

class AnalisisFormsPageView extends StatefulWidget {
  const AnalisisFormsPageView({
    super.key,
    required this.pageController,
    required this.solicitud,
  });

  final AnalisisSolicitudNuevaMenorResponse solicitud;
  final PageController pageController;

  @override
  State<AnalisisFormsPageView> createState() => _AnalisisFormsPageViewState();
}

class _AnalisisFormsPageViewState extends State<AnalisisFormsPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>();
    cubit.initializeFields(solicitud: widget.solicitud);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView(
      controller: widget.pageController,
      children: [
        AnalisisFormSolicitud(
          pageController: widget.pageController,
          solicitud: widget.solicitud,
        ),
        ConstanciaYCreditosAnalisis(
          pageController: widget.pageController,
          solicitud: widget.solicitud,
        ),
        CreditosAnalisisSolicitud(
          pageController: widget.pageController,
        ),
        ReferenciasAnalisisSolicitud(
          pageController: widget.pageController,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
