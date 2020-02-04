import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/custom_drawer.dart';
import 'package:sailor/sailor.dart';

class UserAddContentPageArgs extends BaseArguments {
  final ReclipUser user;

  UserAddContentPageArgs({@required this.user});
}

class UserAddContentPage extends StatefulWidget {
  final UserAddContentPageArgs args;
  const UserAddContentPage({Key key, this.args}) : super(key: key);

  @override
  _UserAddContentPageState createState() => _UserAddContentPageState();
}

class _UserAddContentPageState extends State<UserAddContentPage> {
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
        title: Text('ADD CONTENT'),
        backgroundColor: royalOrange,
        centerTitle: true,
      ),
      drawer: CustomDrawer(navigationBloc: navigationBloc),
      body: Center(
        child: Text('ADD CONTENT!'),
      ),
    );
  }
}
