part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();
}

class ConnectivityInitial extends ConnectivityState {
  @override
  List<Object> get props => [];
}

class ConnectivityHasInternet extends ConnectivityState {
  @override
  List<Object> get props => [];
}

class ConnectivityHasNoInternet extends ConnectivityState {
  @override
  List<Object> get props => [];
}
