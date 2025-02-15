import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NuevaMenorBusinessDataWidget extends StatelessWidget {
  const NuevaMenorBusinessDataWidget({
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
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.work,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Profesion',
            hintText: 'Ingresa Profesion',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.person_sharp,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Ocupacion',
            hintText: 'Ingresa Ocupacion',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Nombre Negocio',
            hintText: 'Ingresa Nombre Negocio',
            isValid: null,
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'TIPOVIVIENDA',
            onChanged: (item) {},
            title: 'Condicion Negocio',
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.access_time,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Tiempo Funcionamiento de Negocio',
            hintText: 'Ingresa Tiempo Funcionamiento de Negocio',
            isValid: null,
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'ACTIVIDADECONOMICA',
            title: 'Actividad Predominante',
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'RUBROACTIVIDAD',
            title: 'Rubro Actividad Predominante',
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'RUBROACTIVIDAD',
            title: 'Rubro Actividad 2',
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'RUBROACTIVIDAD',
            title: 'Rubro Actividad 2',
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'ACTIVIDADECONOMICA',
            title: 'Actividad 2',
          ),
          const Gap(20),
          const SearchDropdownWidget(
            codigo: 'RUBROACTIVIDAD',
            title: 'Rubro Actividad 3',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'SECTORECONOMICO',
            onChanged: (item) {},
            title: 'Sector Economico',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'SECTORECONOMICO',
            onChanged: (item) {},
            title: 'Sector Economico',
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.watch_later_sharp,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Horario de Trabajo',
            hintText: 'Ingresa Horario de Trabajo',
            isValid: null,
          ),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.watch_later_sharp,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Horario de Visita',
            hintText: 'Ingresa Horario de Visita',
            isValid: null,
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            hintText: 'Ingresa Municipio de Negocio',
            title: 'Municipio de Negocio',
            onChanged: (item) {},
            codigo: 'MUN',
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.business,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Barrio de Negocio',
            hintText: 'Ingresa Barrio de Negocio',
            isValid: null,
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.location_on_rounded,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Direccion de Negocio',
            hintText: 'Ingresa Direccion de Negocio',
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
