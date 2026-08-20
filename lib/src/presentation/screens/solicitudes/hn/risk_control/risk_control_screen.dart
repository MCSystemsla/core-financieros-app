import 'dart:typed_data';

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/risk_control/risk_control_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pdfrx/pdfrx.dart';

class RiskControlScreen extends StatelessWidget {
  final PageController pageController;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String tipoIdentificacion;
  final String identificacion;
  final String tipoOrganizacion;
  const RiskControlScreen({
    super.key,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
    required this.tipoIdentificacion,
    required this.identificacion,
    required this.tipoOrganizacion,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => RiskControlCubit(
        SolicitudesCreditoHnRepositoryImpl(),
      )..getRiskControlByUserInfo(
          nombre1: nombre1,
          nombre2: nombre2,
          apellido1: apellido1,
          apellido2: apellido2,
          tipoIdentificacion: tipoIdentificacion,
          identificacion: identificacion,
          tipoOrganizacion: tipoOrganizacion,
        ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RiskControlTitle(),
              BlocBuilder<RiskControlCubit, RiskControlState>(
                builder: (context, state) {
                  return switch (state.status) {
                    Status.inProgress => const LoadingWidget(),
                    Status.done => _PdfView(
                        filePath: state.filePath!,
                      ),
                    Status.error =>
                      Text('Error al generar el reporte: ${state.errorMsg}'),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
              BlocBuilder<RiskControlCubit, RiskControlState>(
                builder: (context, state) {
                  return switch (state.status) {
                    Status.done => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        child: CustomElevatedButton(
                          text: 'Ver reporte en pantalla completa',
                          // ignore: deprecated_member_use
                          color: Colors.black,
                          onPressed: () {
                            if (state.filePath != null) {
                              context.pushTransparentRoute(
                                PDFRiskControlView(pdfData: state.filePath!),
                              );
                            }
                          },
                        ),
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
              const Gap(30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: CustomElevatedButton(
                  text: 'Siguiente',
                  // ignore: deprecated_member_use
                  color: AppColors.greenLatern.withOpacity(0.4),
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomOutLineButton(
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  text: 'Anterior',
                  textColor: AppColors.red,
                  color: AppColors.red,
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

class _PdfView extends StatelessWidget {
  final Uint8List filePath;
  const _PdfView({required this.filePath});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: PdfViewer.data(
          filePath,
          sourceName: 'risk_control.pdf',
          params: const PdfViewerParams(
            textSelectionParams: PdfTextSelectionParams(
              enabled: true,
            ),
            backgroundColor: Colors.transparent,
            enableKeyboardNavigation: true,
            sizeDelegateProvider: PdfViewerSizeDelegateProviderLegacy(
              maxScale: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _RiskControlTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 5),
          child: Text(
            'Reporte de Risk Control',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            'Visualice los detalles del análisis de riesgo a continuación.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class PDFRiskControlView extends StatelessWidget {
  final Uint8List pdfData;
  const PDFRiskControlView({
    super.key,
    required this.pdfData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          // ignore: deprecated_member_use
          Colors.black.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Vista Previa del Reporte',
            style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PdfViewer.data(
            pdfData,
            sourceName: 'risk_control.pdf',
            params: const PdfViewerParams(
              enableKeyboardNavigation: true,
            ),
          ),
        ),
      ),
    );
  }
}
