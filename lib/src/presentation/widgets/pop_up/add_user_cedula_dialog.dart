import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddUserCedulaDialog extends OdsDialog {
  @override
  // ignore: overridden_fields
  final String title;
  final TypeForm typeForm;
  final String? cedula;
  const AddUserCedulaDialog({
    super.key,
    required this.context,
    required this.title,
    required this.typeForm,
    this.cedula,
  }) : super(
          title: title,
        );

  final BuildContext context;

  @override
  List<CustomElevatedButton>? actions(BuildContext context) {
    return [
      if (typeForm == TypeForm.nueva || typeForm == TypeForm.asalariado)
        CustomElevatedButton(
          text: 'Ir a Formulario'.tr(),
          color: AppColors.getPrimaryColor(),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: ((_) => CrearSolicitudScreen(
                      typeForm: typeForm,
                    )),
              ),
            );
          },
        ),
      CustomElevatedButton(
        text: 'Regresar'.tr(),
        color: AppColors.red,
        onPressed: () => context.pop(),
      ),
    ];
  }

  @override
  Future showDialog(
    BuildContext context, {
    AnimType animType = AnimType.scale,
    DialogType dialogType = DialogType.warning,
    Widget? customHeader,
  }) {
    return super.showDialog(
      context,
      animType: animType,
      dialogType: dialogType,
    );
  }
}
