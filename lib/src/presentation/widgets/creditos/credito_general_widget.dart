import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/dates_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CreditoGeneralesWidget extends StatefulWidget {
  final PageController pageController;
  const CreditoGeneralesWidget({
    super.key,
    required this.pageController,
  });

  @override
  State<CreditoGeneralesWidget> createState() => _CreditoGeneralesWidgetState();
}

class _CreditoGeneralesWidgetState extends State<CreditoGeneralesWidget> {
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
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 6,
              currentStep: 1,
            ),
            const Gap(20),
            Text(
              'Generales'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Numero'.tr(),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Tipo de Documento'.tr(),
                items: const ['DNI', 'Pasaporte'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Selecciona el tipo'.tr(),
              ),
            ),
            const Gap(15),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Tipo de Persona'.tr(),
                items: const ['sss', 'ssswww'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Selecciona el tipo'.tr(),
              ),
            ),
            const Gap(15),
            CommentaryWidget(
              title: 'Cedula de Identidad'.tr(),
            ),
            const Gap(15),
            CommentaryWidget(
              title: 'Primer Nombre'.tr(),
            ),
            const Gap(15),
            CommentaryWidget(
              title: 'Segundo Nombre'.tr(),
            ),
            const Gap(15),
            CommentaryWidget(
              title: 'Primer Apellido'.tr(),
            ),
            const Gap(15),
            CommentaryWidget(
              title: 'Segundo Apellido'.tr(),
            ),
            const Gap(15),
            CommentaryWidget(
              title: 'Nombre publico'.tr(),
            ),
            const Gap(15),
            DatesWidget(
              title: 'Fecha de nacimiento',
              onSelectedDate: () => selectDate(context),
              selectedDate: _selectedDate,
            ),
            const Gap(15),
            CommentaryWidget(
              title: 'Pais de Nacimiento'.tr(),
            ),
            const Gap(15),
            DatesWidget(
              title: 'Fecha de emision cedula',
              onSelectedDate: () => selectDate(context),
              selectedDate: _selectedDate,
            ),
            const Gap(15),
            DatesWidget(
              title: 'Fecha vence cedula',
              onSelectedDate: () => selectDate(context),
              selectedDate: _selectedDate,
            ),
            const Gap(15),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Pais Emisor cedula'.tr(),
                items: const ['Honduras', 'Nicaragua'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Ingresar Pais'.tr(),
              ),
            ),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Sexo'.tr(),
                items: const ['Masculino', 'Femenino'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Ingresar Genero'.tr(),
              ),
            ),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Estado Civil'.tr(),
                items: const ['Soltero', 'Casado'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'Ingresar el Estado Civil'.tr(),
              ),
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
