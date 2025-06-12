// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorMontoWidget extends StatefulWidget {
  const NuevaMenorMontoWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorMontoWidget> createState() => _NuevaMenorMontoWidgetState();
}

class _NuevaMenorMontoWidgetState extends State<NuevaMenorMontoWidget>
    with AutomaticKeepAliveClientMixin {
  Item? estadoCivil;
  String? nacionalidadConyuge;
  String? nombreConyuge;
  String? trabajaConyuge;
  String? trabajoConyuge;
  String? direccionTrabajoConyuge;
  String? telefonoTrabajoConyuge;
  String? cantidadHijos;
  String? esFamiliarEmpleado;
  String? nombreFamiliarEmpleado;
  String? cedulaFamiliarEmpleado;
  String? personasACargo;
  final formKey = GlobalKey<FormState>();
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
              title: 'Estado Civil',
              codigo: 'ESTADOCIVIL',
              onChanged: (item) {
                if (item == null) return;
                estadoCivil = Item(name: item.name, value: item.value);
                setState(() {});
              },
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
            ),
            if (estadoCivil?.value == 'UNI' || estadoCivil?.value == 'CAS') ...[
              const Gap(20),
              CatalogoValorNacionalidad(
                codigo: 'PAIS',
                onChanged: (item) {
                  if (item == null) return;
                  nacionalidadConyuge = item.valor;
                },
                hintText: 'Ingresa Nacionalidad Cónyuge',
                title: 'Nacionalidad Cónyuge',
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                maxLength: 50,
                icon: Icon(
                  Icons.woman,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre Cónyuge',
                hintText: 'Ingresa Nombre Cónyuge',
                onChange: (value) {
                  nombreConyuge = value;
                },
                isValid: null,
              ),
              const Gap(20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: JLuxDropdown(
                  dropdownColor: Colors.white,
                  isContainIcon: true,
                  title: '¿Trabaja su cónyuge?',
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    trabajaConyuge = item;
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                maxLength: 50,
                icon: Icon(
                  Icons.woman_2,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Trabajo de Cónyuge',
                hintText: 'Ingresa el Trabajo de Cónyuge',
                isValid: null,
                onChange: (value) {
                  trabajoConyuge = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                maxLength: 50,
                icon: Icon(
                  Icons.woman_2,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Dirección Trabajo Cónyuge',
                hintText: 'Ingresa Dirección Trabajo Cónyuge',
                isValid: null,
                onChange: (value) {
                  direccionTrabajoConyuge = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                maxLength: 15,
                icon: Icon(
                  Icons.phone,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Teléfono Trabajo Cónyuge',
                hintText: 'Ingresa el Teléfono Trabajo Cónyuge',
                textInputType: TextInputType.phone,
                isValid: null,
                onChange: (value) {
                  telefonoTrabajoConyuge = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.phone,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cantidad de Hijos',
                hintText: 'Ingresa Cantidad de Hijos',
                textInputType: TextInputType.number,
                isValid: null,
                onChange: (value) {
                  cantidadHijos = value;
                },
              ),
            ],
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: 'Es familiar empleado',
                validator: (value) => ClassValidator.validateRequired(value),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  esFamiliarEmpleado = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (esFamiliarEmpleado == 'input.yes'.tr()) ...[
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.family_restroom,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Nombre familiar de empleado',
                hintText: 'Ingresa el nombre de empleado',
                isValid: null,
                onChange: (value) {
                  nombreFamiliarEmpleado = value;
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                icon: Icon(
                  Icons.add_card_sharp,
                  color: AppColors.getPrimaryColor(),
                ),
                title: 'Cedula familiar de empleado',
                hintText: 'Ingresa la cedula de empleado',
                isValid: null,
                onChange: (value) {
                  cedulaFamiliarEmpleado = value;
                },
              ),
            ],
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.add_card_sharp,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Persona a cargo',
              hintText: 'Ingresa la persona a cargo',
              textInputType: TextInputType.number,
              isValid: null,
              onChange: (value) {
                personasACargo = value;
              },
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        objEstadoCivilIdVer: estadoCivil?.name,
                        objEstadoCivilId: estadoCivil?.value,
                        nacionalidadConyugue: nacionalidadConyuge,
                        nombreConyugue: nombreConyuge,
                        trabajaConyugue: trabajaConyuge == 'input.yes'.tr(),
                        trabajoConyugue: trabajoConyuge,
                        direccionTrabajoConyugue: direccionTrabajoConyuge,
                        telefonoTrabajoConyugue: telefonoTrabajoConyuge,
                        cantidadHijos: int.tryParse(cantidadHijos ?? ''),
                        esFamiliarEmpleado:
                            esFamiliarEmpleado == 'input.yes'.tr(),
                        nombreFamiliar: nombreFamiliarEmpleado,
                        cedulaFamiliar: cedulaFamiliarEmpleado,
                        personasACargo: int.tryParse(personasACargo ?? ''),
                      );
                  widget.pageController.nextPage(
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
                  widget.pageController.previousPage(
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
