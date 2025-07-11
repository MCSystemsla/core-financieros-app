// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_by_cedula_solicitud.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddUserCedulaScreen extends StatelessWidget {
  final TypeForm typeForm;
  const AddUserCedulaScreen({super.key, required this.typeForm});

  @override
  Widget build(BuildContext context) {
    void showSuccessDialog({
      required UserByCedulaSolicitud userByCedula,
      required bool isNewUserCedula,
    }) {
      if (isNewUserCedula) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((_) => CrearSolicitudScreen(
                  typeForm: typeForm,
                  userByCedulaSolicitud: userByCedula,
                )),
          ),
        );
        return;
      }
      CustomAlertDialog(
        context: context,
        title:
            '${userByCedula.primerNombre} ${userByCedula.primerApellido} listo para crear solicitud!!',
        onDone: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => CrearSolicitudScreen(
                  typeForm: typeForm,
                  userByCedulaSolicitud: userByCedula,
                )),
          ),
        ),
      ).showDialog(context, dialogType: DialogType.success);
    }

    void showErrorDialog({
      required String errorMsg,
      required UserByCedulaSolicitud userByCedula,
    }) {
      CustomAlertDialog(
        context: context,
        title: errorMsg,
        onDone: () {
          if (errorMsg.contains('Sin conexión a internet')) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: ((context) => CrearSolicitudScreen(
                      typeForm: typeForm,
                      userByCedulaSolicitud: userByCedula,
                    )),
              ),
            );
            return;
          }
          context.pop();
        },
      ).showDialog(context);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGray,
      ),
      body: BlocConsumer<UserByCedulaCubit, UserByCedulaState>(
        listener: (context, state) {
          if (state is OnUserByCedulaError) {
            showErrorDialog(
              errorMsg: state.errorMsg,
              userByCedula: state.userByCedula,
            );
          }
          if (state is OnUserByCedulaSuccess) {
            showSuccessDialog(
              isNewUserCedula: state.isNewUserCedula,
              userByCedula: state.userByCedula,
            );
          }
        },
        builder: (context, state) {
          return _UserCedulaForm(
            state: state,
            typeForm: typeForm,
          );
        },
      ),
    );
  }
}

class _UserCedulaForm extends StatefulWidget {
  final UserByCedulaState state;
  final TypeForm typeForm;
  const _UserCedulaForm({
    required this.state,
    required this.typeForm,
  });

  @override
  State<_UserCedulaForm> createState() => _UserCedulaFormState();
}

class _UserCedulaFormState extends State<_UserCedulaForm> {
  Item? tipoDocumento;
  Item? paisEmisorDocumento;
  final formKey = GlobalKey<FormState>();

  final cedulaController = TextEditingController();

  int determineDocumentoLength({
    String? tipoDocumento,
    String? paisEmisor,
  }) {
    return switch ((tipoDocumento, paisEmisor)) {
      ('CEDULAIDENTIDAD', 'HON') => 13,
      ('CEDULAIDENTIDAD', 'NIC') => 14,
      ('PASAPORTE', 'NIC') => 9,
      ('PASAPORTE', 'HON') => 7,
      ('RTN', 'HON') => 14,
      ('CARNETRESIDENCIA', 'HON') => 8,
      _ => 0
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  height: 200,
                  ImageAsset.nuevaAddDni,
                ),
                const Gap(30),
                Text(
                  'Ingresar Usuario a solicitar Solicitud de Credito',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                Text(
                  'Ingresa los datos requeridos',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                CatalogoValorNacionalidad(
                  hintText: 'input.select_option'.tr(),
                  // hintText: state.userCedulaResponse.pais,
                  title: 'País Emisor',
                  validator: (value) =>
                      ClassValidator.validateRequired(value.valor),
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    paisEmisorDocumento = Item(
                      name: item.nombre,
                      value: item.valor,
                    );
                    log(item.valor);

                    setState(() {});
                  },
                  codigo: 'PAIS',
                ),
                const Gap(20),
                SearchDropdownWidget(
                  hintText: 'input.select_option'.tr(),
                  codigo: 'TIPODOCUMENTOPERSONA',
                  onChanged: (item) {
                    tipoDocumento = item;
                    log(item?.value);
                    setState(() {});
                  },
                  title: 'Tipo Documento',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                ),
                const Gap(20),
                if (tipoDocumento != null && paisEmisorDocumento != null) ...[
                  const Gap(20),
                  OutlineTextfieldWidget(
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    textEditingController: cedulaController,
                    validator: (value) =>
                        ClassValidator.validateMaxIntValueAndMinValue(
                      value,
                      determineDocumentoLength(
                        tipoDocumento: tipoDocumento?.value ?? '',
                        paisEmisor: paisEmisorDocumento?.value ?? '',
                      ),
                      isNicaraguaCedula: paisEmisorDocumento?.value == 'NIC' &&
                          tipoDocumento?.value == 'CEDULAIDENTIDAD',
                    ),
                    icon: Icon(
                      Icons.credit_card_outlined,
                      color: AppColors.getPrimaryColor(),
                    ),
                    title: '',
                    hintText: 'Ingresa Documento',
                  ),
                ],
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    enabled: widget.state is! OnUserByCedulaLoading,
                    text: widget.state is OnUserByCedulaLoading
                        ? 'Cargando...'
                        : 'Enviar',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      context.read<UserByCedulaCubit>().getUserByCedula(
                            typeForm: widget.typeForm,
                            cedula: cedulaController.text.trim(),
                            tipoDocumento: tipoDocumento!,
                            paisEmisor: paisEmisorDocumento!,
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
