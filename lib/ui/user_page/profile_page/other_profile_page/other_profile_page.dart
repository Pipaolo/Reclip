import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';

import '../../../../bloc/other_user/other_user_bloc.dart';
import '../../../../core/reclip_colors.dart';
import '../about_me_page.dart';
import '../contact_info_page.dart';
import '../my_works_page.dart';

class OtherProfilePage extends StatefulWidget {
  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<OtherUserBloc, OtherUserState>(
          builder: (context, state) {
            if (state is OtherUserSuccess) {
              return _buildSuccessState(state.user);
            } else if (state is OtherUserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OtherUserError) {
              print(state.errorText);
              return Center(
                child: Text('Woops something bad happened :('),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildSuccessState(ReclipContentCreator user) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: reclipIndigo,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    user.imageUrl,
                    fit: BoxFit.cover,
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(100),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    width: double.infinity,
                    child: AutoSizeText(
                      user.name,
                      style: TextStyle(
                        color: reclipBlack,
                        fontSize: ScreenUtil().setSp(20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                TabBar(
                  indicator: UnderlineTabIndicator(
                    insets: EdgeInsets.symmetric(horizontal: 20),
                    borderSide: BorderSide(color: reclipBlack, width: 2),
                  ),
                  tabs: <Widget>[
                    AutoSizeText(
                      'ABOUT ME',
                      maxLines: 1,
                      minFontSize: 12,
                      style: TextStyle(
                        color: reclipBlack,
                        fontSize: ScreenUtil().setSp(13),
                      ),
                    ),
                    AutoSizeText(
                      'MY WORKS',
                      maxLines: 1,
                      minFontSize: 12,
                      style: TextStyle(
                        color: reclipBlack,
                        fontSize: ScreenUtil().setSp(13),
                      ),
                    ),
                    AutoSizeText(
                      'CONTACT INFO',
                      maxLines: 1,
                      minFontSize: 12,
                      style: TextStyle(
                        color: reclipBlack,
                        fontSize: ScreenUtil().setSp(13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              children: <Widget>[
                AboutMePage(user: user),
                MyWorksPage(user: user),
                ContactInfoPage(
                  user: user,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
