import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  @override
  DrawerState get initialState => NotVisible();

  @override
  Stream<DrawerState> mapEventToState(
    DrawerEvent event,
  ) async* {
    if (event is ShowDrawer) {
      showNavigationDrawer(event.scaffoldKey);
      yield Visible();
    }
  }

  showNavigationDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.openDrawer();
  }
}
