import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/navigation/navigation_bloc.dart';
import '../../../bloc/youtube/youtube_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_user.dart';
import '../../../data/model/youtube_channel.dart';
import '../../custom_drawer.dart';
import 'image_widget.dart';

class UserHomePageArgs extends BaseArguments {
  final ReclipUser user;

  UserHomePageArgs({@required this.user});
}

class UserHomePage extends StatefulWidget {
  final UserHomePageArgs args;
  const UserHomePage({Key key, this.args}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<String> categories = ['Illustrations', 'Photography', 'Clips and Films'];
  NavigationBloc navigationBloc;
  bool isExpanded = false;
  @override
  void initState() {
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
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
      resizeToAvoidBottomInset: false,
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
              child: SpinKitCircle(
                color: yellowOrange,
              ),
            );
          }
          if (state is YoutubeSuccess) {
            return _buildHomePage(state.ytChannels);
          }
          return Container();
        },
      ),
    );
  }

  _buildHomePage(List<YoutubeChannel> channels) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: darkBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Clips and Films',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ImageWidget(
            ytChannels: channels,
            isExpanded: isExpanded,
          ),
        ],
      ),
    );
  }
}
