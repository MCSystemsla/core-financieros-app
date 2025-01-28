import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorActividadWidget extends StatelessWidget {
  const NuevaMenorActividadWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'RUBROACTIVIDAD',
            onChanged: (item) {},
            title: 'Rubro Actividad',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'ACTIVIDADECONOMICA',
            onChanged: (item) {},
            title: 'Actividad Predominante',
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.family_restroom,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Es Familiar Empleado',
            hintText: 'Selecciona Es Familiar Empleado',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre Familiar',
            hintText: 'Ingresa Nombre Familiar',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.credit_card,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Cedula Familiar',
            hintText: 'Ingresa Cedula Familiar',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.document_scanner,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Tipo Documento ID',
            hintText: 'Selecciona Tipo Documento ID',
            isValid: null,
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'RUBROACTIVIDAD',
            onChanged: (item) {},
            title: 'Rubro Actividad 2',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'RUBROACTIVIDAD',
            onChanged: (item) {},
            title: 'Rubro Actividad 3',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'ACTIVIDADECONOMICA',
            onChanged: (item) {},
            title: 'Rubro Actividad Predominante',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'TIPOSPERSONACREDITO',
            onChanged: (item) {},
            title: 'Tipo Persona',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'TIPOSPERSONACREDITO',
            onChanged: (item) {},
            title: 'Tipo Persona ID',
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.phone,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Telefono Beneficiario',
            hintText: 'Ingresa Telefono Beneficiario',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.phone,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Telefono Beneficiario Seguro 1',
            hintText: 'Ingresa Telefono Beneficiario Seguro 1',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Plazo Solicitud',
            hintText: 'Ingresa Plazo Solicitud',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Fecha Primer Pago Solicitud',
            hintText: 'Ingresa Fecha Primer Pago Solicitud',
            isValid: null,
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: CustomElevatedButton(
              text: 'Siguiente',
              color: AppColors.greenLatern.withOpacity(0.4),
              onPressed: () {
                pageController.nextPage(
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
                pageController.previousPage(
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
