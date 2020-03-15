import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/content_creator_page/add_content/content_creator_add_content_page.dart';
import 'package:reclip/ui/content_creator_page/profile_page/content_creator_profile_page.dart';
import 'package:reclip/ui/home_page/home_page.dart';
import 'package:reclip/ui/user_page/my_list_page/user_my_list_page.dart';
import 'package:reclip/ui/user_page/user_profile_page.dart';

import 'core/reclip_colors.dart';

class BottomNavBarController extends StatefulWidget {
  final ReclipContentCreator contentCreator;
  final ReclipUser user;
  BottomNavBarController({
    Key key,
    this.contentCreator,
    this.user,
  }) : super(key: key);

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
    if (widget.contentCreator != null) {
      pages = [
        HomePage(
          key: PageStorageKey('UserHomePage'),
        ),
        ContentCreatorAddContentPage(
          key: PageStorageKey('UserAddContentPage'),
          user: widget.contentCreator,
        ),
        ContentCreatorProfilePage(
          key: PageStorageKey('UserProfilePage'),
        ),
      ];
    } else {
      pages = [
        HomePage(
          key: PageStorageKey('UserHomePage'),
        ),
        UserMyListPage(
          key: PageStorageKey('UserMyListPage'),
        ),
        UserProfilePage(
          key: PageStorageKey('ReclipUserProfilePage'),
        ),
      ];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (widget.contentCreator != null)
          ? _buildContentCreatorNavbar(_selectedIndex)
          : _buildUserNavbar(_selectedIndex),
      body: PageStorage(
        bucket: bucket,
        child: pages[_selectedIndex],
      ),
    );
  }
}
