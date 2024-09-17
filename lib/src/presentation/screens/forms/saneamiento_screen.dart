import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';

class SaneamientoScreen extends StatefulWidget {
  const SaneamientoScreen({super.key});

  @override
  State<SaneamientoScreen> createState() => _SaneamientoScreenState();
}

class _SaneamientoScreenState extends State<SaneamientoScreen> {
  final PageController _pageController = PageController();

  late DateTime _selectedDate;
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(
            DepartamentosRepositoryImpl(),
          )..getDepartamentos(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('forms.saneamiento.appbar'.tr()),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            SaneamientoContent(
              controller: _pageController,
            ),
            EntornoSocialWidget(
              controller: _pageController,
            ),
            DescripcionYDesarrolloWidget(
              controller: _pageController,
            ),
            ImpactoSocialKivaWidget(
              controller: _pageController,
            ),
            FormResponses(
              controller: _pageController,
            ),
            const SignQuestionaryWidget(),
          ],
        ),
      ),
    );
  }
}

class SaneamientoContent extends StatefulWidget {
  final PageController controller;
  const SaneamientoContent({super.key, required this.controller});

  @override
  State<SaneamientoContent> createState() => _SaneamientoContentState();
}

class _SaneamientoContentState extends State<SaneamientoContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 1,
            ),
            const Gap(20),
            Text(
              'forms.saneamiento.title'.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(25),
            UploadImageWidget(
              title: '1- ${'forms.saneamiento.client_photo'.tr()}',
            ),
            const Gap(20),
            UploadImageWidget(
              title: '2-  ${'forms.saneamiento.client_photo'.tr()}',
            ),
            const Gap(15),
            UploadImageWidget(
              title: '3-  ${'forms.saneamiento.client_photo'.tr()}',
            ),
            const Gap(20),
            ButtonActionsWidget(
              onPreviousPressed: () {
                context.pop();
              },
              onNextPressed: () {
                widget.controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.exit'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ButtonActionsWidget extends StatelessWidget {
  final void Function()? onPreviousPressed;
  final void Function()? onNextPressed;
  final String previousTitle;
  final String nextTitle;
  const ButtonActionsWidget({
    super.key,
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.previousTitle,
    required this.nextTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              alignment: MainAxisAlignment.center,
              text: previousTitle,
              color: Colors.red,
              onPressed: () => onPreviousPressed!(),
            ),
          ),
          const Gap(20),
          Expanded(
            child: CustomElevatedButton(
              alignment: MainAxisAlignment.center,
              text: nextTitle,
              color: AppColors.getPrimaryColor(),
              onPressed: () => onNextPressed!(),
            ),
          )
        ],
      ),
    );
  }
}

class EntornoSocialWidget extends StatefulWidget {
  final PageController controller;
  const EntornoSocialWidget({super.key, required this.controller});

  @override
  State<EntornoSocialWidget> createState() => _EntornoSocialWidgetState();
}

class _EntornoSocialWidgetState extends State<EntornoSocialWidget>
    with AutomaticKeepAliveClientMixin {
  String? personOrigin;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final question2Controller = TextEditingController();
    final question3Controller = TextEditingController();
    return SingleChildScrollView(
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
            const Gap(10),
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
                      personOrigin = item.nombre;
                    },
                    toStringItem: (item) => item.nombre,
                    hintText: 'Selecciona un Departamento',
                  ),
                );
              },
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.childs_age'.tr(),
              textEditingController: question2Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.childs_education'.tr(),
              textEditingController: question3Controller,
            ),
            const Gap(15),
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
                context.read<ResponseCubit>().addResponses(
                  responses: [
                    Response(
                      question: 'forms.entorno_familiar.person_origin'.tr(),
                      response: personOrigin!,
                    ),
                    Response(
                      question: 'forms.entorno_familiar.childs_age'.tr(),
                      response: question2Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.entorno_familiar.childs_education'.tr(),
                      response: question3Controller.text.trim(),
                    ),
                  ],
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

class DescripcionYDesarrolloWidget extends StatelessWidget {
  final PageController controller;
  const DescripcionYDesarrolloWidget({super.key, required this.controller});
// TODO: AGREGAR FUNCIONALIODAD DE FORMULARIO
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 3,
            ),
            const Gap(20),
            Text(
              'forms.develpment_and_description.title'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.develpment_and_description.aboutCredit'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.develpment_and_description.who_support'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.develpment_and_description.about_future'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title:
                  'forms.develpment_and_description.have_othe_invertion'.tr(),
            ),
            ButtonActionsWidget(
              onPreviousPressed: () {
                controller.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                controller.nextPage(
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

class ImpactoSocialKivaWidget extends StatelessWidget {
  final PageController controller;
  const ImpactoSocialKivaWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 4,
            ),
            const Gap(20),
            Text(
              'forms.impacto_social_kiva.title'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.impacto_social_kiva.what_plan'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.impacto_social_kiva.how_perform'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.impacto_social_kiva.what_plan_in_10_years'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.impacto_social_kiva.another_user_data'.tr(),
            ),
            ButtonActionsWidget(
              onPreviousPressed: () {
                controller.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.signed'.tr(),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

class SignQuestionaryWidget extends StatelessWidget {
  const SignQuestionaryWidget({super.key});

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
                CustomElevatedButton(
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.white,
                  ),
                  positionIcon: PositionIcon.left,
                  text: 'button.send'.tr(),
                  color: context.primaryColor(),
                  onPressed: () {},
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
