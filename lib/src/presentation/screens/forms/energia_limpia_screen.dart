import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/add_kiva_images_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/form_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_adtional_data_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_credito_anterior.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_entorno_familiar.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_impacto_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/signatures/energia_limpia_signature_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/signatures/recurrente_energia_limpia_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnergiaLimpiaScreen extends StatelessWidget {
  final String typeProduct;
  const EnergiaLimpiaScreen({
    super.key,
    required this.typeProduct,
  });

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm = typeProduct == 'ScrKivaEnergiaLimpiaRecurrente';
    final pageController = PageController();
    final responseRepository = ResponsesRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(responseRepository),
        ),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(responseRepository)
            ..getMotivoPrestamo(
              numero: int.parse(
                context.read<KivaRouteCubit>().state.solicitudId,
              ),
            ),
        ),
        BlocProvider(
          create: (ctx) => EnergiaLimpiaCubit(responseRepository),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteEnergiaLimpiaCubit(responseRepository),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                'Energia Limpia ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AddKivaImagesWidget(
                controller: pageController,
              ),
              EnergiaLimpiaAditionalDataWidget(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              EnergiaLimpiaEntornoFamiliar(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              if (isRecurrentForm)
                EnergiaLimpiaCreditoAnterior(
                  pageController: pageController,
                ),
              EnergiaLimpiaImpactoSocial(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(
                controller: pageController,
              ),
              isRecurrentForm
                  ? RecurrenteEnergiaLimpiaWidget(controller: pageController)
                  : EnergiaLimpiaSignatureWidget(controller: pageController),
            ],
          ),
        ),
      ),
    );
  }
}
