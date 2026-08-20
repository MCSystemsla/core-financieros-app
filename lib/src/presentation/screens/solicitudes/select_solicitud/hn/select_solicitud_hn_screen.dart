import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/actualizacion_solicitud/actualizacion_solicitud_hn.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/add_user_cedula_asalariado_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/add_user_cedula_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/asignacion_solicitud/asignacion_list_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/autorizacion_solicitud_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/crear_grupo_credito_grupal/crear_grupo_credito_grupal_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/mis_solicitudes_asignadas/mis_solicitudes_asignadas_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/rechazar_solicitud/rechazar_solicitud_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/solicitudes_pendientes/solicitudes_pendientes_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_entry_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/type_action/type_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectSolicitudScreenHN extends StatelessWidget {
  const SelectSolicitudScreenHN({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        bottom: false,
        child: _SelectSolicitud(),
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
    final actions = LocalStorage().currentActions;
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
                  title: 'Comercial',
                  subtitle: 'Negocio propio',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((_) => const AddUserCedulaHnScreen(
                              typeForm: TypeForm.nueva,
                            )),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((_) => const AddUserCedulaAsalariadoScreen(
                              typeForm: TypeForm.asalariado,
                            )),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        if (actions.contains(TypeAction.crearGrupoCredito.codigo) &&
            connectionStatus == ConnectionStatus.connected)
          ModuleTileWidget(
            icon: Icons.groups_outlined,
            iconColor: RedesignColors.indigo,
            iconBackground: RedesignColors.indigoTint,
            title: 'Grupales',
            subtitle: 'Gestionar grupo de crédito grupal',
            tag: 'Solo en línea',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const CrearGrupoCreditoGrupalScreen()),
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
        if (actions.contains(TypeAction.solicitudCreditoModificar.codigo) &&
            connectionStatus == ConnectionStatus.connected)
          ModuleTileWidget(
            icon: Icons.edit_outlined,
            iconColor: RedesignColors.purple,
            iconBackground: RedesignColors.purpleTint,
            tag: 'Solo en línea',
            title: 'Modificación',
            subtitle: 'Corregir datos de una solicitud',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const ActualizacionSolicitudHn()),
                ),
              );
            },
          ),
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
                  builder: ((_) => const AsignacionListHnScreen()),
                ),
              );
            },
          ),
        if (actions.contains(TypeAction.autorizacion.codigo) &&
            connectionStatus == ConnectionStatus.connected)
          ModuleTileWidget(
            icon: Icons.verified_user_outlined,
            iconColor: RedesignColors.green,
            iconBackground: RedesignColors.greenTint,
            title: 'Autorización',
            tag: 'Solo en línea',
            subtitle: 'Autorizar solicitudes de crédito',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const AutorizacionSolicitudHnScreen()),
                ),
              );
            },
          ),
        if (actions.contains(TypeAction.rechazarSolicitud.codigo) &&
            connectionStatus == ConnectionStatus.connected)
          ModuleTileWidget(
            icon: Icons.cancel_outlined,
            iconColor: RedesignColors.red,
            iconBackground: RedesignColors.redTint,
            title: 'Rechazar Solicitud',
            subtitle: 'Denegar solicitud de credito',
            tag: 'Solo en línea',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((_) => const RechazarSolicitudHnScreen()),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((_) => const SolicitudesPendientesScreenHN()),
              ),
            );
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
                builder: ((_) => const MisSolicitudesAsignadasHnScreen()),
              ),
            );
          },
        ),
      ],
    );
  }
}
