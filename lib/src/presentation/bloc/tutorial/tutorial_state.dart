part of 'tutorial_cubit.dart';

sealed class TutorialState extends Equatable {
  const TutorialState();

  @override
  List<Object> get props => [];
}

final class TutorialInitial extends TutorialState {}

final class OnTutorialStateLoading extends TutorialState {}

final class OnTutorialStateError extends TutorialState {
  final String errorMsg;
  const OnTutorialStateError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

final class OnTutorialStateSuccess extends TutorialState {
  final TutorialResponse tutorialResponse;

  const OnTutorialStateSuccess({
    required this.tutorialResponse,
  });
  @override
  List<Object> get props => [tutorialResponse];
}
