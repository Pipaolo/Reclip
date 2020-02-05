part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();
}

class NotVisible extends DrawerState {
  @override
  List<Object> get props => [];
}

class Visible extends DrawerState {
  @override
  List<Object> get props => [];
}
