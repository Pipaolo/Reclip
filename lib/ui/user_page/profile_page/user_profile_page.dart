import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/ui/user_page/profile_page/edit_profile_page/edit_profile_page.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_user.dart';
import 'about_me_page.dart';
import 'contact_info_page.dart';
import 'my_works_page.dart';

class UserProfilePageArgs extends BaseArguments {
  final ReclipUser user;

  UserProfilePageArgs({@required this.user});
}

class UserProfilePage extends StatefulWidget {
  final UserProfilePageArgs args;

  const UserProfilePage({Key key, this.args}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY PROFILE'),
        backgroundColor: reclipBlack,
        centerTitle: true,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        child: DefaultTabController(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Icon(
                            FontAwesomeIcons.solidEdit,
                            size: ScreenUtil().setSp(25),
                          ),
                          onTap: () {
                            Routes.sailor.navigate('user_edit_profile_page',
                                args: UserEditProfilePageArgs(
                                  user: widget.args.user,
                                ));
                          },
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.args.user.imageUrl,
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
                          widget.args.user.name,
                          style: TextStyle(
                            color: reclipBlack,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                    AboutMePage(user: widget.args.user),
                    MyWorksPage(user: widget.args.user),
                    ContactInfoPage(user: widget.args.user),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
