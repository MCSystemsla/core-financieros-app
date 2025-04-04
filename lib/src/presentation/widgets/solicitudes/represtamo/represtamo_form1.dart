import 'dart:developer';

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoForm1 extends StatefulWidget {
  final PageController controller;
  const ReprestamoForm1({super.key, required this.controller});

  @override
  State<ReprestamoForm1> createState() => _ReprestamoForm1State();
}

class _ReprestamoForm1State extends State<ReprestamoForm1> {
  String? initialValue;
  String? departamentoEmisor;

  String? tipoPersonaCredito;
  String? tipoPersonaCreditoVer;
  String? celularReprestamo;

  @override
  void initState() {
    GeolocationService(context: context).getCurrentLocation().then(
      (value) {
        log('Ubicacion: ${value?.latitude}, ${value?.longitude}');
      },
    );

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  String countryCode = '+505';
  String celularCode = '+505';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(30),
            SearchDropdownWidget(
              // initialValue: '',
              codigo: 'TIPOSPERSONACREDITO',
              onChanged: (item) {
                if (item == null || !mounted) return;
                tipoPersonaCredito = item.value;
                tipoPersonaCreditoVer = item.name;
              },
              title: 'Tipo de Persona',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
            ),
            const Gap(30),
            CountryInput(
              maxLength: 40,
              icon: Icon(
                Icons.person,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Celular Represtamo',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DashFormatter(),
              ],
              onChange: (value) {
                celularReprestamo = value;
                setState(() {});
              },
              hintText: 'Ingresa Celular Represtamo',
              isValid: null,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            OutlineTextfieldWidget(
              maxLength: 50,
              icon: Icon(
                Icons.location_on,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Ubicacion',
              textCapitalization: TextCapitalization.words,
              onChange: (value) {
                setState(() {});
              },
              hintText: 'Ingresa Ubicacion',
              isValid: null,
              isRequired: true,
              validator: (value) => ClassValidator.validateRequired(value),
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () async {
                  // if (!formKey.currentState!.validate()) return;

                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutLineButton(
                onPressed: () {
                  context.pushReplacement('/solicitudes');
                },
                text: 'Cancelar',
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
