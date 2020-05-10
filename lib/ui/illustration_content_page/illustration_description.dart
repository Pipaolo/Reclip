import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/other_user/other_user_bloc.dart';
import '../../core/reclip_colors.dart';
import '../../model/illustration.dart';
import '../../model/reclip_content_creator.dart';
import 'illustration_author_image.dart';

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
          SizedBox(
            height: 15,
          ),
          IllustrationAuthorImage(
            user: user,
          ),
          SizedBox(
            width: double.infinity,
            child: AutoSizeText(
              user.name,
              maxLines: 1,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(16),
                color: reclipBlackDark,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 35,
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
            height: ScreenUtil().setHeight(400),
            width: double.infinity,
            alignment: Alignment.center,
            child: AutoSizeText(
              illustration.description,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
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
