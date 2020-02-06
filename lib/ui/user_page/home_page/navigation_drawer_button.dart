import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/bloc/drawer/drawer_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';

class NavigationDrawerButton extends StatelessWidget {
  const NavigationDrawerButton({
    Key key,
    @required this.hideNavDrawerAnimController,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final AnimationController hideNavDrawerAnimController;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 20,
      child: FadeTransition(
        opacity: hideNavDrawerAnimController,
        child: ScaleTransition(
          scale: hideNavDrawerAnimController,
          child: InkWell(
            child: Icon(
              FontAwesomeIcons.bars,
              color: reclipIndigo,
              size: 25,
            ),
            onTap: () {
              BlocProvider.of<DrawerBloc>(context)
                ..add(
                  ShowDrawer(scaffoldKey: _scaffoldKey),
                );
            },
          ),
        ),
      ),
    );
  }
}
