import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/kiva_request_not_saved_response.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
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

class SolicitudesUploadedWidget extends StatelessWidget {
  final List<SolicitudesPendientes> solicitudes;
  final ImageModel? imageModel;
  const SolicitudesUploadedWidget({
    super.key,
    required this.solicitudes,
    this.imageModel,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 60, color: AppColors.getPrimaryColor()),
            const SizedBox(height: 16),
            const Text(
              'No tienes solicitudes enviadas',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return BlocBuilder<NoImagesKivasOnHistoryCubit,
        NoImagesKivasOnHistoryState>(
      builder: (context, noImagesKivasOnHistoryState) {
        final haveRequestPending = noImagesKivasOnHistoryState
            is OnNoImagesKivasOnHistoryHaveRequestPending;
        List<KivaRequestNotSavedUser>? pendingRequestList =
            haveRequestPending ? noImagesKivasOnHistoryState.data.data : [];
        return SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<UploadUserFileCubit, UploadUserFileState>(
                listener: (context, state) {
                  if (state.status == Status.done) {
                    CustomAlertDialog(
                      context: context,
                      title: 'Imagenes Enviadas Exitosamente',
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
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: solicitudes.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const KivaFormSpacing();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return _SolicitudExpasionTitle(
                        solicitud: solicitudes[index],
                        imageModel: imageModel,
                        status: state.status,
                        haveRequestPendingToSendImages: pendingRequestList!.any(
                            (req) => req.numero == solicitudes[index].numero),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SolicitudExpasionTitle extends StatefulWidget {
  final SolicitudesPendientes solicitud;
  final ImageModel? imageModel;
  final Status status;
  final bool haveRequestPendingToSendImages;
  const _SolicitudExpasionTitle({
    required this.solicitud,
    required this.status,
    required this.haveRequestPendingToSendImages,
    this.imageModel,
  });

  @override
  State<_SolicitudExpasionTitle> createState() =>
      _SolicitudExpasionTitleState();
}

class _SolicitudExpasionTitleState extends State<_SolicitudExpasionTitle> {
  ImageModel? imagenes;

  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  initFunctions() async {
    context.read<KivaRouteCubit>().setCurrentRouteProduct(
          nombreFormularioKiva: widget.solicitud.nombreFormulario ?? '',
          cantidadHijos: widget.solicitud.cantidadHijos ?? 0,
          cedula: widget.solicitud.cedula ?? '',
          tipoSolicitud: widget.solicitud.tipoSolicitud ?? '0',
          route: widget.solicitud.producto ?? '',
          solicitudId: widget.solicitud.solicitudId ?? '0',
          nombre: widget.solicitud.nombre ?? '',
          numero: widget.solicitud.numero ?? '',
          motivoAnterior: widget.solicitud.motivoAnterior ??
              'Motivo Anterior no registrado',
        );
    final dbProvider = context.read<SolicitudesPendientesLocalDbCubit>();
    imagenes = await dbProvider.getImagesModel(
      int.parse(widget.solicitud.solicitudId ?? '0'),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ExpansionTitleCustom(
        key: ValueKey(widget.solicitud.id),
        title: _ExpansionRowTitle(
          solicitud: widget.solicitud,
          haveRequestPendingToSendImages: widget.haveRequestPendingToSendImages,
        ),
        finalStep: true,
        children: [
          SolicitudExpansionTitle(solicitud: widget.solicitud),
          _ExpansionButtonsWidget(
            imagenes: imagenes,
            solicitud: widget.solicitud,
            status: widget.status,
          ),
        ],
      ),
    );
  }
}

class SolicitudExpansionTitle extends StatelessWidget {
  final SolicitudesPendientes solicitud;

  const SolicitudExpansionTitle({super.key, required this.solicitud});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(12),
        const Text(
          '📄 Detalles de Solicitud',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const Gap(10),
        Text(
          '📄 Solicitud ID: ${solicitud.solicitudId}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Gap(10),
        Text(
          '📄 Numero: ${solicitud.numero}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Gap(10),
        Text(
          '📄 Producto: ${solicitud.producto}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Gap(10),
        Text(
          '📄 Tipo Solicitud: ${solicitud.tipoSolicitud}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ExpansionButtonsWidget extends StatelessWidget {
  final ImageModel? imagenes;
  final SolicitudesPendientes solicitud;
  final Status status;

  const _ExpansionButtonsWidget({
    this.imagenes,
    required this.solicitud,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConfirmationOfflineResponsesScreen(
                  typeProduct: solicitud.nombreFormulario ?? '',
                  solicitudId: solicitud.solicitudId.toString(),
                  nombre: solicitud.nombre ?? '',
                  needGoBack: true,
                ),
              ),
            );
          },
          text: '📝 Enviar Formulario Kiva',
          color: AppColors.getSecondaryColor(),
        ),
        const Gap(15),
        CustomElevatedButton(
          enabled: status != Status.inProgress,
          onPressed: () {
            if (!context.mounted) return;
            context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                  fotoFirma: imagenes?.imagenFirma ?? 'NO PATH',
                  solicitudId: int.parse(
                    solicitud.solicitudId ?? '0',
                  ),
                  formularioKiva: solicitud.nombreFormulario ?? '',
                  tipoSolicitud: solicitud.tipoSolicitud ?? '',
                  numero: solicitud.numero ?? '',
                  cedula: solicitud.cedula ?? '',
                  imagen1: imagenes?.imagen1 ?? 'NO PATH',
                  imagen2: imagenes?.imagen2 ?? 'NO PATH',
                  imagen3: imagenes?.imagen3 ?? 'NO PATH',
                  typeSigner: imagenes?.typeSigner ?? '',
                );
          },
          text: '📤 Enviar Imágenes Kiva',
          color: AppColors.getPrimaryColor(),
        ),
      ],
    );
  }
}

class _ExpansionRowTitle extends StatelessWidget {
  final SolicitudesPendientes solicitud;
  final bool haveRequestPendingToSendImages;

  const _ExpansionRowTitle({
    required this.solicitud,
    required this.haveRequestPendingToSendImages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.assignment, color: Colors.blue),
        const Gap(8),
        if (haveRequestPendingToSendImages) ...[
          Pulse(
            infinite: true,
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              maxRadius: 8,
            ),
          ),
          const Gap(8),
        ],
        Expanded(
          child: Text(
            '${solicitud.nombre}, ${solicitud.numero}',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
