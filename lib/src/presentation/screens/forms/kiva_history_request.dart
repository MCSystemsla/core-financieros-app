import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_history/solicitudes_uploaded_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KivaHistoryRequestScreen extends StatefulWidget {
  const KivaHistoryRequestScreen({super.key});

  @override
  State<KivaHistoryRequestScreen> createState() =>
      _KivaHistoryRequestScreenState();
}

class _KivaHistoryRequestScreenState extends State<KivaHistoryRequestScreen> {
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesEnviadasKivaProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesEnviadasKivaProvider.getSolicitudesUploaded();
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
