import 'dart:io';

import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/repository/expediente_digital/expediente_digital_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/subir_otros_archivos/subir_otros_archivos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/camera_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/otros_archivos/sending_otros_archivos_view.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/screen_header_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Pantalla genérica para fotografiar un documento y subirlo como PDF al
/// expediente digital. Cada tipo de archivo se configura por props.
class SubirOtrosArchivosScreen extends StatelessWidget {
  final String numeroSolicitud;
  final String cedulaCliente;
  final DigitalFilename filename;
  final String documentName;
  final String title;
  final String subtitle;
  final bool isMultipleImages;

  const SubirOtrosArchivosScreen({
    super.key,
    required this.numeroSolicitud,
    required this.cedulaCliente,
    required this.filename,
    required this.documentName,
    required this.title,
    required this.subtitle,
    this.isMultipleImages = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubirOtrosArchivosCubit(ExpedienteDigitalRepositoryImpl()),
      child: Stack(
        children: [
          _SubirOtrosArchivosForm(
            numeroSolicitud: numeroSolicitud,
            cedulaCliente: cedulaCliente,
            filename: filename,
            documentName: documentName,
            title: title,
            subtitle: subtitle,
            isMultipleImages: isMultipleImages,
          ),
          SendingOtrosArchivosView(
            numeroSolicitud: numeroSolicitud,
            documentName: documentName,
          ),
        ],
      ),
    );
  }
}

class _SubirOtrosArchivosForm extends StatelessWidget {
  final String numeroSolicitud;
  final String cedulaCliente;
  final DigitalFilename filename;
  final String documentName;
  final String title;
  final String subtitle;
  final bool isMultipleImages;
  const _SubirOtrosArchivosForm({
    required this.numeroSolicitud,
    required this.cedulaCliente,
    required this.filename,
    required this.documentName,
    required this.title,
    required this.subtitle,
    required this.isMultipleImages,
  });

  void _takePhoto(BuildContext context) {
    final cubit = context.read<SubirOtrosArchivosCubit>();
    context.pushTransparentRoute(
      CameraCaptureScreen(
        numeroSoicitud: numeroSolicitud,
        onImageSelected: (image, _) {
          if (image == null) return;
          cubit.addImage(image.path);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RedesignColors.background,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<SubirOtrosArchivosCubit, SubirOtrosArchivosState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      ScreenHeaderWidget(
                        title: title,
                        subtitle: subtitle,
                        onBack: () => Navigator.pop(context),
                      ),
                      const Gap(24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            for (int i = 0;
                                i < state.imagePaths.length;
                                i++) ...[
                              _PhotoPageCard(
                                label: isMultipleImages
                                    ? 'Página ${i + 1}'
                                    : 'Foto del $documentName',
                                path: state.imagePaths[i],
                                onRemove: () => context
                                    .read<SubirOtrosArchivosCubit>()
                                    .removeImage(i),
                              ),
                              const Gap(10),
                            ],
                            if (isMultipleImages || state.imagePaths.isEmpty)
                              _AddPhotoSlot(
                                label: state.imagePaths.isEmpty
                                    ? 'Tomar foto del $documentName'
                                    : 'Agregar otra página',
                                onTap: () => _takePhoto(context),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: SafeArea(
                    top: false,
                    child: CustomElevatedButton(
                      text: 'Enviar $documentName',
                      color: RedesignColors.green,
                      enabled: state.imagePaths.isNotEmpty &&
                          state.status != Status.inProgress,
                      onPressed: () => context
                          .read<SubirOtrosArchivosCubit>()
                          .subirArchivo(
                            filename: filename,
                            cedulaCliente: cedulaCliente,
                            numeroSolicitud: int.tryParse(numeroSolicitud) ?? 0,
                          ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PhotoPageCard extends StatelessWidget {
  final String label;
  final String path;
  final VoidCallback onRemove;
  const _PhotoPageCard({
    required this.label,
    required this.path,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(path),
              height: 64,
              width: 64,
              fit: BoxFit.cover,
              cacheWidth: 192,
            ),
          ),
          const Gap(13),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.15,
                color: RedesignColors.ink,
              ),
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: RedesignColors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPhotoSlot extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _AddPhotoSlot({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          color: RedesignColors.tagBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RedesignColors.border),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.photo_camera_outlined,
              size: 28,
              color: RedesignColors.indigo,
            ),
            const Gap(8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: RedesignColors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
