import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/add_kiva_images_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/form_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/descripcion_y_desarrollo_del_negocio_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/mujer_emprende_entorno_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/mujer_emprende_impacto_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/signatures/mujer_emprende_signature_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/signatures/recurrente_mujer_emprende_signature_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MujerEmprenderScreen extends StatelessWidget {
  final String typeProduct;
  const MujerEmprenderScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final repository = ResponsesRepositoryImpl();
    final isRecurrentForm = typeProduct == 'ScrKivaMujerEmprendeRecurrente';
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMujerEmprendeCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => MujerEmprendeCubit(repository),
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
                'Mujer Emprende ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AddKivaImagesWidget(
                controller: pageController,
              ),
              MujerEmprendeEntornoSocialWidget(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              DescripcionYDesarrolloDelNegocioWidget(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              MujerEmprendeImpactoSocial(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(
                controller: pageController,
              ),
              isRecurrentForm
                  ? RecurrenteMujerEmprendeSignatureWidget(
                      controller: pageController,
                    )
                  : MujerEmprendeSignatureWidget(
                      controller: pageController,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
