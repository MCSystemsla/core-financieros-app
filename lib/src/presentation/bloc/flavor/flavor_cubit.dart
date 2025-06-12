import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:equatable/equatable.dart';

part 'flavor_state.dart';

class FlavorCubit extends Cubit<FlavorState> {
  FlavorCubit() : super(FlavorInitial());

  void setFlavor(Flavor flavor) {
    emit(state.copyWith(flavor: flavor));
  }
}
