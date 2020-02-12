part of 'illustrations_bloc.dart';

abstract class IllustrationsState extends Equatable {
  const IllustrationsState();
}

class IllustrationsInitial extends IllustrationsState {
  @override
  List<Object> get props => [];
}

class IllustrationsLoading extends IllustrationsState {
  @override
  List<Object> get props => [];
}

class IllustrationsSuccess extends IllustrationsState {
  final List<Illustration> illustrations;

  IllustrationsSuccess({this.illustrations});
  @override
  List<Object> get props => [illustrations];
}

class IllustrationsError extends IllustrationsState {
  final String errorText;

  IllustrationsError({this.errorText});

  @override
  List<Object> get props => [errorText];
}
