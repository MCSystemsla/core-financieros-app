import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
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
import 'package:core_financiero_app/src/utils/extensions/type_action/type_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Paleta local de la pantalla, tomada del rediseño (canvas "MiCredito Asesor
/// 2026"): superficies claras, filas blancas y un solo tono por familia de
/// módulo.
const _kBackground = Color(0xffF4F5F1);
const _kSurface = Color(0xffFFFFFF);
const _kBorder = Color(0xffE4E6E0);
const _kInk = Color(0xff131714);
const _kInkMuted = Color(0xff5C6660);
const _kChevron = Color(0xff9BA39D);
const _kTagBackground = Color(0xffF1F2EE);

const _kGreenTint = Color(0xffEDF7E7);
const _kGreen = Color(0xff2E6B27);
const _kTealTint = Color(0xffE7F4F3);
const _kTeal = Color(0xff2C7A72);
const _kIndigoTint = Color(0xffEEF0F6);
const _kIndigo = Color(0xff414C74);
const _kPurpleTint = Color(0xffF0ECF6);
const _kPurple = Color(0xff57407A);
const _kRedTint = Color(0xffF7EBEA);
const _kRed = Color(0xff94413B);
const _kOnlineDot = Color(0xff5EB837);

class SelectSolicitudScreenHN extends StatelessWidget {
  const SelectSolicitudScreenHN({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: _kBackground,
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
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(),
          Gap(24),
          _CreditoNuevoSection(),
          _GestionSection(),
          _MiTrabajoSection(),
          Gap(28),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _HeaderBackButton(
                onPressed: () => context.pushReplacement('/cartera'),
              ),
              const Spacer(),
              const _ConnectionPill(),
            ],
          ),
          const Gap(16),
          const Text(
            'Solicitudes',
            style: TextStyle(
              fontSize: 30,
              height: 1.05,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.9,
              color: _kInk,
            ),
          ),
          const Gap(8),
          const Text(
            'Elige el tipo de crédito que vas a registrar o el trámite que vas a continuar.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.45,
              color: _kInkMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _HeaderBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: _kBorder),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: _kInk,
        ),
      ),
    );
  }
}

class _ConnectionPill extends StatelessWidget {
  const _ConnectionPill();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        final isOnline = state.connectionStatus == ConnectionStatus.connected;

        return Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isOnline ? _kGreenTint : _kTagBackground,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline ? _kOnlineDot : _kChevron,
                ),
              ),
              const Gap(7),
              Text(
                isOnline ? 'En línea' : 'Offline',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isOnline ? _kGreen : _kInkMuted,
                ),
              ),
            ],
          ),
        );
      },
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

    return _Section(
      label: 'CREAR SOLICITUD',
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _SolicitudEntryCard(
                  icon: Icons.storefront_outlined,
                  iconColor: _kGreen,
                  iconBackground: _kGreenTint,
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
                child: _SolicitudEntryCard(
                  icon: Icons.badge_outlined,
                  iconColor: _kTeal,
                  iconBackground: _kTealTint,
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
          _SolicitudTile(
            icon: Icons.groups_outlined,
            iconColor: _kIndigo,
            iconBackground: _kIndigoTint,
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

    return _Section(
      label: 'GESTIÓN DE SOLICITUDES',
      children: [
        if (actions.contains(TypeAction.solicitudCreditoModificar.codigo) &&
            connectionStatus == ConnectionStatus.connected)
          _SolicitudTile(
            icon: Icons.edit_outlined,
            iconColor: _kPurple,
            iconBackground: _kPurpleTint,
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
          _SolicitudTile(
            icon: Icons.person_add_alt_outlined,
            iconColor: _kIndigo,
            iconBackground: _kIndigoTint,
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
          _SolicitudTile(
            icon: Icons.verified_user_outlined,
            iconColor: _kGreen,
            iconBackground: _kGreenTint,
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
          _SolicitudTile(
            icon: Icons.cancel_outlined,
            iconColor: _kRed,
            iconBackground: _kRedTint,
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
    return _Section(
      label: 'MI TRABAJO',
      children: [
        _SolicitudTile(
          icon: Icons.cloud_upload_outlined,
          iconColor: const Color(0xff8C5309),
          iconBackground: const Color(0xffFBF1E3),
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
        _SolicitudTile(
          icon: Icons.assignment_ind_outlined,
          iconColor: _kTeal,
          iconBackground: _kTealTint,
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

/// Bloque con encabezado. Si ningún módulo del bloque es visible (por permisos
/// o por conexión), el bloque completo desaparece y no deja hueco.
class _Section extends StatelessWidget {
  final String label;
  final List<Widget> children;
  const _Section({required this.label, required this.children});

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
              color: _kInkMuted,
            ),
          ),
          const Gap(10),
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const Gap(8),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// Tarjeta de entrada a un crédito nuevo (Comercial / Asalariado).
class _SolicitudEntryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  const _SolicitudEntryCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        constraints: const BoxConstraints(minHeight: 112),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _IconTile(
              icon: icon,
              color: iconColor,
              background: iconBackground,
            ),
            const Gap(11),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.15,
                color: _kInk,
              ),
            ),
            const Gap(3),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                height: 1.35,
                color: _kInkMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fila densa de módulo, con etiqueta opcional a la derecha.
class _SolicitudTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final String? tag;
  final VoidCallback onPressed;
  const _SolicitudTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        constraints: const BoxConstraints(minHeight: 70),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBorder),
        ),
        child: Row(
          children: [
            _IconTile(
              icon: icon,
              color: iconColor,
              background: iconBackground,
            ),
            const Gap(13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.15,
                      color: _kInk,
                    ),
                  ),
                  const Gap(3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: _kInkMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (tag != null) ...[
              const Gap(10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: _kTagBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _kInkMuted,
                  ),
                ),
              ),
            ],
            const Gap(10),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: _kChevron,
            ),
          ],
        ),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  const _IconTile({
    required this.icon,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, size: 21, color: color),
    );
  }
}
