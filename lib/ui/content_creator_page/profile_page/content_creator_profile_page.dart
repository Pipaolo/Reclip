import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../core/route_generator.dart';
import 'content_creator_about_me_page.dart';
import 'content_creator_contact_info_page.dart';
import 'content_creator_my_works_page.dart';
import 'edit_profile_page/content_creator_edit_profile_page.dart';

class ContentCreatorProfilePage extends StatefulWidget {
  const ContentCreatorProfilePage({Key key}) : super(key: key);

  @override
  _ContentCreatorProfilePageState createState() =>
      _ContentCreatorProfilePageState();
}

class _ContentCreatorProfilePageState extends State<ContentCreatorProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is ContentCreatorSuccess) {
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                  child: Text('Sign Out'),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) =>
                                            _buildConfirmationDialog());
                                  },
                                ),
                                InkWell(
                                  child: Icon(
                                    FontAwesomeIcons.solidEdit,
                                    size: ScreenUtil().setSp(50),
                                  ),
                                  onTap: () {
                                    Routes.sailor.navigate(
                                      'user_edit_profile_page',
                                      args: ContentCreatorEditProfilePageArgs(
                                          user: state.contentCreator),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: ScreenUtil().setSp(130),
                            child: Stack(
                              children: <Widget>[
                                TransitionToImage(
                                  image: AdvancedNetworkImage(
                                      state.contentCreator.imageUrl),
                                  borderRadius: BorderRadius.circular(200),
                                  height: ScreenUtil().setHeight(400),
                                  width: ScreenUtil().setWidth(400),
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: SizedBox(
                              width: double.infinity,
                              child: AutoSizeText(
                                state.contentCreator.name,
                                style: TextStyle(
                                  color: reclipBlack,
                                  fontSize: ScreenUtil().setSp(40),
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
                              borderSide:
                                  BorderSide(color: reclipBlack, width: 2),
                            ),
                            tabs: <Widget>[
                              AutoSizeText(
                                'ABOUT ME',
                                maxLines: 1,
                                minFontSize: 12,
                                style: TextStyle(
                                  color: reclipBlack,
                                  fontSize: ScreenUtil().setSp(40),
                                ),
                              ),
                              AutoSizeText(
                                'MY WORKS',
                                maxLines: 1,
                                minFontSize: 12,
                                style: TextStyle(
                                  color: reclipBlack,
                                  fontSize: ScreenUtil().setSp(40),
                                ),
                              ),
                              AutoSizeText(
                                'CONTACT INFO',
                                maxLines: 1,
                                minFontSize: 12,
                                style: TextStyle(
                                  color: reclipBlack,
                                  fontSize: ScreenUtil().setSp(40),
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
                          ContentCreatorAboutMePage(user: state.contentCreator),
                          ContentCreatorMyWorksPage(user: state.contentCreator),
                          ContentCreatorContactInfoPage(
                              user: state.contentCreator),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserError) {
              return Center(
                child: Text('Oops something bad happened'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildConfirmationDialog() {
    return AlertDialog(
      backgroundColor: reclipBlack,
      title: Text(
        'Sign Out',
        style: TextStyle(
          color: reclipIndigo,
        ),
      ),
      content: Text(
        'Do you want to sign out?',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: reclipIndigoDark,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            'Confirm',
            style: TextStyle(color: reclipIndigoLight),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
            Routes.sailor.navigate(
              'login_page',
              navigationType: NavigationType.pushAndRemoveUntil,
              removeUntilPredicate: ModalRoute.withName('login_page'),
            );
          },
        )
      ],
    );
  }
}
