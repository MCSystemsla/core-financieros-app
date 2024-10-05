import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comunidades/comunidades_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MejoraViviendaEntornoSocial extends StatefulWidget {
  final PageController pageController;
  const MejoraViviendaEntornoSocial({
    super.key,
    required this.pageController,
  });

  @override
  State<MejoraViviendaEntornoSocial> createState() =>
      _MejoraViviendaEntornoSocialState();
}

String? question1;
final question2 = TextEditingController();
String? question3;
String? question4;
String? question5;
final question6 = TextEditingController();
final question7 = TextEditingController();
final question8 = TextEditingController();
String? question9;

class _MejoraViviendaEntornoSocialState
    extends State<MejoraViviendaEntornoSocial>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 3,
            ),
            const Gap(20),
            Text(
              'Entorno Social'.tr(),
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
                  question1 = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: question2,
              title: 'Tiempo de la actividad:*',
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
                title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  question3 = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
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
                      question4 = item.valor;
                    },
                    toStringItem: (item) => item.nombre,
                    hintText: 'input.select_department'.tr(),
                  ),
                );
              },
            ),
            const Gap(20),
            BlocBuilder<ComunidadesCubit, ComunidadesState>(
              builder: (context, state) {
                return WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: JLuxDropdown(
                    isContainIcon: true,
                    isLoading: state.status == Status.inProgress,
                    validator: (value) {
                      if (value == null) return 'input.input_validator'.tr();

                      return null;
                    },
                    title: 'Su comunidad es:'.tr(),
                    items: state.comunidades,
                    onChanged: (item) {
                      if (item == null) return;
                      question5 = item.nombre;
                      setState(() {});
                    },
                    toStringItem: (item) {
                      return item.nombre;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                );
              },
            ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: question6,
              title: 'Número de personas a cargo:*',
            ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: question7,
              title: 'Número de hijos:*',
            ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: question8,
              title: '¿Que edades tienen sus hijos? ',
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
                  question9 = item;
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
                context.read<MejoraViviendaCubit>().saveAnswer1(
                      tieneTrabajo: question1 == 'input.yes'.tr(),
                      tiempoActividad: int.parse(question2.text.trim()),
                      otrosIngresos: question3 == 'input.yes'.tr(),
                      objOrigenCatalogoValorId: question4!,
                      objTipoComunidadId: question5!,
                      personasCargo: question6.text.trim(),
                      numeroHijos: int.parse(question7.text.trim()),
                      edadHijos: question8.text.trim(),
                      tipoEstudioHijos: question9!,
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
