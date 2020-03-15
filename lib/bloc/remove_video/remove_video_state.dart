part of 'remove_video_bloc.dart';

abstract class RemoveVideoState extends Equatable {
  const RemoveVideoState();
}

class RemoveVideoInitial extends RemoveVideoState {
  @override
  List<Object> get props => [];
}

class RemoveVideoLoading extends RemoveVideoState {
  @override
  List<Object> get props => [];
}

class RemoveVideoSuccess extends RemoveVideoState {
  @override
  List<Object> get props => [];
}

class RemoveVideoError extends RemoveVideoState {
  final String errorText;
  RemoveVideoError({
    this.errorText,
  });
  @override
  List<Object> get props => [errorText];
}
