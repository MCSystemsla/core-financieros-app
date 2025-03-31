import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/sending/sending_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
    extends State<NuevaMenorBeneficiarioWidget>
    with AutomaticKeepAliveClientMixin {
  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  Item? parentesco;
  String? beneficiarioSeguro1;
  String? cedulaBeneficiarioSeguro1;
  String? parentescoBeneficiarioSeguro1;
  String? telefonoBeneficiario;
  String? telefonoBeneficiario1;
  final formKey = GlobalKey<FormState>();
  String telefonoBeneficiarioCode = '+505';
  String telefonoBeneficiario1Code = '+505';

  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            OutlineTextfieldWidget(
              maxLength: 50,
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
              maxLength: 16,
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
            SearchDropdownWidget(
              codigo: 'PARENTESCO',
              title: 'Parentesco Beneficiario Seguro',
              // hintText: 'Ingresa Parentesco Beneficiario Seguro',
              onChanged: (item) {
                if (item == null) return;
                parentesco = item;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              maxLength: 50,
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
              maxLength: 16,
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
            SearchDropdownWidget(
              codigo: 'PARENTESCO',
              title: 'Parentesco Beneficiario Seguro 1',
              // hintText: 'Ingresa Parentesco Beneficiario Seguro 1',
              onChanged: (item) {
                if (item == null) return;
                parentescoBeneficiarioSeguro1 = item.value;
              },
            ),
            const Gap(20),
            CountryInput(
              onCountryCodeChange: (value) {
                if (value == null) return;
                telefonoBeneficiarioCode = value.dialCode!;
              },
              isRequired: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DashFormatter(),
              ],
              maxLength: 16,
              icon: Icon(
                Icons.phone,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Telefono Beneficiario',
              textInputType: TextInputType.phone,
              hintText: 'Ingresa Telefono Beneficiario',
              isValid: null,
              onChange: (value) {
                telefonoBeneficiario = value;
              },
            ),
            const Gap(20),
            CountryInput(
              onCountryCodeChange: (value) {
                if (value == null) return;
                telefonoBeneficiario1Code = value.dialCode!;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DashFormatter(),
              ],
              isRequired: false,
              maxLength: 16,
              icon: Icon(
                Icons.phone,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Telefono Beneficiario 1',
              hintText: 'Ingresa Telefono Beneficiario 1',
              textInputType: TextInputType.phone,
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
                        objParentescoBeneficiarioSeguroId1Ver: parentesco?.name,
                        beneficiarioSeguro: beneficiarioSeguro,
                        cedulaBeneficiarioSeguro: cedulaBeneficiarioSeguro,
                        objParentescoBeneficiarioSeguroId: parentesco?.value,
                        beneficiarioSeguro1: beneficiarioSeguro1,
                        cedulaBeneficiarioSeguro1: cedulaBeneficiarioSeguro1,
                        objParentescoBeneficiarioSeguroId1:
                            parentescoBeneficiarioSeguro1,
                        telefonoBeneficiario: telefonoBeneficiario == null
                            ? ''
                            : telefonoBeneficiarioCode +
                                (telefonoBeneficiario ?? '')
                                    .trim()
                                    .replaceAll('-', ''),
                        telefonoBeneficiarioSeguro1:
                            telefonoBeneficiario1 == null
                                ? ''
                                : telefonoBeneficiario1Code +
                                    (telefonoBeneficiario1 ?? '')
                                        .trim()
                                        .replaceAll('-', ''),
                        isDone: !isConnected,
                      );
                  if (!isConnected) {
                    CustomAlertDialog(
                      context: context,
                      title:
                          'No tienes conexion a internet, La solicitud se a guardado de manera local',
                      onDone: () => context.pushReplacement('/solicitudes'),
                    ).showDialog(context, dialogType: DialogType.infoReverse);
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BlocProvider.value(
                        value: context.read<SolicitudNuevaMenorCubit>(),
                        child: SendingFormWidget(
                          solicitudId: context
                              .read<SolicitudNuevaMenorCubit>()
                              .state
                              .idLocalResponse,
                        ),
                      ),
                    ),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
