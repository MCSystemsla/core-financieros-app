import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/origin/origin.dart';
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
  String? paisDomicilio;
  String? departamentoDomicilio;
  String? municipioDomicilio;
  String? barrioCasa;
  String? condicionCasa;
  String? anosResidirCasa;
  String? comunidad;
  String? direccionCasa;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: 'Selecciona Pais de Casa',
              title: 'Pais Domicilio',
              onChanged: (item) {
                if (item == null) return;
                paisDomicilio = item.valor;
              },
              codigo: 'PAIS',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              // initialValue: paisEmisor ?? '',
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: 'Selecciona Departamento de Casa',
              title: 'Departamento Domicilio',
              onChanged: (item) {
                if (item == null) return;
                departamentoDomicilio = item.valor;
              },
              codigo: 'DEP',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),

              // initialValue: paisEmisor ?? '',
            ),
            const Gap(30),
            CatalogoValorNacionalidad(
              hintText: 'Selecciona Municipio de Casa',
              title: 'Municipio Domicilio',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),

              onChanged: (item) {
                if (item == null) return;
                municipioDomicilio = item.valor;
              },
              codigo: 'MUN',
              // initialValue: paisEmisor ?? '',
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.house,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Direccion Casa',
              hintText: 'Ingresa Direccion Casa',
              onChange: (value) {
                direccionCasa = value;
              },
              isValid: null,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.calendar_today,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Barrio Casa',
              maxLength: 50,
              hintText: 'Ingresa Barrio Casa',
              onChange: (value) {
                barrioCasa = value;
              },
              isValid: null,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(20),
            CatalogoValorDropdownWidget(
              title: 'Condicion Casa',
              // initialValue: initialValue ?? '',
              codigo: 'TIPOVIVIENDA',
              onChanged: (item) {
                if (item == null) return;
                condicionCasa = item.valor;
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
              onChange: (value) {
                anosResidirCasa = value;
              },
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: JLuxDropdown(
                dropdownColor: Colors.white,
                isContainIcon: true,
                title: 'Ubicacion',
                items: Origin.comunidades,
                onChanged: (item) {
                  if (item == null) return;
                  comunidad = item.valor;
                },
                toStringItem: (item) {
                  return item.nombre;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  final geolocationService =
                      GeolocationService(context: context);
                  final currentLocation =
                      await geolocationService.getCurrentLocation();
                  if (!context.mounted) return;
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        barrioCasa: barrioCasa,
                        objPaisCasaId: paisDomicilio,
                        objDepartamentoCasaId: departamentoDomicilio,
                        objMunicipioCasaId: municipioDomicilio,
                        objCondicionCasaId: condicionCasa,
                        anosResidirCasa: int.tryParse(anosResidirCasa ?? ''),
                        ubicacion: comunidad,
                        ubicacionLatitud: currentLocation?.latitude.toString(),
                        ubicacionLongitud:
                            currentLocation?.longitude.toString(),
                        direccionCasa: direccionCasa,
                      );
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
}
