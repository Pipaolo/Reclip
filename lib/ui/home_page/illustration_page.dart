import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclip/core/reclip_colors.dart';

import '../../bloc/illustration/illustrations_bloc.dart';
import '../../bloc/info/info_bloc.dart';
import '../../bloc/other_user/other_user_bloc.dart';
import '../../core/router/route_generator.gr.dart';
import '../custom_wigets/home_page_appbar.dart';
import '../custom_wigets/illustration_widgets/illustration_widget.dart';
import '../custom_wigets/illustration_widgets/popular_illustration_widget.dart';

class IllustrationPage extends StatelessWidget {
  const IllustrationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowIllustrationInfo) {
            BlocProvider.of<OtherUserBloc>(context)
              ..add(GetOtherUser(email: state.illustration.authorEmail));
            Router.navigator.pushNamed(Router.illustrationContentPageRoute,
                arguments: IllustrationContentPageArguments(
                  illustration: state.illustration,
                ));
          }
        },
        child: BlocBuilder<IllustrationsBloc, IllustrationsState>(
          builder: (context, state) {
            if (state is IllustrationsSuccess) {
              if (state.illustrations.isNotEmpty) {
                return CustomScrollView(
                  slivers: <Widget>[
                    HomePageAppBar(),
                    if (state.illustrations.isNotEmpty)
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Column(
                            children: <Widget>[
                              PopularIllustrationWidget(
                                  illustration: state.illustrations[0]),
                              IllustrationWidget(),
                            ],
                          )
                        ]),
                      ),
                  ],
                );
              } else {
                return CustomScrollView(
                  slivers: <Widget>[
                    HomePageAppBar(),
                    SliverFillRemaining(
                      child: Container(
                        margin: EdgeInsets.all(50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: reclipIndigo,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/images/under-construction.svg',
                              height: ScreenUtil().setHeight(500),
                              width: ScreenUtil().setWidth(500),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '''No Illustrations Found! Kindly wait for the Content Creators to upload. \nThank you!''',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(45)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
