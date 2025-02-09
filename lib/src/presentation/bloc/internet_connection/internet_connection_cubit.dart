import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:network_info_plus/network_info_plus.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial());

  Future<void> getInternetStatusConnection() async {
    final isConnected = await InternetConnectionChecker().hasConnection;
    final connectivityResult = await Connectivity().checkConnectivity();
    final info = NetworkInfo();

    if (isConnected) {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.vpn)) {
        final wifiIp = await info.getWifiIP();
        log(wifiIp.toString());

        if (wifiIp != null &&
            (wifiIp.startsWith('172.17.5.') ||
                wifiIp.startsWith('10.212.134.') ||
                wifiIp.startsWith('172.16'))) {
          emit(state.copyWith(
              isConnected: true, isCorrectNetwork: true, currentIp: wifiIp));
        } else {
          emit(state.copyWith(
              isConnected: true, isCorrectNetwork: false, currentIp: wifiIp));
        }
        return;
      }
    }

    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(state.copyWith(isConnected: false, isCorrectNetwork: false));
    }
  }
}
