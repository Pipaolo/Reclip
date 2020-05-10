import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/bloc/add_video/add_video_bloc.dart';
import 'package:meta/meta.dart';
import 'package:reclip/model/illustration.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/video.dart';
import 'package:reclip/repository/illustration_repository.dart';
import 'package:reclip/repository/video_repository.dart';

part 'add_content_event.dart';
part 'add_content_state.dart';

class AddContentBloc extends Bloc<AddContentEvent, AddContentState> {
  final IllustrationRepository illustrationRepository;
  final VideoRepository videoRepository;
  final AddVideoBloc addVideoBloc;
  StreamSubscription addVideoSubscription;

  String thumbnailUrl;
  String videoUrl;

  AddContentBloc(
      {@required this.illustrationRepository,
      @required this.videoRepository,
      this.addVideoBloc});
  @override
  AddContentState get initialState => AddContentInitial();

  @override
  Stream<AddContentState> mapEventToState(
    AddContentEvent event,
  ) async* {
    if (event is AddIllustration) {
      try {
        yield UploadingImage();
        final illustration = await illustrationRepository.addImage(
            event.user, event.illustration, event.image);
        await illustrationRepository.addIllustration(illustration);
        yield UploadImageSuccess();
      } catch (e) {
        yield UploadImageError(
          errorText: e.toString(),
        );
      }
    } else if (event is VideoAdded) {
      yield UploadingVideo();
      try {
        if (!event.isAdded) {
          final thumbnailStream = await videoRepository.uploadThumbnail(
              event.contentCreator,
              event.video,
              event.rawVideo,
              event.thumbnail);

          await for (var storageEvent in thumbnailStream) {
            final int progress = ((storageEvent.snapshot.bytesTransferred /
                        storageEvent.snapshot.totalByteCount) *
                    100)
                .round();

            addVideoBloc.add(
              ShowedThumbnailUploadProgress(
                uploadProgress: progress,
              ),
            );
            if (progress == 100) {
              thumbnailUrl = await storageEvent.snapshot.ref.getDownloadURL();
              break;
            }
          }
          final videoStream = await videoRepository.uploadVideo(
              event.contentCreator,
              event.video,
              event.rawVideo,
              event.thumbnail);

          await for (var storageEvent in videoStream) {
            final int progress = ((storageEvent.snapshot.bytesTransferred /
                        storageEvent.snapshot.totalByteCount) *
                    100)
                .round();
            addVideoBloc.add(
              ShowedVideoUploadProgress(
                uploadProgress: progress,
              ),
            );
            if (progress == 100) {
              videoUrl = await storageEvent.snapshot.ref.getDownloadURL();
              break;
            }
          }
          final video = await videoRepository.addVideo(
            event.contentCreator,
            event.video.copyWith(
              videoUrl: videoUrl,
              thumbnailUrl: thumbnailUrl,
            ),
          );
          yield UploadVideoSuccess(video: video);
        } else {
          print(event.video);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Future<void> close() {
    addVideoSubscription.cancel();
    return super.close();
  }
}
