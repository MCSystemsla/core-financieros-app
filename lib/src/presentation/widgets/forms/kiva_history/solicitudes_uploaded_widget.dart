import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/no_images_kivas_on_history/no_images_kivas_on_history_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/confirmation/confirmation_offline_responses_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_form_spacing.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Lista de solicitudes Kiva enviadas, con acciones para reenviar el
/// formulario o las imágenes de cada una.
///
/// Requiere en el árbol [UploadUserFileCubit], [NoImagesKivasOnHistoryCubit],
/// [SolicitudesPendientesLocalDbCubit] y [KivaRouteCubit].
class SolicitudesUploadedWidget extends StatelessWidget {
  final List<SolicitudesPendientes> solicitudes;

  const SolicitudesUploadedWidget({
    super.key,
    required this.solicitudes,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudes.isEmpty) return const _EmptySolicitudes();

    return BlocListener<UploadUserFileCubit, UploadUserFileState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Imágenes enviadas exitosamente',
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.success);
        }
        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: 'Error inesperado, ${state.errorMsg}',
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.warning);
        }
      },
      child:
          BlocBuilder<NoImagesKivasOnHistoryCubit, NoImagesKivasOnHistoryState>(
        builder: (context, noImagesState) {
          final numerosPendientes = switch (noImagesState) {
            OnNoImagesKivasOnHistoryHaveRequestPending(:final data) =>
              (data.data ?? []).map((req) => req.numero).toSet(),
            _ => const <String?>{},
          };
          return ListView.separated(
            padding: const EdgeInsets.only(top: 10, bottom: 24),
            itemCount: solicitudes.length,
            separatorBuilder: (_, __) => const KivaFormSpacing(),
            itemBuilder: (context, index) {
              final solicitud = solicitudes[index];
              return _SolicitudTile(
                key: ValueKey(solicitud.id),
                solicitud: solicitud,
                imagenesPendientes:
                    numerosPendientes.contains(solicitud.numero),
              );
            },
          );
        },
      ),
    );
  }
}

class _EmptySolicitudes extends StatelessWidget {
  const _EmptySolicitudes();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox, size: 60, color: AppColors.getPrimaryColor()),
            const Gap(16),
            const Text(
              'No tienes solicitudes enviadas',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SolicitudTile extends StatelessWidget {
  final SolicitudesPendientes solicitud;
  final bool imagenesPendientes;

  const _SolicitudTile({
    super.key,
    required this.solicitud,
    required this.imagenesPendientes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ExpansionTitleCustom(
        title: _SolicitudTileTitle(
          solicitud: solicitud,
          imagenesPendientes: imagenesPendientes,
        ),
        finalStep: true,
        children: [
          _SolicitudDetalles(solicitud: solicitud),
          const Gap(16),
          _SolicitudAcciones(solicitud: solicitud),
        ],
      ),
    );
  }
}

class _SolicitudTileTitle extends StatelessWidget {
  final SolicitudesPendientes solicitud;
  final bool imagenesPendientes;

  const _SolicitudTileTitle({
    required this.solicitud,
    required this.imagenesPendientes,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(Icons.assignment, color: AppColors.getPrimaryColor()),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                solicitud.nombre ?? 'Sin nombre',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(2),
              Text(
                'N° ${solicitud.numero ?? '—'}',
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
              ),
              if (imagenesPendientes) ...[
                const Gap(6),
                const _ImagenesPendientesTag(),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ImagenesPendientesTag extends StatelessWidget {
  const _ImagenesPendientesTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Pulse(
            infinite: true,
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              maxRadius: 4,
            ),
          ),
          const Gap(6),
          Text(
            'Imágenes pendientes',
            style: TextStyle(
              color: Colors.red[700],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SolicitudDetalles extends StatelessWidget {
  final SolicitudesPendientes solicitud;

  const _SolicitudDetalles({required this.solicitud});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(12),
        Text(
          'Detalles de la solicitud',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const Gap(8),
        _DetalleRow(label: 'Solicitud ID', value: solicitud.solicitudId),
        _DetalleRow(label: 'Número', value: solicitud.numero),
        _DetalleRow(label: 'Cédula', value: solicitud.cedula),
        _DetalleRow(label: 'Producto', value: solicitud.producto),
        _DetalleRow(label: 'Tipo de solicitud', value: solicitud.tipoSolicitud),
      ],
    );
  }
}

class _DetalleRow extends StatelessWidget {
  final String label;
  final String? value;

  const _DetalleRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    final texto = (value == null || value!.trim().isEmpty) ? '—' : value!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _SolicitudAcciones extends StatefulWidget {
  final SolicitudesPendientes solicitud;

  const _SolicitudAcciones({required this.solicitud});

  @override
  State<_SolicitudAcciones> createState() => _SolicitudAccionesState();
}

class _SolicitudAccionesState extends State<_SolicitudAcciones> {
  bool _enviandoImagenes = false;

  SolicitudesPendientes get _solicitud => widget.solicitud;

  void _setKivaRoute() {
    context.read<KivaRouteCubit>().setCurrentRouteProduct(
          nombreFormularioKiva: _solicitud.nombreFormulario ?? '',
          cantidadHijos: _solicitud.cantidadHijos ?? 0,
          cedula: _solicitud.cedula ?? '',
          tipoSolicitud: _solicitud.tipoSolicitud ?? '0',
          route: _solicitud.producto ?? '',
          solicitudId: _solicitud.solicitudId ?? '0',
          nombre: _solicitud.nombre ?? '',
          numero: _solicitud.numero ?? '',
          motivoAnterior:
              _solicitud.motivoAnterior ?? 'Motivo Anterior no registrado',
        );
  }

  void _abrirFormulario() {
    _setKivaRoute();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmationOfflineResponsesScreen(
          typeProduct: _solicitud.nombreFormulario ?? '',
          solicitudId: _solicitud.solicitudId ?? '',
          nombre: _solicitud.nombre ?? '',
          needGoBack: true,
        ),
      ),
    );
  }

  Future<void> _enviarImagenes() async {
    final localDb = context.read<SolicitudesPendientesLocalDbCubit>();
    final uploadCubit = context.read<UploadUserFileCubit>();
    final noImagesCubit = context.read<NoImagesKivasOnHistoryCubit>();
    final solicitudId = int.tryParse(_solicitud.solicitudId ?? '') ?? 0;

    setState(() => _enviandoImagenes = true);
    final imagenes = await localDb.findImagesModel(solicitudId);
    if (!mounted) return;

    if (imagenes == null) {
      setState(() => _enviandoImagenes = false);
      CustomAlertDialog(
        context: context,
        title: 'Esta solicitud no tiene imágenes guardadas en el teléfono',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.warning);
      return;
    }

    final enviadas = await uploadCubit.uploadUserFilesOffline(
      fotoFirma: imagenes.imagenFirma ?? 'NO PATH',
      solicitudId: solicitudId,
      formularioKiva: _solicitud.nombreFormulario ?? '',
      tipoSolicitud: _solicitud.tipoSolicitud ?? '',
      numero: _solicitud.numero ?? '',
      cedula: _solicitud.cedula ?? '',
      imagen1: imagenes.imagen1 ?? 'NO PATH',
      imagen2: imagenes.imagen2 ?? 'NO PATH',
      imagen3: imagenes.imagen3 ?? 'NO PATH',
      typeSigner: imagenes.typeSigner ?? '',
    );
    if (enviadas) {
      await localDb.updateIsImagesSendedOnSolicitud(
        solicitudId: _solicitud.solicitudId ?? '',
      );
      // Refresca el tag "Imágenes pendientes".
      noImagesCubit.getNoImagesKivasOnHistory();
    }
    if (mounted) setState(() => _enviandoImagenes = false);
  }

  @override
  Widget build(BuildContext context) {
    final subiendoAlguna = context.select<UploadUserFileCubit, bool>(
      (cubit) => cubit.state.status == Status.inProgress,
    );
    return Column(
      children: [
        CustomElevatedButton(
          onPressed: _abrirFormulario,
          text: 'Enviar formulario Kiva',
          color: AppColors.getSecondaryColor(),
        ),
        const Gap(12),
        CustomElevatedButton(
          enabled: !subiendoAlguna && !_enviandoImagenes,
          onPressed: _enviarImagenes,
          text: _enviandoImagenes
              ? 'Enviando imágenes...'
              : 'Enviar imágenes Kiva',
          color: AppColors.getPrimaryColor(),
        ),
      ],
    );
  }
}
