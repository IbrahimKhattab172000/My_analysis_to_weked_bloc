import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:startup_app/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscripition;

  ///Constructor with body yasta
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    ///Don't forget the return =>
    return connectivityStreamSubscripition =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      /// {ConnectivityResult.mobile} here isn't my enum it's their
      if (connectivityResult == ConnectivityResult.wifi) {
        ///{ConnectionType.Wifi} here is my enum
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectivityType) =>
      emit(InternetConnected(connectionType: _connectivityType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscripition!.cancel();
    return super.close();
  }
}
