import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
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

class _NuevaMenorMontoWidgetState extends State<NuevaMenorMontoWidget> {
  String? estadoCivil;
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
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            CatalogoValorDropdownWidget(
              title: 'Estado Civil',
              codigo: 'ESTADOCIVIL',
              onChanged: (item) {
                if (item == null) return;
                estadoCivil = item.valor;
              },
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
            ),
            const Gap(20),
            CatalogoValorNacionalidad(
              codigo: 'PAIS',
              onChanged: (item) {
                if (item == null) return;
                nacionalidadConyuge = item.valor;
              },
              hintText: 'Ingresa Nacionalidad Conyuge',
              title: 'Nacionalidad Conyuge',
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.woman,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Nombre Conyuge',
              hintText: 'Ingresa nombre conyuge',
              onChange: (value) {
                nombreConyuge = value;
              },
              isValid: null,
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: 'Trabaja su conyuge',
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
              icon: Icon(
                Icons.woman_2,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Trabajo de Conyuge',
              hintText: 'Ingresa el Trabajo de Conyuge',
              isValid: null,
              onChange: (value) {
                trabajoConyuge = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.woman_2,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Direccion Trabajo Conyuge',
              hintText: 'Ingresa el Trabajo de Conyuge',
              isValid: null,
              onChange: (value) {
                direccionTrabajoConyuge = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.phone,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Telefono Trabajo Conyuge',
              hintText: 'Ingresa el Telefono de Conyuge',
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
              title: 'Cantidad Hijos',
              hintText: 'Ingresa Cantida de Hijos',
              isValid: null,
              onChange: (value) {
                cantidadHijos = value;
              },
            ),
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
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
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
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.add_card_sharp,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Persona a cargo',
              hintText: 'Ingresa la persona a cargo',
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
                        objEstadoCivilId: estadoCivil,
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
}
