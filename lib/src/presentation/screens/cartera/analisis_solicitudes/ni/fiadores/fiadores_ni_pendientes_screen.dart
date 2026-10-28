import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/local_db/analisis_fiador_ni_local_db.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/fiadores_pendientes/fiadores_ni_pendientes_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/fiadores/fiadores_ni_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Fiadores NI guardados sin conexión para una solicitud. Con conexión se
/// envían uno por uno; sin conexión solo se pueden ver y eliminar.
class FiadoresNiPendientesScreen extends StatelessWidget {
  static const routeName = 'fiadores-ni-pendientes';

  final int numeroSolicitud;
  const FiadoresNiPendientesScreen({
    super.key,
    required this.numeroSolicitud,
  });

  /// Abrir siempre con esta ruta: el nombre permite que la pantalla de envío
  /// sepa si debajo del formulario ya hay una lista de pendientes.
  static MaterialPageRoute<void> route({required int numeroSolicitud}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) =>
          FiadoresNiPendientesScreen(numeroSolicitud: numeroSolicitud),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FiadoresNiPendientesCubit(AnalisisFormsRepositoryNiImpl())
        ..load(numeroSolicitud: numeroSolicitud),
      child: _FiadoresNiPendientesView(numeroSolicitud: numeroSolicitud),
    );
  }
}

class _FiadoresNiPendientesView extends StatelessWidget {
  final int numeroSolicitud;
  const _FiadoresNiPendientesView({required this.numeroSolicitud});

  Future<void> _nuevoFiador(BuildContext context) async {
    final cubit = context.read<FiadoresNiPendientesCubit>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FiadoresNiFormScreen(numeroSolicitud: numeroSolicitud),
      ),
    );
    cubit.load(numeroSolicitud: numeroSolicitud);
  }

  void _confirmarEliminar(
    BuildContext context,
    AnalisisFiadorNiLocalDb pendiente,
  ) {
    final cubit = context.read<FiadoresNiPendientesCubit>();
    ExitConfirmationDialog(
      context: context,
      title: '¿Eliminar el fiador ${pendiente.nombreCompleto}? '
          'Se borra del teléfono y no se podrá enviar.',
      onYes: () {
        Navigator.pop(context);
        cubit.eliminar(pendiente.id);
      },
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.watch<InternetConnectionCubit>().state.isConnected;

    return BlocListener<FiadoresNiPendientesCubit, FiadoresNiPendientesState>(
      listenWhen: (prev, curr) =>
          curr.errorMsg != null && prev.errorMsg != curr.errorMsg,
      listener: (context, state) {
        showV2CustomSnackbar(
          context,
          title: 'El fiador no se pudo enviar',
          message: state.errorMsg,
          type: SnackbarType.error,
        );
      },
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeaderWidget(
                title: 'Fiadores pendientes',
                subtitle:
                    'Solicitud $numeroSolicitud. Fiadores guardados en el teléfono que aún no se envían.',
              ),
              const Gap(20),
              Expanded(
                child: BlocBuilder<FiadoresNiPendientesCubit,
                    FiadoresNiPendientesState>(
                  builder: (context, state) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        if (!isConnected)
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 22),
                            child: _OfflineNoticeWidget(),
                          ),
                        SectionBlockWidget(
                          label:
                              'PENDIENTES DE ENVÍO · ${state.pendientes.length}',
                          children: [
                            if (state.pendientes.isEmpty)
                              const _EmptyPendientesWidget()
                            else
                              for (final pendiente in state.pendientes)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _FiadorPendienteTile(
                                    pendiente: pendiente,
                                    isConnected: isConnected,
                                    isSending:
                                        state.enviandoUuid == pendiente.uuid,
                                    isBusy: state.enviandoUuid != null,
                                    onSend: () => context
                                        .read<FiadoresNiPendientesCubit>()
                                        .enviar(pendiente),
                                    onDelete: () =>
                                        _confirmarEliminar(context, pendiente),
                                  ),
                                ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              _NuevoFiadorButtonBar(onPressed: () => _nuevoFiador(context)),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfflineNoticeWidget extends StatelessWidget {
  const _OfflineNoticeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: RedesignColors.amberTint,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 20,
            color: RedesignColors.amber,
          ),
          Gap(10),
          Expanded(
            child: Text(
              'Estás sin conexión. Los fiadores se guardan en el teléfono y '
              'se envían cuando vuelvas a estar en línea.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: RedesignColors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FiadorPendienteTile extends StatelessWidget {
  final AnalisisFiadorNiLocalDb pendiente;
  final bool isConnected;
  final bool isSending;
  final bool isBusy;
  final VoidCallback onSend;
  final VoidCallback onDelete;
  const _FiadorPendienteTile({
    required this.pendiente,
    required this.isConnected,
    required this.isSending,
    required this.isBusy,
    required this.onSend,
    required this.onDelete,
  });

  String _formatFecha(DateTime date) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(date.day)}/${two(date.month)}/${date.year} '
        '${two(date.hour)}:${two(date.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: RedesignColors.amberTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 20,
              color: RedesignColors.amber,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pendiente.nombreCompleto,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
                const Gap(2),
                Text(
                  pendiente.cedula,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: RedesignColors.inkMuted,
                  ),
                ),
                const Gap(4),
                Text(
                  'Guardado ${_formatFecha(pendiente.fechaGuardado)}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: RedesignColors.chevron,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          if (isSending)
            const SizedBox(
              height: 40,
              width: 40,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: RedesignColors.green,
                ),
              ),
            )
          else
            IconButton(
              onPressed: isConnected && !isBusy ? onSend : null,
              tooltip: 'Enviar',
              style: IconButton.styleFrom(
                backgroundColor: RedesignColors.greenTint,
                disabledBackgroundColor: RedesignColors.tagBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              icon: Icon(
                Icons.send_rounded,
                size: 18,
                color: isConnected && !isBusy
                    ? RedesignColors.green
                    : RedesignColors.chevron,
              ),
            ),
          const Gap(6),
          IconButton(
            onPressed: isSending ? null : onDelete,
            tooltip: 'Eliminar',
            style: IconButton.styleFrom(
              backgroundColor: RedesignColors.redTint,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 18,
              color: RedesignColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPendientesWidget extends StatelessWidget {
  const _EmptyPendientesWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RedesignColors.border),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 28,
            color: RedesignColors.chevron,
          ),
          Gap(8),
          Text(
            'No hay fiadores pendientes de envío para esta solicitud',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: RedesignColors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _NuevoFiadorButtonBar extends StatelessWidget {
  final VoidCallback onPressed;
  const _NuevoFiadorButtonBar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: RedesignColors.surface,
        border: Border(top: BorderSide(color: RedesignColors.border)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: RedesignColors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: onPressed,
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
            ),
            label: const Text(
              'Nuevo fiador',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
