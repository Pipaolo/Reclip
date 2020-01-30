import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:reclip/bloc/login/login_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/ui/custom_drawer.dart';
import 'package:sailor/sailor.dart';

class UserProfilePageArgs extends BaseArguments {
  final FirebaseUser user;

  UserProfilePageArgs({@required this.user});
}

class UserProfilePage extends StatefulWidget {
  final UserProfilePageArgs args;
  const UserProfilePage({Key key, this.args}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  NavigationBloc navigationBloc;
  @override
  void initState() {
    navigationBloc = BlocProvider.of<NavigationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY PROFILE'),
        backgroundColor: royalBlue,
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        navigationBloc: navigationBloc,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          ProgressDialog pd = ProgressDialog(context,
              isDismissible: false, type: ProgressDialogType.Normal);
          pd.style(message: '');
          if (state is LoginLoading) {
            pd.show();
          }
          if (state is LoginSuccess) {
            pd.dismiss();
          }
        },
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: yellowOrange,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Icon(
                            FontAwesomeIcons.cog,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.args.user.photoUrl,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: double.infinity,
                        child: AutoSizeText(
                          widget.args.user.displayName,
                          minFontSize: 20,
                          maxFontSize: 40,
                          style: TextStyle(
                            color: darkBlue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 20),
                      child: AutoSizeText(
                        'ILLUSTRATOR,MODEL, PROGRAMMER, ACTOR',
                        minFontSize: 5,
                        maxFontSize: 12,
                        maxLines: 1,
                        style: TextStyle(
                          color: darkBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TabBar(
                      indicator: UnderlineTabIndicator(
                        insets: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      tabs: <Widget>[
                        AutoSizeText(
                          'ABOUT ME',
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 14,
                          style: TextStyle(
                            color: royalBlue,
                            fontSize: 12,
                          ),
                        ),
                        AutoSizeText(
                          'MY WORKS',
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 14,
                          style: TextStyle(
                            color: royalBlue,
                            fontSize: 12,
                          ),
                        ),
                        AutoSizeText(
                          'CONTACT INFO',
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 14,
                          style: TextStyle(
                            color: royalBlue,
                            fontSize: 12,
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
                    Center(
                      child: Text('About me!'),
                    ),
                    Center(
                      child: Text('MyWorks'),
                    ),
                    Center(
                      child: Text('Contact'),
                    ),
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
