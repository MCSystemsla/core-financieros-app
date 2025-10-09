import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitud_catalogo/hn/solicitud_catalogo_hn/solicitud_catalogo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadCatalogosDialogHn extends StatefulWidget {
  final VoidCallback? onDownloadComplete;

  const DownloadCatalogosDialogHn({super.key, this.onDownloadComplete});

  @override
  State<DownloadCatalogosDialogHn> createState() =>
      _DownloadCatalogosDialogHnState();
}

class _DownloadCatalogosDialogHnState extends State<DownloadCatalogosDialogHn> {
  @override
  void initState() {
    super.initState();
    context.read<SolicitudCatalogoHnCubit>().saveAllCatalogos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SolicitudCatalogoHnCubit, SolicitudCatalogoHnState>(
        builder: (context, state) {
          return switch (state.status) {
            Status.inProgress => const DownloadCatalogoLoading(
                lottieAsset: ImageAsset.downloadCatalogoLoading,
                text: 'Sincronizando catalogos HN...',
              ),
            Status.done => DownloadCatalogoLoading(
                lottieAsset: ImageAsset.downloadCatalogosSuccess,
                text: 'Sincronización completada con éxito.',
                repeat: false,
                isSucess: true,
                onDownloadComplete: widget.onDownloadComplete,
              ),
            Status.error => OnErrorWidget(
                onPressed: () {
                  context.read<SolicitudCatalogoHnCubit>().saveAllCatalogos();
                },
                btnTitle: 'Intentar de nuevo',
                errorMsg: state.errorMsg,
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
