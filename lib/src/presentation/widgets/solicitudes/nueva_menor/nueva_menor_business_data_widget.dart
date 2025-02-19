import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorBusinessDataWidget extends StatefulWidget {
  const NuevaMenorBusinessDataWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorBusinessDataWidget> createState() =>
      _NuevaMenorBusinessDataWidgetState();
}

class _NuevaMenorBusinessDataWidgetState
    extends State<NuevaMenorBusinessDataWidget> {
  String? profesion;
  String? ocupacion;
  String? nombreNegocio;
  String? condicionNegocio;
  String? funcionamientoNegocio;
  String? actividadPredominante;
  String? rubroActividad;
  String? rubroActividad2;
  String? rubroActividad3;
  String? actividadEconomica2;
  String? sectorEconomico;
  String? sectorEconomico2;
  String? horarioTrabajo;
  String? horarioVisita;
  String? municipioNegocio;
  String? barrioNegocio;
  String? direccionNegocio;
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
            onChange: (value) {
              profesion = value;
            },
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
            onChange: (value) {
              ocupacion = value;
            },
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
            onChange: (value) {
              nombreNegocio = value;
            },
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            initialValue: '',
            codigo: 'TIPOVIVIENDA',
            onChanged: (item) {
              if (item == null) return;
              condicionNegocio = item.valor;
            },
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
            onChange: (value) {
              funcionamientoNegocio = value;
            },
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'ACTIVIDADECONOMICA',
            title: 'Actividad Predominante',
            onChanged: (item) {
              if (item == null) return;
              actividadPredominante = item.value;
            },
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'RUBROACTIVIDAD',
            title: 'Rubro Actividad Predominante',
            onChanged: (item) {
              rubroActividad = item?.value;
            },
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'RUBROACTIVIDAD',
            title: 'Rubro Actividad 2',
            onChanged: (item) {
              if (item == null) return;
              rubroActividad2 = item.value;
            },
          ),
          // const Gap(20),
          // const SearchDropdownWidget(
          //   codigo: 'RUBROACTIVIDAD',
          //   title: 'Rubro Actividad 2',
          // ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'ACTIVIDADECONOMICA',
            title: 'Actividad 2',
            onChanged: (item) {
              if (item == null) return;
              actividadEconomica2 = item.value;
            },
          ),
          const Gap(20),
          SearchDropdownWidget(
            codigo: 'RUBROACTIVIDAD',
            title: 'Rubro Actividad 3',
            onChanged: (item) {
              if (item == null) return;
              rubroActividad3 = item.value;
            },
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            codigo: 'SECTORECONOMICO',
            onChanged: (item) {
              if (item == null) return;
              sectorEconomico = item.valor;
            },
            title: 'Sector Economico',
          ),
          const Gap(20),
          CatalogoValorDropdownWidget(
            codigo: 'SECTORECONOMICO',
            onChanged: (item) {
              if (item == null) return;
              sectorEconomico2 = item.valor;
            },
            title: 'Sector Economico 2',
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
            onChange: (value) {
              horarioTrabajo = value;
            },
          ),
          OutlineTextfieldWidget(
            icon: Icon(
              Icons.watch_later_sharp,
              color: AppColors.getPrimaryColor(),
            ),
            title: 'Horario de Visita',
            hintText: 'Ingresa Horario de Visita',
            isValid: null,
            onChange: (value) {
              horarioVisita = value;
            },
          ),
          const Gap(20),
          CatalogoValorNacionalidad(
            hintText: 'Ingresa Municipio de Negocio',
            title: 'Municipio de Negocio',
            onChanged: (item) {
              if (item == null) return;
              municipioNegocio = item.valor;
            },
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
            onChange: (value) {
              barrioNegocio = value;
            },
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
            onChange: (value) {
              direccionNegocio = value;
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
                // pageController.nextPage(
                //   duration: const Duration(milliseconds: 300),
                //   curve: Curves.easeIn,
                // );
                context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                      profesion: profesion,
                      ocupacion: ocupacion,
                      nombreNegocio: nombreNegocio,
                      objCondicionNegocioId: condicionNegocio,
                      tiempoFuncionamientoNegocio: funcionamientoNegocio,
                      objActividadPredominante: actividadPredominante,
                      objRubroActividad: rubroActividad,
                      objRubroActividad2: rubroActividad2,
                      objRubroActividad3: rubroActividad3,
                      objActividadId2: actividadEconomica2,
                      objSectorId: sectorEconomico,
                      // sectorEconomico: sectorEconomico2,
                      horarioTrabajo: horarioTrabajo,
                      horarioVisita: horarioVisita,
                      objMunicipioNegocioId: municipioNegocio,
                      barrioNegocio: barrioNegocio,
                      direccionNegocio: direccionNegocio,
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
    );
  }
}
