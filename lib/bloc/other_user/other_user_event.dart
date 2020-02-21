part of 'other_user_bloc.dart';

abstract class OtherUserEvent extends Equatable {
  const OtherUserEvent();
}

class GetOtherUser extends OtherUserEvent {
  final String email;

  GetOtherUser({this.email});

  @override
  List<Object> get props => [email];
}
