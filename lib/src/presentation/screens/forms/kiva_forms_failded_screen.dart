import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_history/solicitudes_uploaded_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/pinput/custom_pinput_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KivaFormsFaildedScreen extends StatefulWidget {
  const KivaFormsFaildedScreen({super.key});

  @override
  State<KivaFormsFaildedScreen> createState() => _KivaFormsFaildedScreenState();
}

class _KivaFormsFaildedScreenState extends State<KivaFormsFaildedScreen> {
  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  initFunctions() async {
    final solicitudesEnviadasKivaProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesEnviadasKivaProvider.getSolicitudesFailed();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => UploadUserFileCubit(
        ResponsesRepositoryImpl(),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(
            Icons.bookmark,
            color: Colors.white,
          ),
          backgroundColor: AppColors.getSecondaryColor(),
          onPressed: () {
            context.pushTransparentRoute(const CustomPinputWidget());
          },
          label: const Text(
            'Kiva Historico',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Solicitudes Kiva Fallidas'),
        ),
        body: BlocBuilder<SolicitudesPendientesLocalDbCubit,
            SolicitudesPendientesLocalDbState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.done => SolicitudesUploadedWidget(
                  solicitudes: state.solicitudes,
                  imageModel: state.imageModel,
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
