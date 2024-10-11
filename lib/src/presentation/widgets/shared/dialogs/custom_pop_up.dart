import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

Future<dynamic> customPopUp({
  required BuildContext context,
  required Size size,
  required String title,
  String? subtitle,
  required DialogType dialogType,
  Widget? icon,
  bool? buttonAcept,
  String? textButtonAcept,
  Color? colorButtonAcept,
  Function()? onPressedAccept,
  bool? buttonCancel,
  Color? colorButtonCancel,
  String? textButtonCancel,
  Function()? onPressedCancel,
  bool? dismissOnTouchOutside = true,
}) {
  return AwesomeDialog(
    context: context,
    customHeader: icon,
    headerAnimationLoop: false,
    dismissOnTouchOutside: dismissOnTouchOutside!,
    animType: AnimType.scale,
    barrierColor: AppColors.getPrimaryColor().withOpacity(.1),
    dialogType: dialogType,
    body: Column(
      children: [
        const SizedBox(height: 40),
        subtitle != null
            ? SizedBox(
                width: size.width * .58,
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.grey,
                            fontSize: 16,
                          ),
                    ),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColors.getTerciaryColor(),
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                width: size.width * .58,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                ),
              ),
        const SizedBox(height: 40),
        buttonAcept != null && buttonCancel == null && buttonAcept
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomElevatedButton(
                  text: translate(textButtonAcept!),
                  color: colorButtonAcept!,
                  onPressed: onPressedAccept,
                ),
              )
            : Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomElevatedButton(
                      text: translate(textButtonCancel!),
                      color: colorButtonCancel!,
                      onPressed: onPressedCancel,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomElevatedButton(
                      text: translate(textButtonAcept!),
                      color: colorButtonAcept!,
                      onPressed: onPressedAccept,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
        const SizedBox(height: 30),
      ],
    ),
  ).show();
}
