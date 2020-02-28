import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/authentication/authentication_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../core/route_generator.dart';
import 'about_me_page.dart';
import 'contact_info_page.dart';
import 'edit_profile_page/edit_profile_page.dart';
import 'my_works_page.dart';

class UserContentCreatorProfilePage extends StatefulWidget {
  const UserContentCreatorProfilePage({Key key}) : super(key: key);

  @override
  _UserContentCreatorProfilePageState createState() =>
      _UserContentCreatorProfilePageState();
}

class _UserContentCreatorProfilePageState
    extends State<UserContentCreatorProfilePage> {
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
                                    size: ScreenUtil().setSp(25),
                                  ),
                                  onTap: () {
                                    Routes.sailor.navigate(
                                      'user_edit_profile_page',
                                      args: UserEditProfilePageArgs(
                                          user: state.contentCreator),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              state.contentCreator.imageUrl,
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
                                state.contentCreator.name,
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
                          AboutMePage(user: state.contentCreator),
                          MyWorksPage(user: state.contentCreator),
                          ContactInfoPage(user: state.contentCreator),
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
