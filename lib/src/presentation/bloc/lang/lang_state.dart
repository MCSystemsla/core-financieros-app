// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'lang_cubit.dart';

class LangState extends Equatable {
  LangState({
    required this.currentLang,
  });
  String currentLang;

  LangState copyWith({
    String? currentLang,
  }) {
    return LangState(
      currentLang: currentLang ?? this.currentLang,
    );
  }

  @override
  List<Object> get props => [currentLang];
}

// final class LangInitial extends LangState {}
