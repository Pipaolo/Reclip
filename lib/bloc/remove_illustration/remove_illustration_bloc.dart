import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/repository/illustration_repository.dart';

part 'remove_illustration_event.dart';
part 'remove_illustration_state.dart';

class RemoveIllustrationBloc
    extends Bloc<RemoveIllustrationEvent, RemoveIllustrationState> {
  final IllustrationRepository illustrationRepository;

  RemoveIllustrationBloc({this.illustrationRepository});
  @override
  RemoveIllustrationState get initialState => RemoveIllustrationInitial();

  @override
  Stream<RemoveIllustrationState> mapEventToState(
    RemoveIllustrationEvent event,
  ) async* {
    if (event is IllustrationRemoved) {
      try {
        yield RemoveIllustrationLoading();
        await illustrationRepository.removeIllustration(event.illustration);
        yield RemoveIllustrationSuccess();
      } catch (e) {
        yield RemoveIllustrationError(errorText: e.toString());
      }
    }
  }
}
