import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(InternetConnectionInitial()) {
    getInternetStatusConnection();
  }

  Future getInternetStatusConnection() async {
    // final isConnected = await InternetConnectionChecker().hasConnection;
    // emit(state.copyWith(isConnected: isConnected));
  }
}
