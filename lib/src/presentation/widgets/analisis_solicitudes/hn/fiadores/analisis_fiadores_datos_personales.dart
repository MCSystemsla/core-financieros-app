import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class AnalisisFiadoresDatosPersonales extends StatelessWidget {
  const AnalisisFiadoresDatosPersonales({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

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
              'Datos Personales',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          CatalogoValorNacionalidad(
            codigo: 'PAIS',
            hintText: 'input_select_option'.tr(),
            title: 'Pais:',
            onChanged: (value) {},
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            codigo: 'DEP',
            hintText: 'input_select_option'.tr(),
            title: 'Departamento:',
            onChanged: (value) {},
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            codigo: 'MUN',
            hintText: 'input_select_option'.tr(),
            title: 'Municipio:',
            onChanged: (value) {},
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            codigo: 'ALD',
            hintText: 'input_select_option'.tr(),
            title: 'Aldea:',
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
            title: 'Direccion y Referencia',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          CatalogoValorNacionalidad(
            codigo: 'PAIS',
            hintText: 'input_select_option'.tr(),
            title: 'Nacionalidad:',
            onChanged: (value) {},
          ),
          CatalogoValorNacionalidad(
            codigo: 'PAIS',
            hintText: 'input_select_option'.tr(),
            title: 'Nacionalidad 2:',
            onChanged: (value) {},
          ),
          CatalogoValorNacionalidad(
            codigo: 'PAIS',
            hintText: 'input_select_option'.tr(),
            title: 'Nacionalidad 3:',
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Telefono',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Celular',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Correo Electrónico',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            onChange: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'ESCOLARIDAD',
            title: 'Escolaridad',
            onChanged: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'PROFESION',
            title: 'Profesion',
            onChanged: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'OCUPACION',
            title: 'Ocupacion',
            onChanged: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Numero de dependientes',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Numero de hijos',
            hintText: 'input_select_option'.tr(),
            icon: const Icon(Icons.person),
            onChange: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'TIPOPERSONACNBS',
            title: 'Tipo persona CNBS',
            onChanged: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'TIPOCLIENTE',
            title: 'Estatus',
            onChanged: (value) {},
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'ESTATUSCLIENTE',
            title: 'Tipo de cliente',
            onChanged: (value) {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomElevatedButton(
              onPressed: () {
                pageController.nextPage(
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
                pageController.previousPage(
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
