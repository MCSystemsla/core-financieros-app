import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/auth/login/login_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/ods_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';

class NoVpnPopUpOnKiva extends OdsDialog {
  final BuildContext context;
  final String info;
  final String header;
  final bool isVpnConnected;
  const NoVpnPopUpOnKiva({
    super.key,
    required this.context,
    required this.info,
    required this.header,
    required this.isVpnConnected,
  }) : super(
          title: header,
          subtitle: info,
        );

  @override
  List<CustomElevatedButton>? actions(BuildContext context) {
    return [
      CustomElevatedButton(
        text: 'OK',
        color: AppColors.getPrimaryColor(),
        onPressed: () {
          isVpnConnected
              ? context.pushReplacement('/')
              : context.pushTransparentRoute(
                  const VpnNoFound(routeIsVpnConnected: '/'),
                );
        },
      ),
    ];
  }
}
