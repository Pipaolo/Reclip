import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_event.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(
    BottomNavigationEvent event,
  ) async* {
    if (event is NavigationItemPressed) {
      yield event.index;
    }
  }
}
