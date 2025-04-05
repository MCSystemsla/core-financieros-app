import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReprestamoForm4 extends StatefulWidget {
  final PageController controller;
  const ReprestamoForm4({super.key, required this.controller});

  @override
  State<ReprestamoForm4> createState() => _ReprestamoForm4State();
}

class _ReprestamoForm4State extends State<ReprestamoForm4>
    with AutomaticKeepAliveClientMixin {
  List<Item> actividadesPredominantesList = [];
  List<Item> rubrosActividadesPredominanteList = [];
  String? profesion;
  Item? actividad;
  Item? actividad1;
  String? ocupacion;
  String? nombreNegocio;
  Item? condicionNegocio;
  String? funcionamientoNegocio;
  Item? actividadPredominante;
  Item? rubroActividad;
  Item? rubroActividad2;
  Item? rubroActividad3;
  Item? actividadEconomica2;
  Item? sectorEconomico;
  String? sectorEconomico2;
  // String? horarioTrabajo;
  // String? horarioVisita;
  Item? municipioNegocio;
  String? barrioNegocio;
  String? direccionNegocio;
  final formKey = GlobalKey<FormState>();
  TimeOfDay? horarioTrabajo;
  TimeOfDay? horarioTrabajoEndtime;
  TimeOfDay? horarioVisita;
  TimeOfDay? horarioVisitaEndtime;
  Item? objRubroActividadPredominante;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'ACTIVIDADECONOMICA',
              title: 'Actividad',
              onChanged: (item) {
                if (item == null) return;
                // if (actividadesPredominantesList
                //     .any((element) => element.value == item.value)) {
                //   return;
                // }
                actividad = item;
                actividadesPredominantesList.add(item);
                setState(() {});
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'ACTIVIDADECONOMICA',
              title: 'Actividad 1',
              onChanged: (item) {
                if (item == null) return;
                // if (actividadesPredominantesList
                //     .any((element) => element.value == item.value)) {
                //   return;
                // }
                actividad1 = item;
                actividadesPredominantesList.add(item);
                setState(() {});
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'ACTIVIDADECONOMICA',
              title: 'Actividad 2',
              onChanged: (item) {
                if (item == null) return;
                // if (actividadesPredominantesList
                //     .any((element) => element.value == item.value)) {
                //   return;
                // }
                actividadEconomica2 = item;
                actividadesPredominantesList.add(item);
                setState(() {});
              },
            ),
            if (actividadesPredominantesList.isNotEmpty) ...[
              const Gap(20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: JLuxDropdown(
                  dropdownColor: Colors.white,
                  isContainIcon: true,
                  title: 'Actividad Predominante',
                  items: actividadesPredominantesList.length >= 3
                      ? actividadesPredominantesList
                          .skip(actividadesPredominantesList.length - 3)
                          .toSet()
                          .toList()
                      : actividadesPredominantesList.toSet().toList(),
                  onChanged: (item) {
                    if (item == null) return;
                    actividadPredominante = item;
                  },
                  toStringItem: (item) {
                    return item.name;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
            ],
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                  // context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                  //       objParentescoBeneficiarioSeguroId1Ver: parentesco?.name,
                  //       beneficiarioSeguro: beneficiarioSeguro,
                  //       cedulaBeneficiarioSeguro: cedulaBeneficiarioSeguro,
                  //       objParentescoBeneficiarioSeguroId: parentesco?.value,
                  //       beneficiarioSeguro1: beneficiarioSeguro1,
                  //       cedulaBeneficiarioSeguro1: cedulaBeneficiarioSeguro1,
                  //       objParentescoBeneficiarioSeguroId1:
                  //           parentescoBeneficiarioSeguro1,
                  //       telefonoBeneficiario: telefonoBeneficiario == null
                  //           ? ''
                  //           : telefonoBeneficiarioCode +
                  //               (telefonoBeneficiario ?? '')
                  //                   .trim()
                  //                   .replaceAll('-', ''),
                  //       telefonoBeneficiarioSeguro1:
                  //           telefonoBeneficiario1 == null
                  //               ? ''
                  //               : telefonoBeneficiario1Code +
                  //                   (telefonoBeneficiario1 ?? '')
                  //                       .trim()
                  //                       .replaceAll('-', ''),
                  //       isDone: !isConnected,
                  //     );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (ctx) => BlocProvider.value(
                  //       value: context.read<SolicitudNuevaMenorCubit>(),
                  //       child: SendingFormWidget(
                  //         solicitudId: context
                  //             .read<SolicitudNuevaMenorCubit>()
                  //             .state
                  //             .idLocalResponse,
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutLineButton(
                onPressed: () {
                  widget.controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                text: 'Atras',
                textColor: AppColors.red,
                color: AppColors.red,
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
