part of 'autoupdate_cubit.dart';

sealed class AutoupdateState extends Equatable {
  const AutoupdateState();

  @override
  List<Object> get props => [];
}

final class AutoupdateInitial extends AutoupdateState {}

final class AutoupdateLoading extends AutoupdateState {}

final class AutoupdateSuccess extends AutoupdateState {
  final String apkVersion;
  final String apkVersionName;

  const AutoupdateSuccess({
    required this.apkVersion,
    required this.apkVersionName,
  });
}

final class AutoupdateError extends AutoupdateState {}
