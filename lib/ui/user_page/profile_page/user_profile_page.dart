import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';

import 'package:reclip/ui/user_page/profile_page/contact_info_page.dart';
import 'package:sailor/sailor.dart';

import '../../../bloc/navigation/navigation_bloc.dart';
import '../../../core/reclip_colors.dart';
import '../../../data/model/reclip_user.dart';
import '../../custom_drawer.dart';
import 'about_me_page.dart';
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
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        navigationBloc: navigationBloc,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Icon(
                            FontAwesomeIcons.solidEdit,
                            size: 25,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.args.user.imageUrl,
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
                          widget.args.user.name,
                          minFontSize: 20,
                          maxFontSize: 40,
                          style: TextStyle(
                            color: reclipBlack,
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
                          color: reclipBlack,
                        ),
                        textAlign: TextAlign.center,
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
                          maxFontSize: 14,
                          style: TextStyle(
                            color: reclipBlack,
                            fontSize: 12,
                          ),
                        ),
                        AutoSizeText(
                          'MY WORKS',
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 14,
                          style: TextStyle(
                            color: reclipBlack,
                            fontSize: 12,
                          ),
                        ),
                        AutoSizeText(
                          'CONTACT INFO',
                          maxLines: 1,
                          minFontSize: 12,
                          maxFontSize: 14,
                          style: TextStyle(
                            color: reclipBlack,
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
                    AboutMePage(user: widget.args.user),
                    MyWorksPage(user: widget.args.user),
                    ContactInfoPage(),
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
