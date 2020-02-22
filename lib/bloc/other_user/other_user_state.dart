part of 'other_user_bloc.dart';

abstract class OtherUserState extends Equatable {
  const OtherUserState();
}

class OtherUserInitial extends OtherUserState {
  @override
  List<Object> get props => [];
}

class OtherUserLoading extends OtherUserState {
  @override
  List<Object> get props => [];
}

class OtherUserError extends OtherUserState {
  final String errorText;

  OtherUserError({this.errorText});

  @override
  List<Object> get props => [errorText];
}

class OtherUserSuccess extends OtherUserState {
  final ReclipContentCreator user;

  OtherUserSuccess({this.user});

  @override
  List<Object> get props => [user];
}
