import 'dart:typed_data';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/reporteria/hn/reporteria_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../../../../bloc/reportes/hn/reporte_mora/reporte_mora_cubit.dart';

class ReporteMoraScreenHn extends StatelessWidget {
  const ReporteMoraScreenHn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ReporteMoraCubit(
        ReporteriaRepositoryHNImpl(),
      )..getReporteMora(
          userId: int.tryParse(LocalStorage().userId) ?? 0,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reporte de Mora'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                _RiskControlTitle(),
                BlocBuilder<ReporteMoraCubit, ReporteMoraState>(
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
                BlocBuilder<ReporteMoraCubit, ReporteMoraState>(
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
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      context.pop();
                    },
                    text: 'Salir',
                    textColor: AppColors.red,
                    color: AppColors.red,
                  ),
                ),
                const Gap(20),
              ],
            ),
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
      height: 600,
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
          sourceName: 'reporte_mora.pdf',
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
            'Reporte de Mora',
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
            sourceName: 'reporte_mora.pdf',
            params: const PdfViewerParams(
              sizeDelegateProvider: PdfViewerSizeDelegateProviderLegacy(
                maxScale: 8.0,
              ),
              enableKeyboardNavigation: true,
            ),
          ),
        ),
      ),
    );
  }
}
