import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saneamiento'),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          _SaneamientoContent(
            controller: _pageController,
          ),
          _EntornoSocialWidget(
            controller: _pageController,
          ),
          DescripcionYDesarrolloWidget(
            controller: _pageController,
          ),
          ImpactoSocialKivaWidget(
            controller: _pageController,
          ),
          const SignQuestionaryWidget(),
        ],
      ),
    );
  }
}

class _SaneamientoContent extends StatefulWidget {
  final PageController controller;
  const _SaneamientoContent({required this.controller});

  @override
  State<_SaneamientoContent> createState() => _SaneamientoContentState();
}

class _SaneamientoContentState extends State<_SaneamientoContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
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
              'El fondo KIVA es quien apoya a MiCrédito y a sus clientes a obtener financiamientos con tasas de interés que se adaptan a sus capacidades. El propósito de esta entrevista es para que usted pueda compartir el impacto del préstamo de KIVA a través de MiCrédito.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(25),
            const UploadImageWidget(
              title: '1- Foto Cliente',
            ),
            const Gap(20),
            const UploadImageWidget(
              title: '2- Foto Cliente',
            ),
            const Gap(15),
            const UploadImageWidget(
              title: '3- Foto Cliente',
            ),
            const Gap(20),
            _ButtonActionsWidget(
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
              previousTitle: 'Anterior',
              nextTitle: 'Siguiente',
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ButtonActionsWidget extends StatelessWidget {
  final void Function()? onPreviousPressed;
  final void Function()? onNextPressed;
  final String previousTitle;
  final String nextTitle;
  const _ButtonActionsWidget({
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

class _EntornoSocialWidget extends StatefulWidget {
  final PageController controller;
  const _EntornoSocialWidget({required this.controller});

  @override
  State<_EntornoSocialWidget> createState() => _EntornoSocialWidgetState();
}

class _EntornoSocialWidgetState extends State<_EntornoSocialWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
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
              'Entorno Familiar',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            const CommentaryWidget(title: '¿De dónde es originario?'),
            const Gap(10),
            const CommentaryWidget(title: '¿Qué edades tienen sus hijos?'),
            const Gap(10),
            const CommentaryWidget(
              title: '¿Qué tipo de estudios reciben sus hijos?¿Porqué?',
            ),
            const Gap(15),
            _ButtonActionsWidget(
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
              previousTitle: 'Anterior',
              nextTitle: 'Siguiente',
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
              'Descripción y desarrollo del financiamiento',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            const CommentaryWidget(
              title:
                  '¿Cuéntenos que le impulsó a optar por este tipo de crédito?',
            ),
            const Gap(10),
            const CommentaryWidget(
              title:
                  '¿Quién o quiénes lo apoyarán a cumplir lo que se ha propuesto con este financiamiento?',
            ),
            const Gap(10),
            const CommentaryWidget(
              title:
                  '¿Cree usted que con este crédito va poder cumplir este proyecto?',
            ),
            const Gap(10),
            const CommentaryWidget(
              title: '¿Tiene otros ingresos? ¿Cuáles?',
            ),
            _ButtonActionsWidget(
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
              previousTitle: 'Anterior',
              nextTitle: 'Siguiente',
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
              'Impacto social de Kiva',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            const CommentaryWidget(
              title: '¿En qué planea utilizar este préstamo?',
            ),
            const Gap(10),
            const CommentaryWidget(
              title:
                  '¿Cómo cree usted que este crédito va a mejorar su calidad de vida?',
            ),
            const Gap(10),
            const CommentaryWidget(
              title: '¿Cuáles son sus planes para los próximos 10 años?',
            ),
            const Gap(10),
            const CommentaryWidget(
              title: 'Otros datos relevantes e interesantes del cliente:',
            ),
            _ButtonActionsWidget(
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
              previousTitle: 'Anterior',
              nextTitle: 'Firmar',
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
                  'Firma del oficial'.tr(),
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'Certifico que leí completamente este formulario de consentimiento y liberación a la persona cuyo nombre aparece arriba, y que ella dio su consentimiento verbal a la exención.'
                      .tr(),
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
                  text: 'Enviar'.tr(),
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
