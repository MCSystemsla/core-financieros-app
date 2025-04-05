import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReprestamoForm2 extends StatefulWidget {
  final PageController controller;
  const ReprestamoForm2({super.key, required this.controller});

  @override
  State<ReprestamoForm2> createState() => _ReprestamoForm2State();
}

class _ReprestamoForm2State extends State<ReprestamoForm2>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? familiarEmpleado;
  String? familiarEntidad;
  String? familiarCargoPublico;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: 'Es familiar de un empleado?'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  familiarEmpleado = item;
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
            if (familiarEmpleado == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.person,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre del empleado',
                hintText: 'Ingresa Nombre del empleado',
                isValid: null,
                onChange: (value) {},
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cedula',
                hintText: 'Ingresa Cedula del empleado',
                isValid: null,
                onChange: (value) {},
              ),
            ],
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    'Has desempeñado un cargo publico y/o figura publica de alto nivel en los ultimos 10 años?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  familiarEntidad = item;
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
            if (familiarEntidad == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre de la entidad',
                hintText: 'Ingresa Nombre de la entidad',
                isValid: null,
                onChange: (value) {},
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                hintText: 'Ingresa Pais',
                title: 'Pais',
                onChanged: (item) {
                  if (item == null) return;
                  // paisDomicilio = Item(name: item.nombre, value: item.valor);
                  // depWhereClause = item.valor;

                  setState(() {});
                },
                codigo: 'PAIS',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                // initialValue: paisEmisor ?? '',
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Periodo',
                hintText: 'Ingrese periodo',
                isValid: null,
                onChange: (value) {},
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cargo oficial',
                hintText: 'Ingrese Cargo oficial',
                isValid: null,
                onChange: (value) {},
              ),
            ],
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title:
                    'Eres familia de una persona que a desempeñado un cargo publico o figura publica de alto nivel?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  familiarCargoPublico = item;
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
            if (familiarCargoPublico == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre del familiar',
                hintText: 'Ingrese Nombre del familiar',
                isValid: null,
                onChange: (value) {},
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre de la entidad',
                hintText: 'Ingrese Nombre de la entidad',
                isValid: null,
                onChange: (value) {},
              ),
              const Gap(20),
              SearchDropdownWidget(
                onChanged: (item) {
                  if (item == null) return;
                  setState(() {});
                },
                codigo: 'PARENTESCO',
                title: 'Parentesco',
                hintText: 'Ingrese Parentesco',
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.credit_card,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Periodo',
                hintText: 'Ingrese Periodo',
                isValid: null,
                onChange: (value) {},
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                hintText: 'Ingresa Pais',
                title: 'Pais',
                onChanged: (item) {
                  if (item == null) return;
                  // paisDomicilio = Item(name: item.nombre, value: item.valor);
                  // depWhereClause = item.valor;

                  setState(() {});
                },
                codigo: 'PAIS',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                // initialValue: paisEmisor ?? '',
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
