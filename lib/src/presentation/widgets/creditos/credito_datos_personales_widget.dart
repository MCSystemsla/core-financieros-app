import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreditoDatosPersonalesWidget extends StatefulWidget {
  final PageController controller;
  const CreditoDatosPersonalesWidget({
    super.key,
    required this.controller,
  });

  @override
  State<CreditoDatosPersonalesWidget> createState() =>
      _CreditoDatosPersonalesWidgetState();
}

class _CreditoDatosPersonalesWidgetState
    extends State<CreditoDatosPersonalesWidget> {
  String? desempanoCargoPublic;
  String? desempanoCargoPublic2;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 6,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'Datos Personales'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Direccion'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Barrio'.tr(),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Departamento'.tr(),
                items: const ['sss', 'ssswww'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Selecciona el Departamento'.tr(),
              ),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Municipio'.tr(),
                items: const ['sss', 'ssswww'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Agregar Municipio'.tr(),
              ),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Pais'.tr(),
                items: const ['sss', 'ssswww'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Agregar Pais'.tr(),
              ),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Nacionalidad'.tr(),
                items: const ['sss', 'ssswww'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Agregar Nacionalidad'.tr(),
              ),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Condicion Vivienda'.tr(),
                items: const ['sss', 'ssswww'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Agregar Condicion'.tr(),
              ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Anos a vivir en vivienda'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Telefono Celular'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Telefono Celular'.tr(),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Escolaridad'.tr(),
                items: const ['Secundaria', 'Universitario'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Agregar Escolaridad'.tr(),
              ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Profesion'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Ocupacion'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Email'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Numero de dependientes'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Numero de Hijos'.tr(),
            ),
            const Gap(20),
            Text(
              'Informacion Adcional'.tr(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                  ),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title:
                    'Has Desempeñado un cargo publico y/o figura publica de alto nivel en los ultimos 10 años'
                        .tr(),
                items: const ['Si', 'No'],
                onChanged: (item) {
                  if (item == null) return;
                  desempanoCargoPublic = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'Agregar una Opcion'.tr(),
              ),
            ),
            if (desempanoCargoPublic == 'Si')
              const DesempenadoCargoPublicoWidget(),
            const Gap(20),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title:
                    'Eres Familia de una persona que a desempeñado un cargo publico o figura publica de alto nivel?'
                        .tr(),
                items: const ['Si', 'No'],
                onChanged: (item) {
                  if (item == null) return;
                  desempanoCargoPublic2 = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'Agregar una Opcion'.tr(),
              ),
            ),
            if (desempanoCargoPublic2 == 'Si')
              const DesempenadoCargoPublico2Widget(),
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
    );
  }
}

class DesempenadoCargoPublicoWidget extends StatelessWidget {
  const DesempenadoCargoPublicoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),
        CommentaryWidget(
          title: 'Nombre de la Entidad'.tr(),
        ),
        const Gap(10),
        CommentaryWidget(
          title: 'Periodo'.tr(),
        ),
        CommentaryWidget(
          title: 'Pais'.tr(),
        ),
        CommentaryWidget(
          title: 'Cargo Oficial'.tr(),
        ),
      ],
    );
  }
}

class DesempenadoCargoPublico2Widget extends StatelessWidget {
  const DesempenadoCargoPublico2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),
        CommentaryWidget(
          title: 'Nombre del Familiar'.tr(),
        ),
        const Gap(10),
        CommentaryWidget(
          title: 'Cargo de Familiar'.tr(),
        ),
        const Gap(10),
        CommentaryWidget(
          title: 'Periodo'.tr(),
        ),
        const Gap(10),
        CommentaryWidget(
          title: 'Periodo'.tr(),
        ),
        const Gap(10),
        WhiteCard(
          marginTop: 15,
          padding: const EdgeInsets.all(10),
          child: JLuxDropdown(
            isContainIcon: true,
            title: 'Parentesco'.tr(),
            items: const ['Hijo', 'Padre', 'Abuelo'],
            onChanged: (item) {
              if (item == null) return;
            },
            toStringItem: (item) => item,
            hintText: 'Agregar una Opcion'.tr(),
          ),
        ),
        const Gap(10),
        CommentaryWidget(
          title: 'Nombre de la entidad'.tr(),
        ),
        const Gap(10),
        CommentaryWidget(
          title: 'Pais'.tr(),
        ),
      ],
    );
  }
}
