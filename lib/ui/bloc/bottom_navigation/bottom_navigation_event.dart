part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();
}

class NavigationItemPressed extends BottomNavigationEvent {
  final int index;
  NavigationItemPressed({
    this.index,
  });
  @override
  List<Object> get props => [index];
}
