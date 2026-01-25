// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/user_cedula/user_by_cedula_solicitud.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/represtamo_user_by_cedula/represta_user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/add_user_cedula_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ReprestamoAddUserCedulaScreen extends StatelessWidget {
  final TypeForm typeForm;
  const ReprestamoAddUserCedulaScreen({super.key, required this.typeForm});

  @override
  Widget build(BuildContext context) {
    void showSuccessDialog({
      required String id,
      required String nombreCompleto,
      required String cedula,
      required String tipoDocumento,
      required String tipoPersona,
      required String paisEmisorDocumento,
      required String fechaVencimientoDocumento,
      required String fechaEmisionDocumento,
    }) {
      CustomAlertDialog(
        context: context,
        title: '$nombreCompleto listo para crear solicitud!!',
        onDone: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((_) => CrearSolicitudScreenNi(
                    typeForm: typeForm,
                    userByCedulaSolicitud: UserByCedulaSolicitud(
                      cedula: cedula,
                      primerNombre: nombreCompleto,
                      segundoApellido: nombreCompleto,
                      tipoDocumento: tipoDocumento,
                      tipoPersona: tipoPersona,
                      fechaEmision: DateTime.tryParse(fechaEmisionDocumento),
                      fechaVencimiento:
                          DateTime.tryParse(fechaVencimientoDocumento),
                      paisEmisor: Item(
                        name: paisEmisorDocumento,
                        value: paisEmisorDocumento,
                      ),
                    ),
                  )),
            ),
          );
        },
      ).showDialog(context, dialogType: DialogType.success);
    }

    void showErrorDialog({required String errorMsg}) {
      AddUserCedulaDialog(
        typeForm: typeForm,
        context: context,
        title: errorMsg,
      ).showDialog(context, dialogType: DialogType.warning);
    }

    return BlocProvider(
      create: (ctx) => ReprestaUserByCedulaCubit(
        SolicitudCreditoRepositoryImpl(),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightGray,
        ),
        body:
            BlocConsumer<ReprestaUserByCedulaCubit, ReprestaUserByCedulaState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              showErrorDialog(errorMsg: state.errorMsg);
            }
            if (state.status == Status.done) {
              showSuccessDialog(
                nombreCompleto: state.nombreCompleto,
                cedula: state.cedula,
                tipoDocumento: state.tipoDocumento,
                tipoPersona: state.tipoPersona,
                paisEmisorDocumento: state.paisEmisorDocumento,
                fechaEmisionDocumento: state.fechaEmisionDocumento,
                fechaVencimientoDocumento: state.fechaVencimientoDocumento,
                id: state.id,
              );
            }
          },
          builder: (context, state) {
            return _ReprestamoAddUserWidget(state: state);
          },
        ),
      ),
    );
  }
}

class _ReprestamoAddUserWidget extends StatelessWidget {
  final ReprestaUserByCedulaState state;
  final formKey = GlobalKey<FormState>();
  final cedulaController = TextEditingController();

  _ReprestamoAddUserWidget({
    required this.state,
  });

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
                  'Ingresar Usuario a solicitar Solicitud de Credito Represtamo',
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
                OutlineTextfieldWidget(
                  maxLength: 20,
                  textEditingController: cedulaController,
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: Icon(
                    Icons.credit_card_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: '',
                  hintText: 'Ingresa Cedula, Pasaporte o DNI',
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    enabled: state.status != Status.inProgress,
                    text: state.status == Status.inProgress
                        ? 'Cargando...'
                        : 'Enviar',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      context
                          .read<ReprestaUserByCedulaCubit>()
                          .getUserReprestamoByCedula(
                            cedula: cedulaController.text.trim(),
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
