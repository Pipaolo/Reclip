import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/user/user_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/data/model/reclip_user.dart';

import 'illustration_author_image.dart';

class IllustrationBottomSheet extends StatelessWidget {
  final Illustration illustration;
  const IllustrationBottomSheet({Key key, @required this.illustration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().uiHeightPx,
      child: Column(
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
                        color: reclipBlack,
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
      ),
    );
  }
}

class IllustrationDescription extends StatelessWidget {
  final Illustration illustration;

  const IllustrationDescription({Key key, @required this.illustration})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserSuccess) {
          return _buildSuccessState(state.user);
        } else if (state is UserLoading) {
          return _buildLoadingState();
        } else if (state is UserError) {
          return _buildErrorState(state.error);
        }
        return Container();
      },
    );
  }

  _buildSuccessState(ReclipUser user) {
    return Container(
      height: ScreenUtil().uiHeightPx * 0.43,
      padding: EdgeInsets.symmetric(horizontal: 10),
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
              ),
              textAlign: TextAlign.center,
            ),
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
