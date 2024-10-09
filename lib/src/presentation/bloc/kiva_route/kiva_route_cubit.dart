import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kiva_route_state.dart';

class KivaRouteCubit extends Cubit<KivaRouteState> {
  KivaRouteCubit() : super(KivaRouteInitial());

  void setCurrentRouteProduct(String route) {
    emit(state.copyWith(currentRoute: route));
  }
}
