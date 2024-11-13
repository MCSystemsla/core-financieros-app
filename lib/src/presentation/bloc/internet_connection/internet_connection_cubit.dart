// ignore_for_file: unrelated_type_equality_checks, prefer_single_quotes

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());

  Future<void> getInternetStatusConnection() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    // emit(state.copyWith(isConnected: isConnected));

    if (isConnected) {
      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        emit(state.copyWith(isConnected: true));
        return;
      }
      if (connectivityResult.contains(ConnectivityResult.wifi)) {
        emit(state.copyWith(isConnected: true));
        return;
      }
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(state.copyWith(isConnected: false));
        return;
      }
    }
  }
}
