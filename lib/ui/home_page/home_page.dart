import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';

import 'illustration_page.dart';
import 'video_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> homePages = List();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    homePages = [
      VideoPage(
        key: PageStorageKey('UserVideoPage'),
      ),
      IllustrationPage(
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
