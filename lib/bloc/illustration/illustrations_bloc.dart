import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/firebase_reclip_repository.dart';

part 'illustrations_event.dart';
part 'illustrations_state.dart';

class IllustrationsBloc extends Bloc<IllustrationsEvent, IllustrationsState> {
  final FirebaseReclipRepository reclipRepository;

  IllustrationsBloc({this.reclipRepository});
  @override
  IllustrationsState get initialState => IllustrationsInitial();

  @override
  Stream<IllustrationsState> mapEventToState(
    IllustrationsEvent event,
  ) async* {
    if (event is FetchIllustrations) {}
  }
}
