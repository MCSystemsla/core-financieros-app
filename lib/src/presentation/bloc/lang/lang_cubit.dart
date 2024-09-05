import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit({required Locale currentLang})
      : super(LangState(currentLang: currentLang));

  changeLanguage(BuildContext context, String language) async {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    await localizationDelegate.changeLocale(Locale(language, ''));
    await LocalStorage().setLanguage(language);
    emit(
      state.copyWith(currentLang: Locale(language)),
    );
  }
}
