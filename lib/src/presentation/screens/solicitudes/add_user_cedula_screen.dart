import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/add_user_cedula_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AddUserCedulaScreen extends StatelessWidget {
  final TypeForm typeForm;
  const AddUserCedulaScreen({super.key, required this.typeForm});

  @override
  Widget build(BuildContext context) {
    final cedulaController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    void showSuccessDialog({
      required String firstName,
      required String lastName,
    }) {
      CustomAlertDialog(
        context: context,
        title: '$firstName $lastName listo para crear solicitud!!',
        onDone: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => CrearSolicitudScreen(typeForm: typeForm)),
          ),
        ),
      ).showDialog(context, dialogType: DialogType.success);
    }

    void showErrorDialog({required String errorMsg}) {
      AddUserCedulaDialog(
        context: context,
        title: errorMsg,
        typeForm: typeForm,
        onDone: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => CrearSolicitudScreen(typeForm: typeForm)),
          ),
        ),
      ).showDialog(context, dialogType: DialogType.warning);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGray,
      ),
      body: BlocConsumer<UserByCedulaCubit, UserByCedulaState>(
        listener: (context, state) {
          if (state is OnUserByCedulaError) {
            showErrorDialog(errorMsg: state.errorMsg);
          }
          if (state is OnUserByCedulaSuccess) {
            showSuccessDialog(
              firstName: state.userCedulaResponse.primerNombre,
              lastName: state.userCedulaResponse.primerApellido,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
                      OutlineTextfieldWidget(
                        maxLength: 20,
                        textEditingController: cedulaController,
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
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
                          enabled: state is! OnUserByCedulaLoading,
                          text: state is OnUserByCedulaLoading
                              ? 'Cargando...'
                              : 'Enviar',
                          color: AppColors.greenLatern.withOpacity(0.4),
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            context.read<UserByCedulaCubit>().getUserByCedula(
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
        },
      ),
    );
  }
}
