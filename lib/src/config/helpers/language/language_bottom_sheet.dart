// ignore_for_file: avoid_returning_null_for_void

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/auth/login/login_screen.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future languageBottomSheet(BuildContext context, String route) async {
  return await showModalBottomSheet(
    context: context,
    barrierColor: Colors.black38,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    builder: (context) {
      return BlocBuilder<LangCubit, LangState>(
        builder: (context, state) {
          final langProvider = context.read<LangCubit>();
          return SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: const Text('Español'),
                  subtitle: const Text('Cambiar Idioma a Español'),
                  leading: SvgPicture.asset(ImageAsset.homeLangESUrl),
                  onTap: () async {
                    await langProvider.changeLanguage(context, 'es');
                    if (context.mounted) {
                      context.pushTransparentRoute(const LoginScreen());
                    }
                  },
                  trailing: getLocaleMatchIcon(state.currentLang, 'es'),
                ),
                ListTile(
                  title: const Text(
                    'English',
                  ),
                  subtitle: const Text('Change Language to English'),
                  leading: SvgPicture.asset(ImageAsset.homeLangENUrl),
                  onTap: () async {
                    await langProvider.changeLanguage(context, 'en');
                    if (context.mounted) {
                      context.pushTransparentRoute(const LoginScreen());
                    }
                  },
                  trailing: getLocaleMatchIcon(state.currentLang, 'en'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget getLocaleMatchIcon(String currentLanguage, String targetLocale) {
  if (currentLanguage != targetLocale) return const SizedBox();

  return const Icon(
    Icons.check_circle,
    color: AppColors.forestGreen,
  );
}
