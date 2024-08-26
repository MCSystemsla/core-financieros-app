import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/widgets/lang/change_lang_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/input_simple.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF1F1F1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChangeLangWidget(route: '/login'),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image(
                    image: AssetImage(ImageAsset.logo),
                  ),
                ),
              ),
              // const Gap(10),
              Expanded(
                flex: 5,
                child: LoginFormWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputSimple(
          title: 'auth.user'.tr(),
          activeColor: true,
          hintText: 'Ejem: John Doe',
          enabled: true,
          onChanged: (p0) {},
          textFieldSettings: const TextFieldSettings(
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        // const Gap(25),
        InputSimple(
          title: 'auth.password'.tr(),
          activeColor: true,
          hintText: '****',
          isPasswordField: true,
          enabled: true,
          onChanged: (p0) {},
        ),
        const Gap(25),
        JLuxDropdown(
          isContainIcon: true,
          title: 'auth.branch'.tr(),
          items: const ['ITEM', 'ITEM2', 'ITEM3'],
          onChanged: (item) {},
          toStringItem: (item) {
            return item;
          },
          hintText: 'auth.select_branch'.tr(),
        ),
        const Gap(30),
        CustomElevatedButton(
          text: 'button.login'.tr(),
          color: Colors.black,
          onPressed: () {},
        )
      ],
    );
  }
}
