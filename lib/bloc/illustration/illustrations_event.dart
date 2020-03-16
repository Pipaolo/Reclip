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
