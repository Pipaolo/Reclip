import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';

class CustomDrawer extends StatelessWidget {
  final NavigationBloc navigationBloc;
  const CustomDrawer({Key key, this.navigationBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is HomePageState) {
          return _buildHomePageState();
        }
        if (state is ProfilePageState) {
          return _buildProfilePageState();
        }
        if (state is AddContentPageState) {
          return _buildAddContentState();
        }

        return Container();
      },
    );
  }

  _buildHomePageState() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 50),
              child: InkWell(
                onTap: () {
                  Routes.sailor.pop();
                },
                child: Icon(
                  FontAwesomeIcons.bars,
                  color: tomato.withAlpha(150),
                  size: 25,
                ),
              ),
            ),
          ),
          _buildListItem(
            'MY PROFILE',
            FontAwesomeIcons.solidUser,
            () => navigationBloc.add(ShowProfilePage()),
          ),
          _buildListItem(
            'ADD CONTENT',
            Icons.add_circle_outline,
            () => navigationBloc.add(ShowAddContentPage()),
          ),
          _buildListItem(
            'LOG OUT',
            FontAwesomeIcons.signOutAlt,
            () => navigationBloc.add(ShowLoginPage()),
          ),
        ],
      ),
    );
  }

  _buildProfilePageState() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 50),
              child: InkWell(
                onTap: () {
                  Routes.sailor.pop();
                },
                child: Icon(
                  FontAwesomeIcons.bars,
                  color: tomato.withAlpha(150),
                  size: 25,
                ),
              ),
            ),
          ),
          _buildListItem(
            'HOME',
            Icons.home,
            () => navigationBloc.add(ShowHomePage()),
          ),
          _buildListItem(
            'ADD CONTENT',
            Icons.add_circle_outline,
            () => navigationBloc.add(ShowAddContentPage()),
          ),
          _buildListItem(
            'LOG OUT',
            FontAwesomeIcons.signOutAlt,
            () => navigationBloc.add(ShowLoginPage()),
          ),
        ],
      ),
    );
  }

  _buildAddContentState() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 50),
              child: InkWell(
                onTap: () {
                  Routes.sailor.pop();
                },
                child: Icon(
                  FontAwesomeIcons.bars,
                  color: tomato.withAlpha(150),
                  size: 25,
                ),
              ),
            ),
          ),
          _buildListItem(
            'MY PROFILE',
            FontAwesomeIcons.solidUser,
            () => navigationBloc.add(ShowProfilePage()),
          ),
          _buildListItem(
            'HOME',
            Icons.home,
            () => navigationBloc.add(ShowHomePage()),
          ),
          _buildListItem(
            'LOG OUT',
            FontAwesomeIcons.signOutAlt,
            () => navigationBloc.add(ShowLoginPage()),
          ),
        ],
      ),
    );
  }

  _buildListItem(String title, IconData icon, Function function) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Ink(
        color: tomato.withAlpha(150),
        child: InkWell(
          onTap: function,
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
