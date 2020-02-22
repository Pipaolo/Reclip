import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';

import '../../../../bloc/other_user/other_user_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../../../../data/model/illustration.dart';
import 'illustration_author_image.dart';

class IllustrationBottomSheet extends StatelessWidget {
  final Illustration illustration;
  final ScrollController scrollController;
  const IllustrationBottomSheet(
      {Key key, @required this.illustration, @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: scrollController,
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(425),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: Container(
                    height: ScreenUtil().setHeight(400),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: reclipBlackDark,
                    ),
                    child: Image(
                      image: AdvancedNetworkImage(
                        illustration.imageUrl,
                        useDiskCache: true,
                        cacheRule: CacheRule(maxAge: Duration(days: 2)),
                      ),
                      fit: BoxFit.fitHeight,
                    )),
              ),
              Positioned(
                bottom: 0,
                left: 80,
                right: 80,
                child: Container(
                  height: ScreenUtil().setHeight(50),
                  decoration: BoxDecoration(
                    color: reclipIndigo,
                    boxShadow: [
                      BoxShadow(
                        color: reclipBlack,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    illustration.title,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        IllustrationDescription(
          illustration: illustration,
        ),
      ],
    );
  }
}

class IllustrationDescription extends StatelessWidget {
  final Illustration illustration;

  const IllustrationDescription({Key key, @required this.illustration})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserBloc, OtherUserState>(
      builder: (context, state) {
        if (state is OtherUserSuccess) {
          return _buildSuccessState(state.user);
        } else if (state is OtherUserLoading) {
          return _buildLoadingState();
        } else if (state is OtherUserError) {
          return _buildErrorState(state.errorText);
        }
        return Container();
      },
    );
  }

  _buildSuccessState(ReclipContentCreator user) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IllustrationAuthorImage(
            user: user,
          ),
          SizedBox(
            width: double.infinity,
            child: AutoSizeText(
              user.name,
              maxLines: 1,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: reclipIndigoDark,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: reclipBlack,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ]),
            height: ScreenUtil().setHeight(200),
            width: double.infinity,
            alignment: Alignment.center,
            child: AutoSizeText(
              illustration.description,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
              ),
              textAlign: TextAlign.center,
              maxLines: 5,
            ),
          )
        ],
      ),
    );
  }

  _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildErrorState(String error) {
    return Center(
      child: Text(error),
    );
  }
}
