part of 'illustrations_bloc.dart';

abstract class IllustrationsEvent extends Equatable {
  const IllustrationsEvent();
}

class FetchIllustrations extends IllustrationsEvent {
  @override
  List<Object> get props => [];
}
