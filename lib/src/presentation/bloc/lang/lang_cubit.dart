import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit({required String currentLang})
      : super(LangState(currentLang: currentLang));

  Future<void> changeLanguage(BuildContext context, String language) async {
    LocalizedApp.of(context).delegate.changeLocale(
          Locale(language, ''),
        );
    emit(
      state.copyWith(currentLang: language),
    );
    await changeLocale(context, language);
    await LocalStorage().setLanguage(state.currentLang);
  }

  String get currentLanguage => state.currentLang;
}
