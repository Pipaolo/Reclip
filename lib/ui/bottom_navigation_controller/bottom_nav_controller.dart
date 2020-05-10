import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/model/reclip_content_creator.dart';
import 'package:reclip/model/reclip_user.dart';

import '../bloc/bottom_navigation/bottom_navigation_bloc.dart';
import '../content_creator_page/add_content/content_creator_add_content_page.dart';
import '../content_creator_page/profile_page/content_creator_profile_page.dart';
import '../home_page/home_page.dart';
import '../user_page/my_list_page/user_my_list_page.dart';
import '../user_page/user_profile_page.dart';
import 'widgets/content_creator_bottom_navigation_bar.dart';
import 'widgets/user_bottom_navigation_bar.dart';

class BottomNavBarController extends StatelessWidget
    implements AutoRouteWrapper {
  final ReclipContentCreator contentCreator;
  final ReclipUser user;

  @override
  Widget wrappedRoute(context) => BlocProvider<BottomNavigationBloc>(
        create: (context) => BottomNavigationBloc(),
        child: this,
      );

  BottomNavBarController({
    Key key,
    this.contentCreator,
    this.user,
  }) : super(key: key);

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (contentCreator != null)
          ? ContentCreatorBottomNavigationBar()
          : UserBottomNavigationBar(),
      body: PageStorage(
          bucket: bucket,
          child: BlocBuilder<BottomNavigationBloc, int>(
            builder: (context, index) {
              final pages = (contentCreator != null)
                  ? _loadContentCreatorWidgets()
                  : _loadUserWidgets();
              return pages[index];
            },
          )),
    );
  }

  List<Widget> _loadContentCreatorWidgets() => [
        HomePage(
          key: PageStorageKey('UserHomePage'),
        ),
        ContentCreatorAddContentPage(
          key: PageStorageKey('UserAddContentPage'),
          user: contentCreator,
        ),
        ContentCreatorProfilePage(
          key: PageStorageKey('UserProfilePage'),
        ),
      ];

  List<Widget> _loadUserWidgets() => [
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
