import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/bloc/youtube/youtube_bloc.dart';

import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/ui/custom_drawer.dart';
import 'package:reclip/ui/user_page/home_page/image_widget.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<String> categories = ['Illustrations', 'Photography', 'Clips and Films'];
  NavigationBloc navigationBloc;
  @override
  void initState() {
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
    BlocProvider.of<YoutubeBloc>(context)..add(FetchYoutubeVideo());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: yellowOrange,
        title: Text('HOME'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        navigationBloc: navigationBloc,
      ),
      body: BlocBuilder<YoutubeBloc, YoutubeState>(
        builder: (context, state) {
          if (state is YoutubeError) {
            return Center(child: Text(state.error));
          }
          if (state is YoutubeLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is YoutubeSuccess) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  color: darkBlue,
                  child: Text(
                    'Clips and Films',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ImageWidget(
                  ytVids: state.ytVids,
                  scaffoldKey: _scaffoldKey,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
