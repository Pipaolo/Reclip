import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/navigation/navigation_bloc.dart';
import 'user_illustration_page.dart';
import 'user_video_page.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<Widget> homePages = List();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    homePages = [
      UserVideoPage(
        key: PageStorageKey('UserVideoPage'),
      ),
      UserIllustrationPage(
        key: PageStorageKey('UserIllustrationPage'),
      ),
    ];
    BlocProvider.of<NavigationBloc>(context)..add(ShowVideoPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is VideoPageState) {
              return homePages[state.index];
            } else if (state is IllustrationPageState) {
              return homePages[state.index];
            }
            return Container();
          },
        ),
      ),
    );
  }
}
