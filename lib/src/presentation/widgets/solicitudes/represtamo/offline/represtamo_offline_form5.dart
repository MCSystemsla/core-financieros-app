// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/formatter/dash_formater.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/sending/represtamo_sending_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoOfflineForm5 extends StatefulWidget {
  final PageController controller;
  final ReprestamoResponsesLocalDb solicitud;
  const ReprestamoOfflineForm5(
      {super.key, required this.controller, required this.solicitud});

  @override
  State<ReprestamoOfflineForm5> createState() => _ReprestamoOfflineForm5State();
}

class _ReprestamoOfflineForm5State extends State<ReprestamoOfflineForm5>
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
  Item? sector;
  @override
  void initState() {
    final solicitud = widget.solicitud;
    sector = Item(
      name: solicitud.objSectorIdVer!,
      value: solicitud.objSectorId,
    );
    beneficiarioSeguro = solicitud.beneficiarioSeguro;
    cedulaBeneficiarioSeguro = solicitud.cedulaBeneficiarioSeguro;
    parentesco = Item(
      name: solicitud.objParentescoBeneficiarioSeguroIdVer!,
      value: solicitud.objParentescoBeneficiarioSeguroId,
    );
    telefonoBeneficiario = solicitud.telefonoBeneficiario;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            SearchDropdownWidget(
              hintText: sector?.name ?? 'Selecciona una opcion',
              codigo: 'SECTORECONOMICO',
              title: 'Sector',
              onChanged: (item) {
                if (item == null) return;
                sector = item;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: beneficiarioSeguro,
              maxLength: 50,
              icon: Icon(
                Icons.family_restroom,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Nombre Beneficiario Seguro',
              hintText: 'Ingresa Nombre Beneficiario Seguro',
              isValid: null,
              onChange: (value) {
                beneficiarioSeguro = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: cedulaBeneficiarioSeguro,
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
              hintText: parentesco?.name ?? 'Selecciona una opcion',
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
              initialValue: telefonoBeneficiario,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Enviar Solicitud',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

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
                        value: context.read<SolicitudReprestamoCubit>(),
                        child: ReprestamoSendingWidget(
                          solicitudId: context
                              .read<SolicitudReprestamoCubit>()
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

  @override
  bool get wantKeepAlive => true;
}
