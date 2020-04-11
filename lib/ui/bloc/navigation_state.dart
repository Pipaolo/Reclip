part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
}

class HomePageState extends NavigationState {
  @override
  List<Object> get props => [];
}

class VideoPageState extends NavigationState {
  final int index = 0;
  @override
  List<Object> get props => [index];
}

class IllustrationPageState extends NavigationState {
  final int index = 1;
  @override
  List<Object> get props => [index];
}
