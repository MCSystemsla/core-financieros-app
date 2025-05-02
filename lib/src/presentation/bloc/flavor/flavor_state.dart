// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'flavor_cubit.dart';

class FlavorState extends Equatable {
  final Flavor flavor;
  const FlavorState({this.flavor = Flavor.unknown});

  @override
  List<Object> get props => [flavor];

  FlavorState copyWith({
    Flavor? flavor,
  }) {
    return FlavorState(
      flavor: flavor ?? this.flavor,
    );
  }
}

final class FlavorInitial extends FlavorState {}
