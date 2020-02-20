part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class ShowHomePage extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class ShowVideoPage extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class ShowIllustrationPage extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class ShowLoginPage extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class ShowSignupPage extends NavigationEvent {
  final ReclipUser user;

  ShowSignupPage({@required this.user});
  @override
  List<Object> get props => [user];
}

class ShowBottomNavbarController extends NavigationEvent {
  @override
  List<Object> get props => [];
}
