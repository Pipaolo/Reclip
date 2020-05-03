part of 'illustrations_bloc.dart';

abstract class IllustrationsEvent extends Equatable {
  const IllustrationsEvent();
}

class IllustrationFetched extends IllustrationsEvent {
  @override
  List<Object> get props => [];
}

class ShowIllustrations extends IllustrationsEvent {
  final List<Illustration> illustrations;

  ShowIllustrations({this.illustrations});
  @override
  List<Object> get props => [illustrations];
}

class IllustrationLikeAdded extends IllustrationsEvent {
  final String email;
  final Illustration illustration;

  IllustrationLikeAdded({
    @required this.email,
    @required this.illustration,
  });

  @override
  List<Object> get props => [illustration, email];
}

class IllustrationLikeRemoved extends IllustrationsEvent {
  final Illustration illustration;
  final String email;
  IllustrationLikeRemoved({
    @required this.illustration,
    @required this.email,
  });

  @override
  List<Object> get props => [illustration, email];
}
