import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/navigation/navigation_bloc.dart';
import '../../../data/model/reclip_user.dart';
import 'user_illustration_.dart';
import 'user_video_page.dart';

class UserHomePageArgs extends BaseArguments {
  final ReclipUser user;

  UserHomePageArgs({@required this.user});
}

class UserHomePage extends StatefulWidget {
  final UserHomePageArgs args;

  UserHomePage({Key key, this.args}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final List<String> categories = ['Illustrations', 'Clips and Films'];
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
