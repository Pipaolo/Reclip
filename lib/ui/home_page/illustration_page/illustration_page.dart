import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/illustration/illustrations_bloc.dart';
import '../../../bloc/info/info_bloc.dart';
import '../../../bloc/other_user/other_user_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../core/router/route_generator.gr.dart';
import '../../../model/illustration.dart';
import '../../custom_widgets/home_page_appbar.dart';
import 'widgets/illustration_list_widget.dart';

class IllustrationPage extends StatelessWidget {
  const IllustrationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InfoBloc, InfoState>(
        listener: (context, state) {
          if (state is ShowIllustrationInfo) {
            BlocProvider.of<OtherUserBloc>(context)
              ..add(
                  GetOtherUser(email: state.illustration.contentCreatorEmail));
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IllustrationListWidget(
                illustrations: illustrations,
              ),
            ),
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
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: reclipIndigo,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setWidth(150),
                  child: SvgPicture.asset(
                    'assets/images/under-construction.svg',
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '''No Illustrations Found! Kindly wait for the Content Creators to upload. \nThank you!''',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18)),
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
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: reclipIndigo,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setHeight(150),
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/images/error.svg',
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '''Woops something bad happened! Please contact the developers, \nthank you!''',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                      textAlign: TextAlign.center,
                    ),
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
}
