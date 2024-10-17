import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/descripcion_y_desarrollo_del_negocio_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/mujer_emprende_entorno_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/mujer_emprende_impacto_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';

class MujerEmprenderScreen extends StatelessWidget {
  final String typeProduct;
  const MujerEmprenderScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm = typeProduct == 'MUJER EMPRENDE RECURRENTE';
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => MujerEmprendeCubit(ResponsesRepositoryImpl()),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
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
              SaneamientoContent(
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
              const _SignSignature(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignSignature extends StatelessWidget {
  const _SignSignature();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    return Column(
      children: [
        const MiCreditoProgress(
          steps: 5,
          currentStep: 5,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'forms.firmar.title'.tr(),
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'forms.firmar.description'.tr(),
                  style: TextStyle(
                    color: AppColors.greyWithOpacityV4,
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: Stack(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.boxGrey,
                            width: .9,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Signature(
                            key: const Key('signature'),
                            controller: controller,
                            // height: size.height * .56,
                            width: size.width * .9,
                            backgroundColor: AppColors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconBorder.fromIcon(
                          color: AppColors.red,
                          icon: Icons.delete_forever,
                          onTap: () => controller.clear(),
                          size: const Size(44, 44),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(30),
                BlocConsumer<MujerEmprendeCubit, MujerEmprendeState>(
                  listener: (context, state) async {
                    final status = state.status;
                    if (status == Status.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                          content: Text('Error inesperado'),
                        ),
                      );
                    }
                    if (state.status == Status.done) {
                      await customPopUp(
                        context: context,
                        dismissOnTouchOutside: false,
                        size: size,
                        title: 'Formulario Kiva Enviado exitosamente!!',
                        subtitle: 'Las respuestas se han enviado Exitosamente',
                        dialogType: DialogType.success,
                        buttonAcept: true,
                        textButtonAcept: 'Ok',
                        colorButtonAcept: AppColors.getPrimaryColor(),
                        onPressedAccept: () {
                          context.pushReplacement('/');
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.white,
                      ),
                      enabled: state.status != Status.inProgress,
                      positionIcon: PositionIcon.left,
                      text: state.status == Status.inProgress
                          ? 'Cargando...'
                          : 'button.send'.tr(),
                      color: context.primaryColor(),
                      onPressed: () async {
                        await customPopUp(
                          context: context,
                          size: size,
                          title:
                              'Confirmas que has leido y confirmado el Formulario Kiva?',
                          dialogType: DialogType.warning,
                          buttonAcept: true,
                          buttonCancel: true,
                          colorButtonCancel: AppColors.red,
                          textButtonAcept: 'Aceptar',
                          textButtonCancel: 'Cancelar',
                          colorButtonAcept: AppColors.getPrimaryColor(),
                          onPressedAccept: () {
                            context.read<MujerEmprendeCubit>().sendAnswers();
                            context.pop();
                          },
                          onPressedCancel: () => context.pop(),
                        );
                      },
                    );
                  },
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
