import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class AnalisisDatosDeActividad extends StatefulWidget {
  const AnalisisDatosDeActividad({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisDatosDeActividad> createState() =>
      _AnalisisDatosDeActividadState();
}

class _AnalisisDatosDeActividadState extends State<AnalisisDatosDeActividad> {
  bool esAsalariado = false;
  bool esEmpresario = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Informacion del trabajo o negocio',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          CustomSwitch(
            title: 'Es Asalariado?',
            subtitle: 'El fiador es Asalariado?',
            value: esAsalariado,
            onChanged: (value) {
              setState(() {
                esAsalariado = value;
              });
            },
          ),
          if (esAsalariado) ...[
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Empresa que labora',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Cargo',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Tiempo Laborar',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Lugar de trabajo anterior',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
          ],
          const Gap(20),
          CustomSwitch(
            title: 'Es Empresario?',
            subtitle: 'El fiador es Empresario?',
            value: esEmpresario,
            onChanged: (value) {
              setState(() {
                esEmpresario = value;
              });
            },
          ),
          if (esEmpresario) ...[
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Nombre del negocio',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Anos de funcionamiento',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'NIVELAPROXIMADOINGRESOS',
              title: 'Nivel de aproximado en ingresos',
              hintText: 'input_select_option'.tr(),
              onChanged: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Puesto que desempeña',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            SearchDropdownWidget(
              codigo: 'TIPOVIVIENDA',
              title: 'Condición local del negocio',
              hintText: 'input_select_option'.tr(),
              onChanged: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Horario de visita',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Horario de trabajo',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              title: 'Anos de experiencia',
              hintText: 'input_select_option'.tr(),
              icon: const Icon(Icons.person),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChange: (value) {},
            ),
          ],
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Informacion de contacto y direccion del trabajo/negocio',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            codigo: 'PAIS',
            title: 'Pais',
            hintText: 'input_select_option'.tr(),
            onChanged: (value) {},
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            codigo: 'DEP',
            title: 'Departamento',
            hintText: 'input_select_option'.tr(),
            onChanged: (value) {},
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            codigo: 'MUN',
            title: 'Municipio',
            hintText: 'input_select_option'.tr(),
            onChanged: (value) {},
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            codigo: 'ALD',
            title: 'Aldea',
            hintText: 'input_select_option'.tr(),
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Caserio',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Barrio',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Direccion y referencia',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Telefono',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Celular',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomElevatedButton(
              onPressed: () {
                widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              text: 'Siguiente',
              color: Colors.green,
            ),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomOutLineButton(
              onPressed: () {
                widget.pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              text: 'Anterior',
              textColor: AppColors.red,
              color: AppColors.red,
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
