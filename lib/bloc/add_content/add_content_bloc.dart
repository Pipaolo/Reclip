import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:meta/meta.dart';

part 'add_content_event.dart';
part 'add_content_state.dart';

class AddContentBloc extends Bloc<AddContentEvent, AddContentState> {
  final FirebaseReclipRepository reclipRepository;

  AddContentBloc({@required this.reclipRepository});
  @override
  AddContentState get initialState => AddContentInitial();

  @override
  Stream<AddContentState> mapEventToState(
    AddContentEvent event,
  ) async* {
    if (event is AddIllustration) {
      try {
        yield Uploading();
        final isIllustrationExisting =
            await reclipRepository.isIllustrationExist(event.illustration);
        if (isIllustrationExisting) {
          yield UploadImageDuplicate();
        } else {
          final illustration = await reclipRepository.addImage(
              event.user, event.illustration, event.image);
          await reclipRepository.addIllustration(illustration);
          yield UploadImageSuccess();
        }
      } catch (e) {
        yield UploadImageError(
          errorText: e.toString(),
        );
      }
    }
  }
}
