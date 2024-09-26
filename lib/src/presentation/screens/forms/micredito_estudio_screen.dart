import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/descripcion_academica.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MiCreditoEstudioScreen extends StatelessWidget {
  const MiCreditoEstudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const isRecurrentForm = false;
    final PageController pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
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
            title: Text('MiCredi Estudio'.tr()),
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
              _ImpactoSocialCrediEstudioWidget(
                controller: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(controller: pageController),
              const SignQuestionaryWidget(),
            ],
          ),
        ),
      ),
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
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  final question6Controller = TextEditingController();
  final question7Controller = TextEditingController();
  final questio8Controller = TextEditingController();
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
                const CommentaryWidget(
                  title: 'Profesión u Oficio:',
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
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                const Gap(20),
                CommentaryWidget(
                  title: 'Tiempo de la actividad (meses o años)'.tr(),
                  textEditingController: question1Controller,
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
                        itemSelected = item;
                      });
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                const Gap(20),
                if (itemSelected == 'Si')
                  CommentaryWidget(
                    title: 'forms.entorno_familiar.question6'.tr(),
                    textEditingController: questio8Controller,
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
                  textEditingController: question2Controller,
                ),
                const Gap(20),
                CommentaryWidget(
                  title: 'Número de hijos:*'.tr(),
                  textEditingController: question2Controller,
                ),
                const Gap(20),
                CommentaryWidget(
                  title: 'forms.entorno_familiar.childs_age'.tr(),
                  textEditingController: question2Controller,
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
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question: 'forms.entorno_familiar.person_origin'.tr(),
                          response: question1Controller.text.trim(),
                        ),
                        Response(
                          question: 'forms.entorno_familiar.childs_age'.tr(),
                          response: question2Controller.text.trim(),
                        ),
                        Response(
                          question:
                              'forms.entorno_familiar.childs_education'.tr(),
                          response: question3Controller.text.trim(),
                        ),
                        Response(
                          question: 'forms.entorno_familiar.question1'.tr(),
                          response: question4Controller.text.trim(),
                        ),
                        Response(
                          question: 'forms.entorno_familiar.question2'.tr(),
                          response: question5Controller.text.trim(),
                        ),
                        Response(
                          question: 'forms.entorno_familiar.question3'.tr(),
                          response: question6Controller.text.trim(),
                        ),
                        Response(
                          question: 'forms.entorno_familiar.question4'.tr(),
                          response: question7Controller.text.trim(),
                        ),
                        Response(
                          question: 'forms.entorno_familiar.question6'.tr(),
                          response: questio8Controller.text.trim(),
                        ),
                      ],
                    );
                    widget.controller.nextPage(
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
            const CommentaryWidget(
              title: 'Profesión u Oficio:',
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
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            const CommentaryWidget(title: 'Número de personas a cargo:*'),
            const Gap(20),
            const CommentaryWidget(title: 'Número de hijos:*'),
            const Gap(20),
            const CommentaryWidget(title: '¿Que edades tienen sus hijos? '),
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
                ),
                const Gap(10),
                CommentaryWidget(
                  title:
                      '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                          .tr(),
                  textEditingController: question2Controller,
                ),
                const Gap(10),
                CommentaryWidget(
                  title: '¿Piensa optar a otro estudio superior? ¿Cuál?*'.tr(),
                  textEditingController: question3Controller,
                ),
                const Gap(10),
                CommentaryWidget(
                  title:
                      '¿Cuáles son sus planes en los próximos 10 años?*'.tr(),
                  textEditingController: question4Controller,
                ),
                const Gap(10),
                CommentaryWidget(
                  title: '¿Qué aspira laboralmente?*'.tr(),
                  textEditingController: question5Controller,
                ),
                const Gap(10),
                CommentaryWidget(
                  title:
                      'Otros datos relevantes e interesantes del cliente'.tr(),
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
                  },
                  previousTitle: 'button.previous'.tr(),
                  nextTitle: 'button.next'.tr(),
                ),
                const Gap(10),
              ],
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
            const CommentaryWidget(
              title:
                  '¿En qué piensa invertir este nuevo préstamo de MiCrediestudio?* Explique',
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  '¿Cómo cree usted que este nuevo préstamo le ayude en su crecimiento profesional?*',
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  '¿Cree usted que una vez finalizado el pago de este préstamo de MiCréditoEstudio alcanzó su meta académica? ¿Por qué?',
            ),
            const Gap(20),
            const CommentaryWidget(title: '¿Cuál sería su siguiente paso?'),
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
