import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/ui.dart';
import 'package:sailor/sailor.dart';

class BottomNavBarControllerArgs extends BaseArguments {
  final ReclipUser user;

  BottomNavBarControllerArgs({this.user});
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

  _bottomNavbar(int selectedIndex) {
    return CurvedNavigationBar(
      height: kBottomNavigationBarHeight,
      buttonBackgroundColor: reclipIndigo,
      backgroundColor: reclipBlack,
      items: <Widget>[
        Icon(Icons.home),
        Icon(Icons.add),
        Icon(Icons.person),
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
    pages = [
      UserHomePage(
        key: PageStorageKey('UserHomePage'),
        args: UserHomePageArgs(
          user: widget.args.user,
        ),
      ),
      UserAddContentPage(
        key: PageStorageKey('UserAddContentPage'),
        args: UserAddContentPageArgs(
          user: widget.args.user,
        ),
      ),
      UserProfilePage(
        key: PageStorageKey('UserProfilePage'),
        args: UserProfilePageArgs(user: widget.args.user),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavbar(_selectedIndex),
      body: PageStorage(
        bucket: bucket,
        child: pages[_selectedIndex],
      ),
    );
  }
}
