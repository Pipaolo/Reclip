part of 'remove_illustration_bloc.dart';

abstract class RemoveIllustrationEvent extends Equatable {
  const RemoveIllustrationEvent();
}

class IllustrationRemoved extends RemoveIllustrationEvent {
  final Illustration illustration;
  IllustrationRemoved({
    this.illustration,
  });
  @override
  List<Object> get props => [illustration];
}
