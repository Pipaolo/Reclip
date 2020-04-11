import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_video_event.dart';
part 'add_video_state.dart';

class AddVideoBloc extends Bloc<AddVideoEvent, AddVideoState> {
  @override
  AddVideoState get initialState => AddVideoInitial();

  @override
  Stream<AddVideoState> mapEventToState(
    AddVideoEvent event,
  ) async* {
    if (event is ShowedThumbnailUploadProgress) {
      yield AddVideoThumbnailProgressState(
        uploadProgress: event.uploadProgress,
      );
    } else if (event is ShowedVideoUploadProgress) {
      yield AddVideoProgressState(
        uploadProgress: event.uploadProgress,
      );
    } else if (event is AddVideoResetted) {
      yield AddVideoInitial();
    }
  }
}
