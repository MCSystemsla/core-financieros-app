part of 'no_images_kivas_on_history_cubit.dart';

sealed class NoImagesKivasOnHistoryState extends Equatable {
  const NoImagesKivasOnHistoryState();

  @override
  List<Object> get props => [];
}

final class NoImagesKivasOnHistoryInitial extends NoImagesKivasOnHistoryState {}

final class OnNoImagesKivasOnHistoryError extends NoImagesKivasOnHistoryState {
  final String errorMsg;

  const OnNoImagesKivasOnHistoryError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class OnNoImagesKivasOnHistoryHaveRequestPending
    extends NoImagesKivasOnHistoryState {
  final KivaRequestNotSavedResponse data;

  const OnNoImagesKivasOnHistoryHaveRequestPending({
    required this.data,
  });
  @override
  List<Object> get props => [data];
}

final class OnNoImagesKivasOnHistoryNoHaveRequestPending
    extends NoImagesKivasOnHistoryState {}
