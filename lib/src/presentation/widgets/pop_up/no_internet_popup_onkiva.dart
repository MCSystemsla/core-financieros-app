import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';

class NoInternetPopUpOnKiva extends OdsDialog {
  final BuildContext context;
  final String? info;
  final String header;
  const NoInternetPopUpOnKiva({
    super.key,
    required this.context,
    this.info,
    required this.header,
  }) : super(
          title: header,
          subtitle:
              'No tienes conexion a internet, El Formulario se ha guardado localmente.',
        );

  @override
  List<CustomElevatedButton>? actions(BuildContext context) {
    return [
      CustomElevatedButton(
        text: 'OK',
        color: AppColors.getPrimaryColor(),
        onPressed: () {
          context.push('/');
        },
      ),
    ];
  }
}
