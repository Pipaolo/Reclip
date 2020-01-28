import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/bloc/youtube/youtube_bloc.dart';

import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/ui/custom_drawer.dart';

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
    return Scaffold(
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
              child: CircularProgressIndicator(
                backgroundColor: yellowOrange,
              ),
            );
          }
          if (state is YoutubeSuccess) {
            return ListView.builder(
              itemCount: state.ytVids.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading:
                      Image.network(state.ytVids[index].images.default_.url),
                  title: Text(
                    state.ytVids[index].title,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  _buildList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              color: darkBlue,
              padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
              child: Text(
                categories[index],
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 200,
                        width: 150,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      },
      itemCount: categories.length,
    );
  }
}
