import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/origin/origin.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorWorkingDataWidget extends StatefulWidget {
  final PageController controller;
  const NuevaMenorWorkingDataWidget({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorWorkingDataWidget> createState() =>
      _NuevaMenorWorkingDataWidgetState();
}

class _NuevaMenorWorkingDataWidgetState
    extends State<NuevaMenorWorkingDataWidget> {
  String? initialValue;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const Gap(30),
          CatalogoValorNacionalidad(
            hintText: 'Selecciona Pais de Casa',
            title: 'Pais Domicilio',
            onChanged: (item) {
              if (item == null) return;
            },
            codigo: 'PAIS',
            // initialValue: paisEmisor ?? '',
          ),
          const Gap(30),
          CatalogoValorNacionalidad(
            hintText: 'Selecciona Departamento de Casa',
            title: 'Departamento Domicilio',
            onChanged: (item) {
              if (item == null) return;
            },
            codigo: 'DEP',
            // initialValue: paisEmisor ?? '',
          ),
          const Gap(30),
          CatalogoValorNacionalidad(
            hintText: 'Selecciona Municipio de Casa',
            title: 'Municipio Domicilio',
            onChanged: (item) {
              if (item == null) return;
            },
            codigo: 'MUN',
            // initialValue: paisEmisor ?? '',
          ),
          const Gap(30),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Barrio Casa',
            hintText: 'Ingresa Barrio Casa',
            isValid: null,
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            title: 'Condicion Casa',
            initialValue: initialValue ?? '',
            codigo: 'TIPOVIVIENDA',
            onChanged: (item) {
              if (item == null) return;
              initialValue = item.valor;
              setState(() {});
            },
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Años Residir Casa',
            hintText: 'Ingresa Años Residir Casa',
            isValid: null,
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: JLuxDropdown(
              dropdownColor: Colors.white,
              isContainIcon: true,
              title: 'Su comunidad es:',
              items: Origin.comunidades,
              onChanged: (item) {},
              toStringItem: (item) {
                return item.nombre;
              },
              hintText: 'input.select_option'.tr(),
            ),
          ),
          // * TODO: Agregar Geolocator para anadir Latitud y Longitud
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: CustomElevatedButton(
              text: 'Siguiente',
              color: AppColors.greenLatern.withOpacity(0.4),
              onPressed: () {
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
    );
  }
}
