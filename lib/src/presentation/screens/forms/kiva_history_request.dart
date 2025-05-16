import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/confirmation/confirmation_offline_responses_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_form_spacing.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class KivaHistoryRequestScreen extends StatefulWidget {
  const KivaHistoryRequestScreen({super.key});

  @override
  State<KivaHistoryRequestScreen> createState() =>
      _KivaHistoryRequestScreenState();
}

class _KivaHistoryRequestScreenState extends State<KivaHistoryRequestScreen> {
  @override
  void initState() {
    final solicitudesEnviadasKivaProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    solicitudesEnviadasKivaProvider.getSolicitudesUploaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UploadUserFileCubit(
        ResponsesRepositoryImpl(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historial Solicitudes Kiva Enviadas'),
          centerTitle: true,
        ),
        body: BlocBuilder<SolicitudesPendientesLocalDbCubit,
            SolicitudesPendientesLocalDbState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.done => SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.solicitudes.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const KivaFormSpacing();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return _SolicitudExpasionTitle(
                            solicitud: state.solicitudes[index],
                            imageModel: state.imageModel,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class _SolicitudExpasionTitle extends StatefulWidget {
  final SolicitudesPendientes solicitud;
  final ImageModel? imageModel;
  const _SolicitudExpasionTitle({
    required this.solicitud,
    this.imageModel,
  });

  @override
  State<_SolicitudExpasionTitle> createState() =>
      _SolicitudExpasionTitleState();
}

class _SolicitudExpasionTitleState extends State<_SolicitudExpasionTitle> {
  @override
  void initState() {
    final solicitudId = widget.solicitud.solicitudId ?? '';
    context.read<SolicitudesPendientesLocalDbCubit>().getImagesModel(
          int.parse(solicitudId),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ExpansionTitleCustom(
        title: Text(
          '${widget.solicitud.nombre} ${widget.solicitud.numero}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
        finalStep: true,
        children: [
          const Text(
            'Detalles de Solicitud',
          ),
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
                  title: 'Error inesperado, intenta de nuevo',
                  onDone: () => context.pop(),
                ).showDialog(context, dialogType: DialogType.error);
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                enabled: state.status != Status.inProgress,
                onPressed: () {
                  if (!context.mounted) return;
                  context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                        fotoFirma: widget.imageModel?.imagenFirma ?? 'NO PATH',
                        solicitudId: int.parse(
                          widget.solicitud.solicitudId ?? '0',
                        ),
                        formularioKiva: widget.solicitud.producto ?? '',
                        tipoSolicitud: widget.solicitud.tipoSolicitud ?? '',
                        numero: widget.solicitud.numero ?? '',
                        cedula: widget.solicitud.cedula ?? '',
                        imagen1: widget.imageModel?.imagen1 ?? 'NO PATH',
                        imagen2: widget.imageModel?.imagen2 ?? 'NO PATH',
                        imagen3: widget.imageModel?.imagen3 ?? 'NO PATH',
                        typeSigner: widget.imageModel?.typeSigner ?? '',
                      );
                },
                text: 'Enviar Imagenes Kiva',
                color: AppColors.getPrimaryColor(),
              );
            },
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    context.read<KivaRouteCubit>().setCurrentRouteProduct(
                          cantidadHijos: widget.solicitud.cantidadHijos ?? 0,
                          cedula: widget.solicitud.cedula ?? '',
                          tipoSolicitud: widget.solicitud.tipoSolicitud ?? '0',
                          route: widget.solicitud.producto ?? '',
                          solicitudId: widget.solicitud.solicitudId ?? '0',
                          nombre: widget.solicitud.nombre ?? '',
                          numero: widget.solicitud.nombre ?? '',
                          motivoAnterior: widget.solicitud.motivoAnterior ??
                              'Motivo Anterior no registrado',
                        );
                    return ConfirmationOfflineResponsesScreen(
                      typeProduct: widget.solicitud.producto ?? '',
                      widgetsolicitudId: widget.solicitud.solicitudId,
                    );
                  },
                ),
              );
            },
            text: 'Enviar Formulario Kiva',
            color: AppColors.getSecondaryColor(),
          ),
        ],
      ),
    );
  }
}
