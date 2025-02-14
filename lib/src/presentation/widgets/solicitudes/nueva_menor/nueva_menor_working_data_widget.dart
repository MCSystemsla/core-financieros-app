import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
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
          const Gap(30),
          CatalogoValorNacionalidad(
            hintText: 'Selecciona Pais Emisor',
            title: 'Pais Emisor',
            onChanged: (item) {
              if (item == null) return;
              // paisEmisor = item.valor;
              // departamentoEmisor = null;
              // localDbProvider.getNacionalidadesDep(valor: item.valor);

              setState(() {});
            },
            codigo: 'PAIS',
            // initialValue: paisEmisor ?? '',
          ),
          // if (paisEmisor != null) ...[
          const Gap(30),
          CatalogoValorNacionalidad(
            // where: paisEmisor ?? '',
            hintText: 'Selecciona Departamento Emisor',
            title: 'Departamento Emisor',
            onChanged: (item) {
              if (item == null) return;
              // departamentoEmisor = item.valor;
              setState(() {});
            },
            codigo: 'DEP',
            // initialValue: departamentoEmisor?.valor ?? '',
          ),
          // ],
          const Gap(30),
          CatalogoValorNacionalidad(
            hintText: 'Selecciona Municipio Emisor',
            title: 'Municipio Emisor',
            onChanged: (item) {
              if (item == null) return;
              // paisEmisor = item.valor;
              setState(() {});
            },
            codigo: 'MUN',
          ),
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
