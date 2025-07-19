import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/enviar_solicitud_when_isdone/enviar_solicitud_when_isdone_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/add_user_cedula_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/asignacion_solicitud/nueva/asignacion_nueva_list_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/represtamo_add_user_cedula_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitud_card.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectSolicitudScreen extends StatelessWidget {
  const SelectSolicitudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final repository = SolicitudCreditoRepositoryImpl();
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => EnviarSolicitudWhenIsdoneCubit(
            localDbProvider,
            repository,
          )..sendSolicitudWhenIsDone(isConnected: isConnected),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<EnviarSolicitudWhenIsdoneCubit,
            EnviarSolicitudWhenIsdoneState>(
          builder: (context, state) {
            return switch (state) {
              OnEnviarSolicitudWhenIsdoneLoading() =>
                const DownloadCatalogoLoading(
                  lottieAsset: ImageAsset.enviarSolicitudOfflines,
                  text: 'Enviando Solicitudes Offline al Servidor',
                ),
              OnEnviarSolicitudWhenIsdoneSuccess() => DownloadCatalogoLoading(
                  onDownloadComplete: () {
                    context.push('/solicitudes');
                  },
                  isSucess: true,
                  lottieAsset: ImageAsset.nuevaMenorSuccess,
                  text:
                      'Solicitudes offline enviadas exitosamente!!\n\n${state.solicitudesSent.isNotEmpty ? state.solicitudesSent.join('\n') : ''}',
                  repeat: false,

                  // isUploadingForms: true,
                ),
              OnEnviarSolicitudWhenIsdoneError() => OnErrorWidget(
                  errorMsg: state.msgError,
                  onPressed: () {
                    context
                        .read<EnviarSolicitudWhenIsdoneCubit>()
                        .sendSolicitudWhenIsDone(
                          isConnected: isConnected,
                        );
                  },
                ),
              OnEnviarSolicitudWhenIsdonePendingVerification() => OnErrorWidget(
                  solicitudesSent: state.solicitudesSent,
                  errors: state.errors,
                  btnTitle: 'OK',
                  errorMsg: state.msgError,
                  onPressed: () {
                    context.read<EnviarSolicitudWhenIsdoneCubit>().resetState();
                  },
                ),
              _ => const _SelectSolicitud(),
            };
          },
        ),
      ),
    );
  }
}

class _SelectSolicitud extends StatelessWidget {
  const _SelectSolicitud();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Seleccionar un tipo de Credito',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 19,
                    ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Por favor, elige una de las siguientes opciones:',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
            ),
            const Gap(20),
            const _SolicitudCardsRow1(),
            const Gap(20),
            const _SolicitudesCardsRow2(),
            const Gap(20),
            const _SolicitudesCardsRow3(),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _SolicitudesCardsRow3 extends StatelessWidget {
  const _SolicitudesCardsRow3();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            svgPath: ImageAsset.nuevaMenorBg5,
            title: 'Asignacion de Solicitudes Crédito',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const AsignacionListScreen()),
                ),
              );
            },
          ),
        ),
        const Gap(10),
      ],
    );
  }
}

class _SolicitudesCardsRow2 extends StatelessWidget {
  const _SolicitudesCardsRow2();

  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.read<InternetConnectionCubit>().state.connectionStatus;
    return Row(
      children: [
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            svgPath: ImageAsset.nuevaMenorBg3,
            title: 'Represtamo',
            onPressed: () {
              if (isConnected != ConnectionStatus.connected) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((_) => const CrearSolicitudScreen(
                          typeForm: TypeForm.represtamo,
                        )),
                  ),
                );
                return;
              }
              context.pushTransparentRoute(
                const ReprestamoAddUserCedulaScreen(
                  typeForm: TypeForm.represtamo,
                ),
              );
            },
          ),
        ),
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            onPressed: () {
              context.push('/solicitudes/solicitudes-pendientes');
            },
            svgPath: ImageAsset.nuevaMenorBg4,
            title: 'Solicitudes Pendientes',
          ),
        ),
        const Gap(10),
      ],
    );
  }
}

class _SolicitudCardsRow1 extends StatelessWidget {
  const _SolicitudCardsRow1();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            onPressed: () {
              context.pushTransparentRoute(const AddUserCedulaScreen(
                typeForm: TypeForm.nueva,
              ));
            },
            svgPath: ImageAsset.nuevaMenorBg,
            title: 'Nueva',
          ),
        ),
        const Gap(10),
        Expanded(
          child: SolicitudCard(
            onPressed: () {
              context.pushTransparentRoute(const AddUserCedulaScreen(
                typeForm: TypeForm.asalariado,
              ));
            },
            svgPath: ImageAsset.nuevaMenorBg2,
            title: 'Asalariado',
          ),
        ),
        const Gap(10),
      ],
    );
  }
}
