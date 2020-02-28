import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/user_page/my_list_page/user_my_list_page.dart';
import 'package:reclip/ui/user_page/profile_page/user_reclipcontentcreator_page.dart';
import 'package:reclip/ui/user_page/profile_page/user_reclipuser_page.dart';
import 'package:sailor/sailor.dart';

import '../core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'ui.dart';

class BottomNavBarControllerArgs extends BaseArguments {
  final ReclipContentCreator contentCreator;
  final ReclipUser user;

  BottomNavBarControllerArgs({this.contentCreator, this.user});
}

class BottomNavBarController extends StatefulWidget {
  final BottomNavBarControllerArgs args;
  BottomNavBarController({Key key, this.args}) : super(key: key);

  @override
  _BottomNavBarControllerState createState() => _BottomNavBarControllerState();
}

class _BottomNavBarControllerState extends State<BottomNavBarController> {
  List<Widget> pages = List();

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  _buildUserNavbar(int selectedIndex) {
    return CurvedNavigationBar(
      height: kBottomNavigationBarHeight,
      buttonBackgroundColor: reclipIndigoDark,
      color: reclipBlack,
      backgroundColor: Colors.white,
      items: <Widget>[
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.star, color: Colors.white),
        Icon(Icons.person, color: Colors.white),
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      index: selectedIndex,
    );
  }

  _buildContentCreatorNavbar(int selectedIndex) {
    return CurvedNavigationBar(
      height: kBottomNavigationBarHeight,
      buttonBackgroundColor: reclipIndigoDark,
      color: reclipBlack,
      backgroundColor: Colors.white,
      items: <Widget>[
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.add, color: Colors.white),
        Icon(Icons.person, color: Colors.white),
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      index: selectedIndex,
    );
  }

  @override
  void initState() {
    if (widget.args.contentCreator != null) {
      pages = [
        UserHomePage(
          key: PageStorageKey('UserHomePage'),
        ),
        UserAddContentPage(
          key: PageStorageKey('UserAddContentPage'),
          args: UserAddContentPageArgs(user: widget.args.contentCreator),
        ),
        UserContentCreatorProfilePage(
          key: PageStorageKey('UserProfilePage'),
        ),
      ];
    } else {
      pages = [
        UserHomePage(
          key: PageStorageKey('UserHomePage'),
        ),
        UserMyListPage(
          key: PageStorageKey('UserMyListPage'),
        ),
        ReclipUserProfilePage(
          key: PageStorageKey('ReclipUserProfilePage'),
        ),
      ];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (widget.args.contentCreator != null)
          ? _buildContentCreatorNavbar(_selectedIndex)
          : _buildUserNavbar(_selectedIndex),
      body: PageStorage(
        bucket: bucket,
        child: pages[_selectedIndex],
      ),
    );
  }
}
