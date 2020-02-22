import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/navigation/navigation_bloc.dart';
import 'user_illustration_page.dart';
import 'user_video_page.dart';

class UserHomePageArgs extends BaseArguments {
  final ReclipContentCreator user;

  UserHomePageArgs({@required this.user});
}

class UserHomePage extends StatefulWidget {
  final UserHomePageArgs args;

  UserHomePage({Key key, this.args}) : super(key: key);

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
        user: widget.args.user,
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
