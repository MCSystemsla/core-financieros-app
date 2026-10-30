import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/local_db/analisis_fiador_hn_local_db.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/domain/repository/expediente_digital/expediente_digital_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_pendientes/fiadores_hn_pendientes_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/section_block_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Fiadores HN guardados sin conexión para una solicitud. Con conexión se
/// envían uno por uno; sin conexión solo se pueden ver y eliminar.
class FiadoresHnPendientesScreen extends StatelessWidget {
  static const routeName = 'fiadores-hn-pendientes';

  final int numeroSolicitud;
  const FiadoresHnPendientesScreen({
    super.key,
    required this.numeroSolicitud,
  });

  /// Abrir siempre con esta ruta: el nombre permite que la pantalla de envío
  /// sepa si debajo del formulario ya hay una lista de pendientes.
  static MaterialPageRoute<void> route({required int numeroSolicitud}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) =>
          FiadoresHnPendientesScreen(numeroSolicitud: numeroSolicitud),
    );
  }

  /// Abre la lista de pendientes. El `Future` termina al volver.
  static Future<void> open(
    BuildContext context, {
    required int numeroSolicitud,
  }) {
    return Navigator.push(context, route(numeroSolicitud: numeroSolicitud));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FiadoresHnPendientesCubit(
        AnalisisRepositoryHNImpl(),
        ExpedienteDigitalRepositoryImpl(),
      )..load(numeroSolicitud: numeroSolicitud),
      child: _FiadoresHnPendientesView(numeroSolicitud: numeroSolicitud),
    );
  }
}

class _FiadoresHnPendientesView extends StatelessWidget {
  final int numeroSolicitud;
  const _FiadoresHnPendientesView({required this.numeroSolicitud});

  void _confirmarEliminar(
    BuildContext context,
    AnalisisFiadorHnLocalDb pendiente,
  ) {
    final cubit = context.read<FiadoresHnPendientesCubit>();
    final faltaFirma = pendiente.fiadorId.isNotEmpty;
    ExitConfirmationDialog(
      context: context,
      title: faltaFirma
          ? 'Este fiador ya está creado en el servidor y le falta la firma. '
              '¿Eliminar a ${pendiente.nombreCompleto} del teléfono de todos modos?'
          : '¿Eliminar el fiador ${pendiente.nombreCompleto}? '
              'Se borra del teléfono y no se podrá enviar.',
      onYes: () {
        Navigator.pop(context);
        cubit.eliminar(pendiente);
      },
    ).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.watch<InternetConnectionCubit>().state.isConnected;

    return MultiBlocListener(
      listeners: [
        BlocListener<FiadoresHnPendientesCubit, FiadoresHnPendientesState>(
          listenWhen: (prev, curr) =>
              prev.envioStatus != curr.envioStatus &&
              curr.envioStatus == Status.error,
          listener: (context, state) {
            showV2CustomSnackbar(
              context,
              title: 'El fiador no se pudo enviar',
              message: state.errorMsg,
              type: SnackbarType.error,
            );
          },
        ),
        BlocListener<FiadoresHnPendientesCubit, FiadoresHnPendientesState>(
          listenWhen: (prev, curr) =>
              prev.envioStatus != curr.envioStatus &&
              curr.envioStatus == Status.done,
          listener: (context, state) {
            showV2CustomSnackbar(
              context,
              title: 'Fiador enviado exitosamente',
              message:
                  'El fiador y su firma quedaron registrados en la solicitud $numeroSolicitud.',
              type: SnackbarType.success,
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: RedesignColors.background,
        body: SafeArea(
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
                child: BlocBuilder<FiadoresHnPendientesCubit,
                    FiadoresHnPendientesState>(
                  builder: (context, state) {
                    return ListView(
                      padding: const EdgeInsets.only(bottom: 24),
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
                                    isBusy:
                                        state.envioStatus == Status.inProgress,
                                    onSend: () => context
                                        .read<FiadoresHnPendientesCubit>()
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
  final AnalisisFiadorHnLocalDb pendiente;
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

  String _tipoFiador(String codigo) {
    final tipo = FiadoresHnFormType.values
        .where((t) => t.codigo == codigo)
        .firstOrNull;
    return switch (tipo) {
      FiadoresHnFormType.conyugue => 'Cónyuge',
      FiadoresHnFormType.aval => 'Aval',
      FiadoresHnFormType.codeudor => 'Codeudor',
      null => codigo,
    };
  }

  @override
  Widget build(BuildContext context) {
    final faltaFirma = pendiente.fiadorId.isNotEmpty;

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
                  '${_tipoFiador(pendiente.tipoFiadorCodigo)} · ${pendiente.cedula}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: RedesignColors.inkMuted,
                  ),
                ),
                const Gap(4),
                Text(
                  'Guardado ${pendiente.fechaGuardado.formatDate()}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: RedesignColors.chevron,
                  ),
                ),
                if (faltaFirma) ...[
                  const Gap(6),
                  const CardTagWidget(
                    label: 'Falta la firma',
                    color: RedesignColors.red,
                    background: RedesignColors.redTint,
                  ),
                ],
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
