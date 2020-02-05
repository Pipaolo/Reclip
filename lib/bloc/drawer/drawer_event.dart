part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();
}

class ShowDrawer extends DrawerEvent {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ShowDrawer({this.scaffoldKey});
  @override
  List<Object> get props => [scaffoldKey];
}
