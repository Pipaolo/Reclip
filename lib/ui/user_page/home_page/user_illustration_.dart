import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/illustration/illustrations_bloc.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/bloc/user/user_bloc.dart';
import 'package:reclip/ui/user_page/home_page/illustration_widgets/illustration_widget.dart';
import 'package:reclip/ui/user_page/home_page/user_home_page_appbar.dart';

import 'illustration_bottom_sheet/illustration_bottom_sheet.dart';
import 'video_bottom_sheet/video_bottom_sheet.dart';

class UserIllustrationPage extends StatelessWidget {
  const UserIllustrationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InfoBloc, InfoState>(
          listener: (context, state) {
            if (state is ShowVideoInfo) {
              showBottomSheet(
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                        initialChildSize: 1.0,
                        builder: (context, scrollController) {
                          return ListView(
                            controller: scrollController,
                            shrinkWrap: true,
                            children: <Widget>[
                              VideoBottomSheet(
                                ytChannel: state.channel,
                                ytVid: state.video,
                                controller: scrollController,
                              ),
                            ],
                          );
                        });
                  });
            } else if (state is ShowIllustrationInfo) {
              BlocProvider.of<UserBloc>(context)
                ..add(GetUser(email: state.illustration.authorEmail));
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return IllustrationBottomSheet(
                    illustration: state.illustration,
                  );
                },
              );
            }
          },
          child: CustomScrollView(
            slivers: <Widget>[
              HomePageAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  IllustrationWidget(),
                ]),
              )
            ],
          )),
    );
  }
}
