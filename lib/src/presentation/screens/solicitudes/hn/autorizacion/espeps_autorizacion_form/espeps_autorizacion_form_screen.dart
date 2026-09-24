import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/autorizar_solicitud/autorizar_solicitud_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/autorizacion_solicitud_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/pages/espepes_authorization_page3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/pages/espeps_authorization_page1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/pages/espeps_authorization_page2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class EspepsAutorizacionFormScreen extends StatelessWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  const EspepsAutorizacionFormScreen({
    super.key,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => InformacionPepsHnCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          )..setNumeroSolicitud(numeroSolicitud),
        ),
        BlocProvider(
          create: (ctx) => AutorizarSolicitudCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          ),
        ),
      ],
      child: _EspepsAutorizacionListener(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Formulario de autorización de PEPS'),
          ),
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              EspepsAuthorizationPage1(
                pageController: pageController,
              ),
              EsPepsAuthorizationPage3(
                pageController: pageController,
              ),
              EsPepsAuthorizationPage2(
                pageController: pageController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EspepsAutorizacionListener extends StatelessWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  final Widget child;
  const _EspepsAutorizacionListener({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InformacionPepsHnCubit, InformacionPepsHnState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == Status.done) {
              context.hideLoading();
              context.read<AutorizarSolicitudCubit>().autorizarSolicitudCredito(
                    numeroSolicitud: numeroSolicitud,
                    tipoSolicitud: tipoSolicitud,
                  );
            }
          },
        ),
        BlocListener<AutorizarSolicitudCubit, AutorizarSolicitudState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == Status.inProgress) {
              context.showLoading(message: 'Autorizando solicitud...');
            }
            if (state.status == Status.done) {
              context.hideLoading();
              CustomAlertDialog(
                context: context,
                title: 'Solicitud autorizada exitosamente.',
                onDone: () {
                  context.pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const AutorizacionSolicitudHnScreen(),
                    ),
                  );
                },
              ).showDialog(
                context,
                dialogType: DialogType.success,
              );
            }
            if (state.status == Status.error) {
              context.hideLoading();
              showV2CustomSnackbar(
                context,
                title: state.errorMsg,
                type: SnackbarType.error,
              );
            }
          },
        ),
      ],
      child: child,
    );
  }
}

Widget esPepsSiguienteButton(
  BuildContext context,
  PageController pageController,
  GlobalKey<FormState> formKey,
) {
  return SafeArea(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomElevatedButton(
        // ignore: deprecated_member_use
        color: AppColors.greenLatern.withOpacity(0.4),
        text: 'Siguiente',
        onPressed: () {
          final isValid = formKey.currentState?.validate() ?? false;

          if (!isValid) return;

          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    ),
  );
}

Widget esPepsAtrasButton(
  BuildContext context,
  PageController pageController,
) {
  return SafeArea(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomElevatedButton(
        // ignore: deprecated_member_use
        color: AppColors.red,
        text: 'Atras',
        onPressed: () {
          pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    ),
  );
}

Widget esPepsEnviarButton(
  BuildContext context,
  PageController pageController,
  GlobalKey<FormState> formKey,
) {
  return BlocConsumer<InformacionPepsHnCubit, InformacionPepsHnState>(
    listenWhen: (previous, current) => previous.status != current.status,
    buildWhen: (previous, current) => previous.status != current.status,
    listener: (context, state) {
      if (state.status == Status.inProgress) {
        context.showLoading(message: 'Enviando información...');
      }
      if (state.status == Status.error) {
        context.hideLoading();
        showV2CustomSnackbar(
          context,
          title: state.errorMsg,
          type: SnackbarType.error,
        );
      }
    },
    builder: (context, state) {
      return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomElevatedButton(
            // ignore: deprecated_member_use
            color: AppColors.greenLatern.withOpacity(0.4),
            text: 'Enviar',
            onPressed: () {
              final isValid = formKey.currentState?.validate() ?? false;
              if (!isValid) return;
              final currentState = context.read<InformacionPepsHnCubit>().state;
              if (currentState.detallePeps.isEmpty) {
                showV2CustomSnackbar(
                  context,
                  title: 'Es necesario agregar al menos un cargo desempeñado',
                  type: SnackbarType.warning,
                );
                return;
              }
              if (currentState.relacionPeps.isEmpty) {
                showV2CustomSnackbar(
                  context,
                  title: 'Es necesario agregar al menos un tipo de relación',
                  type: SnackbarType.warning,
                );
                return;
              }
              context.read<InformacionPepsHnCubit>().createInformacionPeps();
            },
          ),
        ),
      );
    },
  );
}
