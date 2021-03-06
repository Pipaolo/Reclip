part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
}

class ConnectivityConfigured extends ConnectivityEvent {
  @override
  List<Object> get props => [];
}

class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult result;

  ConnectivityChanged({this.result});
  @override
  List<Object> get props => [result];
}
