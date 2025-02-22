import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/sending/sending_form_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorBeneficiarioWidget extends StatefulWidget {
  const NuevaMenorBeneficiarioWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorBeneficiarioWidget> createState() =>
      _NuevaMenorBeneficiarioWidgetState();
}

class _NuevaMenorBeneficiarioWidgetState
    extends State<NuevaMenorBeneficiarioWidget> {
  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  String? parentesco;
  String? beneficiarioSeguro1;
  String? cedulaBeneficiarioSeguro1;
  String? parentescoBeneficiarioSeguro1;
  String? telefonoBeneficiario;
  String? telefonoBeneficiario1;
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
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.family_restroom,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Beneficiario Seguro',
              hintText: 'Ingresa Beneficiario Seguro',
              isValid: null,
              onChange: (value) {
                beneficiarioSeguro = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.credit_card,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Cedula Beneficiario Seguro',
              hintText: 'Ingresa Cedula Beneficiario Seguro',
              isValid: null,
              onChange: (value) {
                cedulaBeneficiarioSeguro = value;
              },
            ),
            const Gap(20),
            CatalogoValorDropdownWidget(
              codigo: 'PARENTESCO',
              title: 'Parentesco Beneficiario Seguro',
              hintText: 'Ingresa Parentesco Beneficiario Seguro',
              onChanged: (item) {
                if (item == null) return;
                parentesco = item.valor;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.security,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Beneficiario Seguro 1',
              hintText: 'Ingresa Beneficiario Seguro 1',
              isValid: null,
              onChange: (value) {
                beneficiarioSeguro1 = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.credit_card,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Cedula Beneficiario Seguro 1',
              hintText: 'Ingresa Cedula Beneficiario Seguro 1',
              isValid: null,
              onChange: (value) {
                cedulaBeneficiarioSeguro1 = value;
              },
            ),
            const Gap(20),
            CatalogoValorDropdownWidget(
              codigo: 'PARENTESCO',
              title: 'Parentesco Beneficiario Seguro 1',
              hintText: 'Ingresa Parentesco Beneficiario Seguro 1',
              onChanged: (item) {
                if (item == null) return;
                parentescoBeneficiarioSeguro1 = item.valor;
              },
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
              onChange: (value) {
                telefonoBeneficiario = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              icon: Icon(
                Icons.phone,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Telefono Beneficiario 1',
              hintText: 'Ingresa Telefono Beneficiario 1',
              isValid: null,
              onChange: (value) {
                telefonoBeneficiario1 = value;
              },
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Enviar Solicitud',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                        beneficiarioSeguro: beneficiarioSeguro,
                        cedulaBeneficiarioSeguro: cedulaBeneficiarioSeguro,
                        objParentescoBeneficiarioSeguroId: parentesco,
                        beneficiarioSeguro1: beneficiarioSeguro1,
                        cedulaBeneficiarioSeguro1: cedulaBeneficiarioSeguro1,
                        objParentescoBeneficiarioSeguroId1:
                            parentescoBeneficiarioSeguro1,
                        telefonoBeneficiario: telefonoBeneficiario,
                        telefonoBeneficiarioSeguro1: telefonoBeneficiario1,
                      );
                  context.pushTransparentRoute(const SendingFormWidget());
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
