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
            return SingleChildScrollView(
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
            );
          },
        ),
      ),
    );
  }
}

class _SolicitudExpasionTitle extends StatelessWidget {
  final SolicitudesPendientes solicitud;
  final ImageModel? imageModel;
  const _SolicitudExpasionTitle({
    required this.solicitud,
    this.imageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ExpansionTitleCustom(
        title: Text(
          '${solicitud.nombre} ${solicitud.numero}',
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
                  context
                      .read<SolicitudesPendientesLocalDbCubit>()
                      .getImagesModel(
                        int.parse(
                          solicitud.solicitudId ?? '0',
                        ),
                      );
                  if (!context.mounted) return;
                  context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                        fotoFirma: imageModel?.imagenFirma ?? 'NO PATH',
                        solicitudId: int.parse(
                          solicitud.solicitudId ?? '0',
                        ),
                        formularioKiva: solicitud.producto ?? '',
                        tipoSolicitud: solicitud.tipoSolicitud ?? '',
                        numero: solicitud.numero ?? '',
                        cedula: solicitud.cedula ?? '',
                        imagen1: imageModel?.imagen1 ?? 'NO PATH',
                        imagen2: imageModel?.imagen2 ?? 'NO PATH',
                        imagen3: imageModel?.imagen3 ?? 'NO PATH',
                        typeSigner: imageModel?.typeSigner ?? '',
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
                          cantidadHijos: solicitud.cantidadHijos ?? 0,
                          cedula: solicitud.cedula ?? '',
                          tipoSolicitud: solicitud.tipoSolicitud ?? '0',
                          route: solicitud.producto ?? '',
                          solicitudId: solicitud.solicitudId ?? '0',
                          nombre: solicitud.nombre ?? '',
                          numero: solicitud.nombre ?? '',
                          motivoAnterior: solicitud.motivoAnterior ??
                              'Motivo Anterior no registrado',
                        );
                    return ConfirmationOfflineResponsesScreen(
                      typeProduct: solicitud.producto ?? '',
                      widgetsolicitudId: solicitud.solicitudId,
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
