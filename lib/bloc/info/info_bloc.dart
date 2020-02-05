import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  @override
  InfoState get initialState => InfoInitial();

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
