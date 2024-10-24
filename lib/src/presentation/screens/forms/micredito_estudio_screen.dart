import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/descripcion_academica.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';

class MiCreditoEstudioScreen extends StatelessWidget {
  final String typeProduct;
  const MiCreditoEstudioScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm = typeProduct == 'MICREDIESTUDIO RECURRENTE';
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
              SaneamientoContent(
                controller: pageController,
              ),
              _EntornoSocialEstudioWidget(
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
              _ImpactoSocialCrediEstudioWidget(
                controller: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(controller: pageController),
              isRecurrentForm
                  ? const _RecurrentSigntature()
                  : const _SignUserSignature(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecurrentSigntature extends StatelessWidget {
  const _RecurrentSigntature();

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
                BlocConsumer<RecurrenteMicrediEstudioCubit,
                    RecurrenteMicrediEstudioState>(
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
                            context
                                .read<RecurrenteMicrediEstudioCubit>()
                                .sendAnswers();
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

class MicreditoCreditoAnterior extends StatefulWidget {
  final PageController pageController;
  const MicreditoCreditoAnterior({
    super.key,
    required this.pageController,
  });

  @override
  State<MicreditoCreditoAnterior> createState() =>
      _MicreditoCreditoAnteriorState();
}

class _MicreditoCreditoAnteriorState extends State<MicreditoCreditoAnterior> {
  String? coincideRespuesta;
  final explicacionInversion = TextEditingController();
  final comoAyudoProfesionalmente = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'Descripción del crédito anterior MiCrédiEstudio'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            WhiteCard(
              padding: const EdgeInsets.all(5),
              child: JLuxDropdown(
                isContainIcon: true,
                validator: (value) {
                  if (value == null) return 'input.input_validator'.tr();

                  return null;
                },
                title:
                    '¿Coincide la respuesta del cliente con el formato anterior?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  coincideRespuesta = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            if (coincideRespuesta == 'input.no'.tr())
              CommentaryWidget(
                title:
                    '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                textEditingController: explicacionInversion,
              ),
            const Gap(20),
            CommentaryWidget(
              title:
                  '¿De qué manera ayudó este préstamo Kiva en su vida profesional?*',
              textEditingController: comoAyudoProfesionalmente,
            ),
            const Gap(20),
            ButtonActionsWidget(
              onPreviousPressed: () {
                widget.pageController.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                // if (formKey.currentState?.validate() ?? false) {
                context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                      coincideRespuesta: coincideRespuesta == 'input.yes'.tr(),
                      explicacionInversion: explicacionInversion.text.trim(),
                      comoAyudoProfesionalmente:
                          comoAyudoProfesionalmente.text.trim(),
                    );
                widget.pageController.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
                // }
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _SignUserSignature extends StatelessWidget {
  const _SignUserSignature();

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
                BlocConsumer<MicrediEstudioCubit, MicrediEstudioState>(
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
                            context.read<MicrediEstudioCubit>().sendAnswers();
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

class _EntornoSocialEstudioWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const _EntornoSocialEstudioWidget({
    required this.controller,
    required this.isRecurrentForm,
  });

  @override
  State<_EntornoSocialEstudioWidget> createState() =>
      _EntornoSocialEstudioWidgetState();
}

class _EntornoSocialEstudioWidgetState
    extends State<_EntornoSocialEstudioWidget>
    with AutomaticKeepAliveClientMixin {
  String? itemSelected;
  String? tieneTrabajo;
  String? otrosIngresos;
  String? objOrigenCatalogoValorId;
  String? tipoEstudioHijos;
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  final question6Controller = TextEditingController();
  final question7Controller = TextEditingController();
  final questio8Controller = TextEditingController();
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.controller,
        ),
      false => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 5,
                    currentStep: 2,
                  ),
                  const Gap(20),
                  Text(
                    'forms.entorno_familiar.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  CommentaryWidget(
                    title: 'Profesión u Oficio:',
                    textEditingController: question1Controller,
                  ),
                  const Gap(10),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();

                        return null;
                      },
                      title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        tieneTrabajo = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (tieneTrabajo == 'input.yes'.tr())
                    CommentaryWidget(
                      title: 'Cual?',
                      textEditingController: trabajoNegocioDescripcion,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Tiempo de la actividad (meses o años)'.tr(),
                    textEditingController: tiempoActividad,
                  ),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();

                        return null;
                      },
                      title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        setState(() {
                          otrosIngresos = item;
                        });
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  const Gap(20),
                  if (otrosIngresos == 'Si')
                    CommentaryWidget(
                      title: 'forms.entorno_familiar.question6'.tr(),
                      textEditingController: otrosIngresosDescripcion,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  BlocBuilder<DepartamentosCubit, DepartamentosState>(
                    builder: (context, state) {
                      return WhiteCard(
                        marginTop: 15,
                        padding: const EdgeInsets.all(10),
                        child: JLuxDropdown(
                          isContainIcon: true,
                          isLoading: state.status == Status.inProgress,
                          title: 'forms.entorno_familiar.person_origin'.tr(),
                          items: state.departamentos,
                          onChanged: (item) {
                            if (item == null) return;
                            objOrigenCatalogoValorId = item.valor;
                            setState(() {});
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'input.input_validator'.tr();
                            }
                            return null;
                          },
                          toStringItem: (item) => item.nombre,
                          hintText: 'input.select_department'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de personas a cargo:*'.tr(),
                    textEditingController: personasCargo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de hijos:*'.tr(),
                    textEditingController: numeroHijos,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'forms.entorno_familiar.childs_age'.tr(),
                    textEditingController: edadHijos,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();
                        return null;
                      },
                      title: '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                      items: const [
                        'Ninguno',
                        'Preescolar',
                        'Primaria',
                        'Secundaria',
                        'Técnico',
                        'Universitario'
                      ],
                      onChanged: (item) {
                        if (item == null) return;
                        tipoEstudioHijos = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  const Gap(20),
                  ButtonActionsWidget(
                    onPreviousPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(
                          milliseconds: 350,
                        ),
                        curve: Curves.easeIn,
                      );
                    },
                    onNextPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<MicrediEstudioCubit>().saveAnswers(
                              tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                              trabajoNegocioDescripcion:
                                  trabajoNegocioDescripcion.text.trim(),
                              tiempoActividad: int.tryParse(
                                tiempoActividad.text.trim(),
                              ),
                              otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                              otrosIngresosDescripcion:
                                  otrosIngresosDescripcion.text.trim(),
                              objOrigenCatalogoValorId:
                                  objOrigenCatalogoValorId,
                              personasCargo: personasCargo.text.trim(),
                              numeroHijos:
                                  int.tryParse(numeroHijos.text.trim()),
                              edadHijos: edadHijos.text.trim(),
                              tipoEstudioHijos: tipoEstudioHijos,
                            );
                        widget.controller.nextPage(
                          duration: const Duration(
                            milliseconds: 350,
                          ),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    previousTitle: 'button.previous'.tr(),
                    nextTitle: 'button.next'.tr(),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrentForm extends StatefulWidget {
  final PageController pageController;
  const _RecurrentForm({required this.pageController});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  String? tipoEstudioHijos;
  String? tieneTrabajo;
  String? otrosIngresos;
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 3,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'Descripción del entorno familiar'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            WhiteCard(
              padding: const EdgeInsets.all(5),
              child: JLuxDropdown(
                isContainIcon: true,
                validator: (value) {
                  if (value == null) return 'input.input_validator'.tr();

                  return null;
                },
                title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  tieneTrabajo = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (tieneTrabajo == 'input.yes'.tr())
              CommentaryWidget(
                title: 'Cual?',
                textEditingController: trabajoNegocioDescripcion,
              ),
            const Gap(20),
            CommentaryWidget(
              title: 'Tiempo de la actividad (meses o años)',
              textEditingController: tiempoActividad,
            ),
            const Gap(20),
            WhiteCard(
              padding: const EdgeInsets.all(5),
              child: JLuxDropdown(
                isContainIcon: true,
                validator: (value) {
                  if (value == null) return 'input.input_validator'.tr();

                  return null;
                },
                title: '¿Tiene otros ingresos?'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  otrosIngresos = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (otrosIngresos == 'input.yes'.tr())
              CommentaryWidget(
                title: '¿Cuáles?',
                textEditingController: otrosIngresosDescripcion,
              ),
            CommentaryWidget(
              title: 'Número de personas a cargo:*',
              textEditingController: personasCargo,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'Número de hijos:*',
              textEditingController: numeroHijos,
            ),
            const Gap(20),
            CommentaryWidget(
              title: '¿Que edades tienen sus hijos? ',
              textEditingController: edadHijos,
            ),
            const Gap(20),
            WhiteCard(
              padding: const EdgeInsets.all(5),
              child: JLuxDropdown(
                isContainIcon: true,
                validator: (value) {
                  if (value == null) return 'input.input_validator'.tr();
                  return null;
                },
                title: '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                items: const [
                  'Ninguno',
                  'Preescolar',
                  'Primaria',
                  'Secundaria',
                  'Técnico',
                  'Universitario'
                ],
                onChanged: (item) {
                  if (item == null) return;
                  tipoEstudioHijos = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            ButtonActionsWidget(
              onPreviousPressed: () {
                widget.pageController.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                      tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                      trabajoNegocioDescripcion:
                          trabajoNegocioDescripcion.text.trim(),
                      tiempoActividad:
                          int.tryParse(tiempoActividad.text.trim()),
                      otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                      otrosIngresosDescripcion:
                          otrosIngresosDescripcion.text.trim(),
                      personasCargo: personasCargo.text.trim(),
                      numeroHijos: int.tryParse(numeroHijos.text.trim()),
                      edadHijos: edadHijos.text.trim(),
                      tipoEstudioHijos: tipoEstudioHijos,
                    );
                widget.pageController.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ImpactoSocialCrediEstudioWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const _ImpactoSocialCrediEstudioWidget(
      {required this.controller, required this.isRecurrentForm});

  @override
  State<_ImpactoSocialCrediEstudioWidget> createState() =>
      _ImpactoSocialCrediEstudioWidgetState();
}

class _ImpactoSocialCrediEstudioWidgetState
    extends State<_ImpactoSocialCrediEstudioWidget>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  final question6Controller = TextEditingController();
  final cualEstudio = TextEditingController();
  String? optarOtroEstudio;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentFormImpactoSocial(
          pageController: widget.controller,
        ),
      false => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 3,
                    currentStep: 2,
                  ),
                  const Gap(20),
                  Text(
                    'forms.mejora_de_vivienda.impacto_social.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'forms.miCredi_estudio.question1'.tr(),
                    textEditingController: question1Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                            .tr(),
                    textEditingController: question2Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  WhiteCard(
                    marginTop: 15,
                    padding: const EdgeInsets.all(10),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      title: '¿Piensa optar a otro estudio superior?*'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        optarOtroEstudio = item;
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                      toStringItem: (item) => item,
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (optarOtroEstudio == 'input.yes'.tr())
                    CommentaryWidget(
                      title: 'Porque?',
                      textEditingController: cualEstudio,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿Cuáles son sus planes en los próximos 10 años?*'.tr(),
                    textEditingController: question4Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Qué aspira laboralmente?*'.tr(),
                    textEditingController: question5Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Otros datos relevantes e interesantes del cliente'
                        .tr(),
                    textEditingController: question6Controller,
                  ),
                  const Gap(10),
                  ButtonActionsWidget(
                    onPreviousPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(
                          milliseconds: 350,
                        ),
                        curve: Curves.easeIn,
                      );
                    },
                    onNextPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<MicrediEstudioCubit>().saveAnswers(
                              motivoPrestamo: question1Controller.text.trim(),
                              comoAyudaCrecer: question2Controller.text.trim(),
                              optarOtroEstudio:
                                  optarOtroEstudio == 'input.yes'.tr(),
                              cualEstudio: cualEstudio.text.trim(),
                              planFuturo: question4Controller.text.trim(),
                              aspiraLaboralmente:
                                  question5Controller.text.trim(),
                              otrosDatosCliente:
                                  question6Controller.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              question: 'forms.miCredi_estudio.question1'.tr(),
                              response: question1Controller.text.trim(),
                            ),
                            Response(
                              question: 'forms.miCredi_estudio.question2'.tr(),
                              response: question2Controller.text.trim(),
                            ),
                            Response(
                              question: 'forms.miCredi_estudio.question3'.tr(),
                              response: question3Controller.text.trim(),
                            ),
                            Response(
                              question: 'forms.miCredi_estudio.question4'.tr(),
                              response: question4Controller.text.trim(),
                            ),
                            Response(
                              question: 'forms.miCredi_estudio.question5'.tr(),
                              response: question5Controller.text.trim(),
                            ),
                            Response(
                              question: 'forms.miCredi_estudio.question6'.tr(),
                              response: question6Controller.text.trim(),
                            ),
                          ],
                        );
                        widget.controller.nextPage(
                          duration: const Duration(
                            milliseconds: 350,
                          ),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    previousTitle: 'button.previous'.tr(),
                    nextTitle: 'button.next'.tr(),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrentFormImpactoSocial extends StatefulWidget {
  final PageController pageController;
  const _RecurrentFormImpactoSocial({
    required this.pageController,
  });

  @override
  State<_RecurrentFormImpactoSocial> createState() =>
      _RecurrentFormImpactoSocialState();
}

class _RecurrentFormImpactoSocialState
    extends State<_RecurrentFormImpactoSocial> {
  final motivoPrestamo = TextEditingController();
  final comoAyudaCrecer = TextEditingController();
  String? alcanzaraMeta;
  final explicacionAlcanzaraMeta = TextEditingController();
  final siguentePaso = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 3,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                  .tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: motivoPrestamo,
              title:
                  '¿En qué piensa invertir este nuevo préstamo de MiCrediestudio?* Explique',
            ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: comoAyudaCrecer,
              title:
                  '¿Cómo cree usted que este nuevo préstamo le ayude en su crecimiento profesional?*',
            ),
            const Gap(20),
            WhiteCard(
              padding: const EdgeInsets.all(5),
              child: JLuxDropdown(
                isContainIcon: true,
                validator: (value) {
                  if (value == null) return 'input.input_validator'.tr();

                  return null;
                },
                title:
                    '¿Cree usted que una vez finalizado el pago de este préstamo de MiCréditoEstudio alcanzó su meta académica? ¿Por qué?',
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  alcanzaraMeta = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            if (alcanzaraMeta == 'input.yes'.tr())
              CommentaryWidget(
                textEditingController: explicacionAlcanzaraMeta,
                title: 'Explica la meta?',
              ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: siguentePaso,
              title: '¿Cuál sería su siguiente paso?',
            ),
            ButtonActionsWidget(
              onPreviousPressed: () {
                widget.pageController.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                      motivoPrestamo: motivoPrestamo.text.trim(),
                      comoAyudaCrecer: comoAyudaCrecer.text.trim(),
                      alcanzaraMeta: alcanzaraMeta == 'input.yes'.tr(),
                      explicacionAlcanzaraMeta:
                          explicacionAlcanzaraMeta.text.trim(),
                      siguientePaso: siguentePaso.text.trim(),
                    );
                widget.pageController.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
