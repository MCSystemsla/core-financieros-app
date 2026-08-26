import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_proccess_solicitud/kiva_proccess_solicitud.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/enviar_solicitud_when_isdone/enviar_solicitud_when_isdone_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/add_user_cedula_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/asignacion_solicitud/nueva/asignacion_nueva_list_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/autorizacion_solicitud/solicitudes_asesor/solicitudes_asesor_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/represtamo_add_user_cedula_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/success_clay_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_entry_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/type_action/type_action.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';

class SelectSolicitudScreenNi extends StatelessWidget {
  const SelectSolicitudScreenNi({super.key});

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final repository = SolicitudCreditoRepositoryImpl();
    final kivaRepository = ResponsesRepositoryImpl();
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    final kivaProvider = context.read<SolicitudesPendientesLocalDbCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => EnviarSolicitudWhenIsdoneCubit(
            localDbProvider,
            repository,
          )..sendSolicitudWhenIsDone(
              isConnected: isConnected,
              onSolicitudCreditoIsKivaFn: ({
                required String solicitudId,
                required String numeroSolicitud,
                required String uuid,
                required String tipoProducto,
                required String nombreFomularioKiva,
                required String cedula,
                required int tipoSolicitudId,
                required String nombreCliente,
              }) async {
                return await processSolicitud(
                  uuid: uuid,
                  numeroSolicitud: numeroSolicitud,
                  solicitudId: solicitudId,
                  tipoProducto: tipoProducto,
                  tipoSolicitudId: tipoSolicitudId,
                  nombreFomularioKiva: nombreFomularioKiva,
                  cedula: cedula,
                  kivaRepository: kivaRepository,
                  kivaProvider: kivaProvider,
                  nombreCliente: nombreCliente,
                );
              },
            ),
        ),
      ],
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<EnviarSolicitudWhenIsdoneCubit,
              EnviarSolicitudWhenIsdoneState>(
            builder: (context, state) {
              return switch (state) {
                OnEnviarSolicitudWhenIsdoneLoading() =>
                  const DownloadCatalogoLoading(
                    lottieAsset: ImageAsset.enviarSolicitudOfflines,
                    text: 'Enviando Solicitudes Offline al Servidor',
                  ),
                OnEnviarSolicitudWhenIsdoneSuccess() => SuccessClayWidget(
                    onDownloadComplete: () {
                      context.push('/solicitudes');
                    },
                    isSucess: true,
                    lottieAsset: ImageAsset.nuevaMenorSuccess,
                    solicitudesSent: state.solicitudesSent,
                    text: '',
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
                            onSolicitudCreditoIsKivaFn: ({
                              required String solicitudId,
                              required String numeroSolicitud,
                              required String uuid,
                              required String tipoProducto,
                              required String nombreFomularioKiva,
                              required String cedula,
                              required int tipoSolicitudId,
                              required String nombreCliente,
                            }) async {
                              return await processSolicitud(
                                uuid: uuid,
                                numeroSolicitud: numeroSolicitud,
                                solicitudId: solicitudId,
                                tipoProducto: tipoProducto,
                                tipoSolicitudId: tipoSolicitudId,
                                nombreFomularioKiva: nombreFomularioKiva,
                                cedula: cedula,
                                kivaRepository: kivaRepository,
                                kivaProvider: kivaProvider,
                                nombreCliente: nombreCliente,
                              );
                            },
                          );
                    },
                  ),
                OnEnviarSolicitudWhenIsdonePendingVerification() =>
                  OnErrorWidget(
                    areUnsentKivaForms: state.unsentKivaForms.isNotEmpty,
                    unsentKivaForms: state.unsentKivaForms,
                    areUnsentCedulas: state.unsentCedulas.isNotEmpty,
                    unsentCedulas: state.unsentCedulas,
                    solicitudesSent: state.solicitudesSent,
                    errors: state.errors,
                    btnTitle: 'OK',
                    errorMsg: state.msgError,
                    onPressed: () {
                      context
                          .read<EnviarSolicitudWhenIsdoneCubit>()
                          .resetState();
                    },
                  ),
                _ => const _SelectSolicitud(),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _SelectSolicitud extends StatelessWidget {
  const _SelectSolicitud();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeaderWidget(
            title: 'Solicitudes',
            subtitle:
                'Elige el tipo de crédito que vas a registrar o el trámite que vas a continuar.',
            onBack: () => context.pushReplacement('/cartera'),
          ),
          const Gap(24),
          const _CreditoNuevoSection(),
          const _GestionSection(),
          const _MiTrabajoSection(),
          const Gap(28),
        ],
      ),
    );
  }
}

class _CreditoNuevoSection extends StatelessWidget {
  const _CreditoNuevoSection();

  @override
  Widget build(BuildContext context) {
    final connectionStatus =
        context.read<InternetConnectionCubit>().state.connectionStatus;

    return SectionBlockWidget(
      label: 'CREAR SOLICITUD',
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ModuleEntryCard(
                  icon: Icons.storefront_outlined,
                  iconColor: RedesignColors.green,
                  iconBackground: RedesignColors.greenTint,
                  title: 'Nueva',
                  subtitle: 'Negocio propio',
                  onPressed: () {
                    context.pushTransparentRoute(
                      const AddUserCedulaScreen(
                        typeForm: TypeForm.nueva,
                      ),
                    );
                  },
                ),
              ),
              const Gap(8),
              Expanded(
                child: ModuleEntryCard(
                  icon: Icons.badge_outlined,
                  iconColor: RedesignColors.teal,
                  iconBackground: RedesignColors.tealTint,
                  title: 'Asalariado',
                  subtitle: 'Con constancia salarial',
                  onPressed: () {
                    context.pushTransparentRoute(
                      const AddUserCedulaScreen(
                        typeForm: TypeForm.asalariado,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        ModuleTileWidget(
          icon: Icons.autorenew_rounded,
          iconColor: RedesignColors.indigo,
          iconBackground: RedesignColors.indigoTint,
          title: 'Represtamo',
          subtitle: 'Renovar crédito de un cliente actual',
          onPressed: () {
            if (connectionStatus != ConnectionStatus.connected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const CrearSolicitudScreenNi(
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
      ],
    );
  }
}

class _GestionSection extends StatelessWidget {
  const _GestionSection();

  @override
  Widget build(BuildContext context) {
    final actions = LocalStorage().currentActions;
    final connectionStatus =
        context.read<InternetConnectionCubit>().state.connectionStatus;

    return SectionBlockWidget(
      label: 'GESTIÓN DE SOLICITUDES',
      children: [
        if (actions.contains(TypeAction.asignacion.codigo) &&
            connectionStatus == ConnectionStatus.connected)
          ModuleTileWidget(
            icon: Icons.person_add_alt_outlined,
            iconColor: RedesignColors.indigo,
            iconBackground: RedesignColors.indigoTint,
            title: 'Asignación',
            tag: 'Solo en línea',
            subtitle: 'Repartir solicitudes al equipo',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const AsignacionListScreen()),
                ),
              );
            },
          ),
      ],
    );
  }
}

class _MiTrabajoSection extends StatelessWidget {
  const _MiTrabajoSection();

  @override
  Widget build(BuildContext context) {
    return SectionBlockWidget(
      label: 'MI TRABAJO',
      children: [
        ModuleTileWidget(
          icon: Icons.cloud_upload_outlined,
          iconColor: RedesignColors.amber,
          iconBackground: RedesignColors.amberTint,
          title: 'Solicitudes en proceso offline',
          subtitle: 'Guardadas en el telefono',
          onPressed: () {
            context.push('/solicitudes/solicitudes-pendientes');
          },
        ),
        ModuleTileWidget(
          icon: Icons.assignment_ind_outlined,
          iconColor: RedesignColors.teal,
          iconBackground: RedesignColors.tealTint,
          title: 'Mis solicitudes asignadas',
          subtitle: 'Las solicitudes que estan a mi nombre',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((_) => const SolicitudesAsesorScreen()),
              ),
            );
          },
        ),
      ],
    );
  }
}
