import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AsalariadoSendingForm extends StatefulWidget {
  final int solicitudId;
  const AsalariadoSendingForm({super.key, required this.solicitudId});

  @override
  State<AsalariadoSendingForm> createState() => _AsalariadoSendingFormState();
}

class _AsalariadoSendingFormState extends State<AsalariadoSendingForm> {
  final localDbProvider = global<ObjectBoxService>();

  @override
  initState() {
    super.initState();
    final imagesCedula = localDbProvider.getCedula(
      cedula: context.read<SolicitudAsalariadoCubit>().state.cedula,
      tipoSolicitud: 'ASALARIADO',
    );
    context.read<SolicitudAsalariadoCubit>().saveCedula(
          cedulaFrontPath: imagesCedula?.imageFrontCedula,
          cedulaBackPath: imagesCedula?.imageBackCedula,
        );
    context.read<SolicitudAsalariadoCubit>().createSolicitudAsalariado();
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = global<ObjectBoxService>();
    return BlocConsumer<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          context.read<SolicitudAsalariadoCubit>().sendCedulaImages(
                numeroSolicitud: state.numeroSolicitud,
              );
          dbProvider.removeSolicitudAsalariadoWhenisUploaded(
            solicitudId: widget.solicitudId,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ExitConfirmationDialog(
                  context: context,
                  title: '¿Estás seguro de que quieres salir?',
                  onYes: () {
                    context.pushReplacement('/');
                  },
                ).showDialog(context);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          body: switch (state.status) {
            Status.inProgress => const DownloadCatalogoLoading(
                lottieAsset: ImageAsset.nuevaMenorUploading,
                text: 'Enviando solicitud a servidor...',
              ),
            Status.done => Padding(
                padding: const EdgeInsets.all(10),
                child: DownloadCatalogoLoading(
                  isSucess: true,
                  lottieAsset: ImageAsset.nuevaMenorSuccess,
                  text:
                      'Solicitud enviada exitosamente!!\n\n ${state.successMsg}',
                  repeat: false,
                  isUploadingForms: true,
                ),
              ),
            Status.error => OnErrorWidget(
                needToGoBack: true,
                errorMsg: state.errorMsg,
                onPressed: () {
                  context
                      .read<SolicitudAsalariadoCubit>()
                      .createSolicitudAsalariado();
                },
              ),
            _ => const SizedBox(),
          },
        );
      },
    );
  }
}
