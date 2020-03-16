import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  Connectivity connectivity;
  @override
  ConnectivityState get initialState => ConnectivityInitial();

  @override
  Stream<ConnectivityState> mapEventToState(
    ConnectivityEvent event,
  ) async* {
    if (event is ConnectivityConfigured) {
      connectivity = Connectivity();
      connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) async {
        add(ConnectivityChanged(result: result));
      });
    } else if (event is ConnectivityChanged) {
      switch (event.result) {
        case ConnectivityResult.wifi:
          yield ConnectivityHasInternet();
          break;
        case ConnectivityResult.mobile:
          yield ConnectivityHasInternet();
          break;
        case ConnectivityResult.none:
          yield ConnectivityHasNoInternet();
          break;
      }
    }
  }
}
