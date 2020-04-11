part of 'reclipuser_bloc.dart';

abstract class ReclipUserState extends Equatable {
  const ReclipUserState();
}

class ReclipuserInitial extends ReclipUserState {
  @override
  List<Object> get props => [];
}

class ReclipUserLoading extends ReclipUserState {
  @override
  List<Object> get props => [];
}

class ReclipUserSuccess extends ReclipUserState {
  final List<Video> videos;

  ReclipUserSuccess({this.videos});
  @override
  List<Object> get props => [videos];
}

class ReclipUserError extends ReclipUserState {
  final String errorText;

  ReclipUserError({this.errorText});

  @override
  List<Object> get props => [errorText];
}
