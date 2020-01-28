import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/ui/custom_drawer.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  NavigationBloc navigationBloc;
  @override
  void initState() {
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY PROFILE'),
        backgroundColor: yellowOrange,
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        navigationBloc: navigationBloc,
      ),
      body: Center(
        child: Text('MY PROFILE!'),
      ),
    );
  }
}
