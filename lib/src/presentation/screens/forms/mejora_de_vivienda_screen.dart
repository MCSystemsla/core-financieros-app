import 'dart:developer';

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/domain/repository/comunidad/comunidad_repository.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/comunidades/comunidades_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/impacto_social_kiva_objetivo.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/mejora_vivienda_credito_descrip.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/mejora_vivienda_entorno_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MejoraDeViviendaScreen extends StatefulWidget {
  const MejoraDeViviendaScreen({super.key});

  @override
  State<MejoraDeViviendaScreen> createState() => _MejoraDeViviendaScreenState();
}

class _MejoraDeViviendaScreenState extends State<MejoraDeViviendaScreen> {
  bool? isRecurrentForm;
  @override
  void initState() {
    super.initState();
    isRecurrentForm = false;
    log(isRecurrentForm.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => MejoraViviendaCubit(ResponsesRepositoryImpl()),
        ),
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
            create: (ctx) =>
                RecurrenteMejoraViviendaCubit(ResponsesRepositoryImpl())),
        BlocProvider(
          create: (ctx) =>
              ComunidadesCubit(ComunidadRepositoryImpl())..getComunidades(),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('forms.mejora_de_vivienda.title'.tr()),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              // EntornoSocialWidget(
              //   controller: pageController,
              //   isRecurrentForm: isRecurrentForm,
              // ),
              MejoraViviendaEntornoSocial(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm ?? false,
              ),
              if (isRecurrentForm ?? false)
                MejoraViviendaCreditoDescrip(
                  pageController: pageController,
                ),
              ImpactoSocialKivaObjetiveWidget(
                isRecurrentForm: isRecurrentForm ?? false,
                controller: pageController,
              ),
              // MetasYAspiracionesWidget(
              //   controller: pageController,
              // ),
              FormResponses(
                controller: pageController,
              ),
              const SignQuestionaryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormResponses extends StatefulWidget {
  final PageController controller;
  const FormResponses({
    super.key,
    required this.controller,
  });

  @override
  State<FormResponses> createState() => _FormResponsesState();
}

class _FormResponsesState extends State<FormResponses> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'input.form_response'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(15),
            BlocBuilder<ResponseCubit, ResponseState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.responses.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Gap(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _ResponseWidget(response: state.responses[index]);
                  },
                );
              },
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
                widget.controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.signed'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponseWidget extends StatefulWidget {
  final Response response;
  const _ResponseWidget({required this.response});

  @override
  State<_ResponseWidget> createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<_ResponseWidget> {
  bool onEditAnswer = false;
  final answerController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? responseEditedAnswer;

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 250,
                  ),
                  child: Text(
                    widget.response.question,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    onEditAnswer = !onEditAnswer;
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const Gap(20),
            Text(
              widget.response.response,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            if (onEditAnswer)
              CommentaryWidget(
                marginTop: 2,
                initialValue: widget.response.response,
                title: '',
                // textEditingController: answerController,
                onChange: (value) {
                  responseEditedAnswer = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
            if (onEditAnswer)
              CustomElevatedButton(
                text: 'Guardar',
                color: AppColors.getPrimaryColor(),
                onPressed: () {
                  context.read<ResponseCubit>().addResponses(
                    responses: [
                      Response(
                        question: widget.response.question,
                        response: responseEditedAnswer!,
                      ),
                    ],
                  );
                  onEditAnswer = !onEditAnswer;
                  setState(() {});
                },
              ),
          ],
        ),
      ),
    );
  }
}
