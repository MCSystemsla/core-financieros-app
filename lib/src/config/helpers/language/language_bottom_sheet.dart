import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future languageBottomSheet(BuildContext context, Widget child) async {
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
        builder: (ctx, state) {
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
                    await context
                        .read<LangCubit>()
                        .changeLanguage(context, 'es');

                    if (context.mounted) {
                      context.pushTransparentRoute(child);
                    }
                  },
                  trailing:
                      getLocaleMatchIcon(state.currentLang.languageCode, 'es'),
                ),
                ListTile(
                  title: const Text(
                    'English',
                  ),
                  subtitle: const Text('Change Language to English'),
                  leading: SvgPicture.asset(ImageAsset.homeLangENUrl),
                  onTap: () async {
                    await context
                        .read<LangCubit>()
                        .changeLanguage(context, 'en');

                    if (context.mounted) {
                      context.pushTransparentRoute(child);
                    }
                  },
                  trailing:
                      getLocaleMatchIcon(state.currentLang.languageCode, 'en'),
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
