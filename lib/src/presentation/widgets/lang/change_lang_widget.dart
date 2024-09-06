import 'package:core_financiero_app/src/config/helpers/language/language_bottom_sheet.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChangeLangWidget extends StatelessWidget {
  final Color? color;
  final Widget child;
  const ChangeLangWidget({
    super.key,
    required this.child,
  }) : color = null;

  const ChangeLangWidget.withCustomColor({
    super.key,
    required this.color,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, LangState>(
      builder: (ctx, state) {
        return InkWell(
          onTap: () async => await languageBottomSheet(ctx, child),
          child: Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color ?? AppColors.boxGrey,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              width: 90,
              height: 90,
              currentLang(state.currentLang.languageCode),
            ),
          ),
        );
      },
    );
  }

  String currentLang(String lang) {
    switch (lang) {
      case 'es':
        return ImageAsset.homeLangESUrl;
      case 'en':
        return ImageAsset.homeLangENUrl;
    }
    return 'Not Language Recongnized';
  }
}
