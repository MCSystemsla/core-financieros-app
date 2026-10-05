import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_coordinador/supervision_coordinador_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SupervisionFormHN2 extends StatefulWidget {
  final PageController pageController;
  const SupervisionFormHN2({
    super.key,
    required this.pageController,
  });

  @override
  State<SupervisionFormHN2> createState() => _SupervisionFormHN2State();
}

class _SupervisionFormHN2State extends State<SupervisionFormHN2>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SupervisionCoordinadorCubit>();

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                child: const Text(
                  'Aspectos cualitativos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
              ),
              const Gap(10),
              SheetSearchDropdown(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value.toString()),
                title: 'Referencias en el buró de credito',
                isRequired: true,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      buroCreditoBueno: v?.value == SupervisionItem1.bueno,
                      buroCreditoRegular: v?.value == SupervisionItem1.regular,
                      buroCreditoMalas: v?.value == SupervisionItem1.malo,
                    ),
                  );
                },
                hintText: 'input.select_option'.tr(),
                enabled: true,
                items: const [
                  Item(name: 'Bueno', value: SupervisionItem1.bueno),
                  Item(name: 'Regular', value: SupervisionItem1.regular),
                  Item(name: 'Malo', value: SupervisionItem1.malo),
                ],
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                child: const Text(
                  'Referencias en la comunidad 1',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                title: 'Nombre',
                icon: const Icon(Icons.food_bank),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      nombreRefComunidad1: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                title: 'Direccion',
                icon: const Icon(Icons.food_bank),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      direccionRefComunidad1: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              SheetSearchDropdown(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value.toString()),
                title: 'La referencia es:',
                isRequired: true,
                onChanged: (v) {},
                hintText: 'input.select_option'.tr(),
                enabled: true,
                items: const [
                  Item(name: 'Buenas', value: SupervisionItem1.bueno),
                  Item(name: 'Regular', value: SupervisionItem1.regular),
                  Item(name: 'Malo', value: SupervisionItem1.malo),
                ],
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                child: const Text(
                  'Referencias en la comunidad 2',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: RedesignColors.ink,
                  ),
                ),
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                validator: (value) => ClassValidator.validateRequired(value),
                title: 'Nombre',
                icon: const Icon(Icons.food_bank),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      nombreRefComunidad2: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                validator: (value) => ClassValidator.validateRequired(value),
                title: 'Direccion',
                icon: const Icon(Icons.food_bank),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      direccionRefComunidad2: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              SheetSearchDropdown(
                title: 'La referencia es:',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value.toString()),
                isRequired: true,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      buroCreditoBueno: v?.value == SupervisionItem1.bueno,
                      buroCreditoRegular: v?.value == SupervisionItem1.regular,
                      buroCreditoMalas: v?.value == SupervisionItem1.malo,
                    ),
                  );
                },
                hintText: 'input.select_option'.tr(),
                enabled: true,
                items: const [
                  Item(name: 'Buenas', value: SupervisionItem1.bueno),
                  Item(name: 'Regular', value: SupervisionItem1.regular),
                  Item(name: 'Malo', value: SupervisionItem1.malo),
                ],
              ),
              SheetSearchDropdown(
                hintText: 'input.select_option'.tr(),
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value.toString()),
                isRequired: true,
                title: 'Tipo Vivienda',
                enabled: true,
                items: const [
                  Item(name: 'Alquiler', value: SupervisionItem2.alquiler),
                  Item(name: 'Propia', value: SupervisionItem2.propia),
                  Item(
                    name: 'Casa de trabajo',
                    value: SupervisionItem2.casaDeTrabajo,
                  ),
                ],
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      tipoViviendaAlquilada:
                          v?.value == SupervisionItem2.alquiler,
                      tipoViviendaPropia: v?.value == SupervisionItem2.propia,
                      tipoViviendaFamiliar:
                          v?.value == SupervisionItem2.casaDeTrabajo,
                    ),
                  );
                },
              ),
              const Gap(10),
              OutlineTextfieldWidget(
                validator: (value) => ClassValidator.validateRequired(value),
                title: 'Tiempo en el negocio',
                icon: const Icon(Icons.food_bank),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      tiempoNegocio: value,
                    ),
                  );
                },
              ),
              const Gap(10),
              SheetSearchDropdown(
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value.toString()),
                title: 'Conocimiento del negocio',
                isRequired: true,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      conocimientoNegocioAlto:
                          v?.value == SupervisionItem1.bueno,
                      conocimientoNegocioMedio:
                          v?.value == SupervisionItem1.regular,
                      conocimientoNegocioBajo:
                          v?.value == SupervisionItem1.malo,
                    ),
                  );
                },
                hintText: 'input.select_option'.tr(),
                enabled: true,
                items: const [
                  Item(name: 'Alto', value: SupervisionItem1.bueno),
                  Item(name: 'Medio', value: SupervisionItem1.regular),
                  Item(name: 'Bajo', value: SupervisionItem1.malo),
                ],
              ),
              const Gap(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      text: 'Siguiente',
                      color: RedesignColors.green,
                    ),
                    const Gap(10),
                    CustomOutLineButton(
                      onPressed: () {
                        widget.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      text: 'Anterior',
                      color: RedesignColors.border,
                      textColor: RedesignColors.ink,
                    ),
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
