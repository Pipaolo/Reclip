import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/illustration.dart';

import '../../bloc/illustration/illustrations_bloc.dart';
import '../../bloc/info/info_bloc.dart';
import '../../bloc/other_user/other_user_bloc.dart';
import '../../core/router/route_generator.gr.dart';
import '../custom_widgets/home_page_appbar.dart';
import '../custom_widgets/illustration_widgets/illustration_widget.dart';
import '../custom_widgets/illustration_widgets/popular_illustration_widget.dart';

class IllustrationPage extends StatelessWidget {
  const IllustrationPage({Key key}) : super(key: key);

  _buildListPopulated(List<Illustration> illustrations, BuildContext context) {
    return RefreshIndicator(
      color: reclipIndigo,
      onRefresh: () async {
        BlocProvider.of<IllustrationsBloc>(context)..add(IllustrationFetched());
        return null;
      },
      child: CustomScrollView(
        slivers: <Widget>[
          HomePageAppBar(),
          if (illustrations.isNotEmpty)
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    PopularIllustrationWidget(illustration: illustrations[0]),
                    IllustrationWidget(),
                  ],
                )
              ]),
            ),
        ],
      ),
    );
  }

  _buildListEmpty() {
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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

  _buildError(String error) {
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
                  'assets/images/error.svg',
                  height: ScreenUtil().setHeight(400),
                  width: ScreenUtil().setWidth(400),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '''Woops something bad happened! Please contact the developers, \nthank you!''',
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

  _buildLoading() {
    return CustomScrollView(
      slivers: <Widget>[
        HomePageAppBar(),
        SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowIllustrationInfo) {
            BlocProvider.of<OtherUserBloc>(context)
              ..add(GetOtherUser(email: state.illustration.authorEmail));
            ExtendedNavigator.rootNavigator
                .pushNamed(Routes.illustrationContentPageRoute,
                    arguments: IllustrationContentPageArguments(
                      illustration: state.illustration,
                    ));
          }
        },
        child: BlocBuilder<IllustrationsBloc, IllustrationsState>(
          builder: (context, state) {
            if (state is IllustrationsSuccess) {
              if (state.illustrations.isNotEmpty) {
                return _buildListPopulated(state.illustrations, context);
              } else {
                return _buildListEmpty();
              }
            } else if (state is IllustrationsError) {
              return _buildError(state.errorText);
            } else if (state is IllustrationsLoading) {
              return _buildLoading();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
