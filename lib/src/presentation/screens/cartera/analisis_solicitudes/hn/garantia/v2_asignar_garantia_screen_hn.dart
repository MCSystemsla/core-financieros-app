import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/create_garantia_asignacion_hn.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/analisis/hn/analisis_create_asignacion_garantia/analisis_create_asignacion_garantia_cubit.dart';

class V2AsignarGarantiaScreenHn extends StatelessWidget {
  final int objAnalisisGarantiaId;
  final int objGarantiaBienId;
  final int porcentajeCobertura;
  final String observaciones;
  final GarantiaAsignacionValoracion valoracion;
  const V2AsignarGarantiaScreenHn({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.objGarantiaBienId,
    required this.porcentajeCobertura,
    required this.observaciones,
    required this.valoracion,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => AnalisisCreateAsignacionGarantiaCubit(
        AnalisisRepositoryHNImpl(),
      )
        ..setAsignacionGarantiaFields(
          objAnalisisGarantiaId: objAnalisisGarantiaId,
          objGarantiaBienId: objGarantiaBienId,
          porcentajeCobertura: porcentajeCobertura,
          observaciones: observaciones,
          valoracion: valoracion,
        )
        ..createAsignacionGarantia(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<AnalisisCreateAsignacionGarantiaCubit,
            AnalisisCreateAsignacionGarantiaState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const ModernLoadingWidget(
                  message: 'Asignando Garantia',
                ),
              Status.error => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () {
                    context
                        .read<AnalisisCreateAsignacionGarantiaCubit>()
                        .createAsignacionGarantia();
                  },
                ),
              Status.done => Padding(
                  padding: const EdgeInsets.all(10),
                  child: DownloadCatalogoLoading(
                    isSucess: true,
                    lottieAsset: ImageAsset.nuevaMenorSuccess,
                    text: state.successMsg,
                    repeat: false,
                    isUploadingForms: true,
                    onDownloadComplete: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AnalisisInterceptorByFlavor(),
                        ),
                      );
                    },
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
