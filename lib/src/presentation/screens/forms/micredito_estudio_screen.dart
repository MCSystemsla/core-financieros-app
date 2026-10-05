import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/add_kiva_images_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/form_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/descripcion_academica.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/micredi_estudio_credito_anterior_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/micredi_estudio_entorno_social_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/micredi_estudio_impacto_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/signatures/micrediestudio_signature_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/signatures/recurrente_micrediestudio_signature_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MiCreditoEstudioScreen extends StatelessWidget {
  final String typeProduct;
  const MiCreditoEstudioScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm = typeProduct == 'ScrKivaMiCrediEstudioRecurrente';
    final PageController pageController = PageController();
    final repository = ResponsesRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMicrediEstudioCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => MicrediEstudioCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(repository)
            ..getMotivoPrestamo(
              numero: int.parse(
                context.read<KivaRouteCubit>().state.solicitudId,
              ),
            ),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                'MiCredi Estudio  ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'
                    .tr()),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AddKivaImagesWidget(
                controller: pageController,
              ),
              MiCrediEstudioEntornoSocialForm(
                controller: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              DescripcionAcademica(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              if (isRecurrentForm)
                MicreditoCreditoAnterior(
                  pageController: pageController,
                ),
              MiCrediEstudioImpactoSocialWidget(
                controller: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(controller: pageController),
              isRecurrentForm
                  ? RecurrenteMicrediestudioSignatureWidget(
                      controller: pageController,
                    )
                  : MicrediestudioSignatureWidget(
                      controller: pageController,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
