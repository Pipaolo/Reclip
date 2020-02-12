import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/drawer/drawer_bloc.dart';
import 'package:reclip/bloc/illustration/illustrations_bloc.dart';

import 'bloc/add_content/add_content_bloc.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/info/info_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/navigation/navigation_bloc.dart';
import 'bloc/playback/playback_bloc.dart';
import 'bloc/youtube/youtube_bloc.dart';
import 'core/reclip_colors.dart';
import 'core/route_generator.dart';
import 'repository/firebase_reclip_repository.dart';
import 'repository/user_repository.dart';
import 'repository/youtube_repository.dart';
import 'ui/splash_page/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Routes.createRoutes();

  final UserRepository userRepository = UserRepository();
  final FirebaseReclipRepository firebaseReclipRepository =
      FirebaseReclipRepository();
  final YoutubeRepository youtubeRepository =
      YoutubeRepository(firebaseReclipRepository: firebaseReclipRepository);

  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: Reclip(
        firebaseReclipRepository: firebaseReclipRepository,
        youtubeRepository: youtubeRepository,
        userRepository: userRepository,
      ),
    ),
  );
}

class Reclip extends StatelessWidget {
  final YoutubeRepository _youtubeRepository;
  final FirebaseReclipRepository _firebaseReclipRepository;
  final UserRepository _userRepository;

  const Reclip(
      {Key key,
      @required UserRepository userRepository,
      @required YoutubeRepository youtubeRepository,
      @required FirebaseReclipRepository firebaseReclipRepository})
      : assert(userRepository != null),
        assert(youtubeRepository != null),
        assert(firebaseReclipRepository != null),
        _youtubeRepository = youtubeRepository,
        _firebaseReclipRepository = firebaseReclipRepository,
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddContentBloc>(
          create: (context) =>
              AddContentBloc(reclipRepository: _firebaseReclipRepository),
        ),
        BlocProvider<IllustrationsBloc>(
          create: (context) => IllustrationsBloc(
            reclipRepository: _firebaseReclipRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          )..add(FetchIllustrations()),
        ),
        BlocProvider<YoutubeBloc>(
          create: (context) => YoutubeBloc(
            youtubeRepository: YoutubeRepository(
              firebaseReclipRepository: _firebaseReclipRepository,
            ),
            firebaseReclipRepository: _firebaseReclipRepository,
          ),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(
            navigatorKey: Routes.sailor.navigatorKey,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            userRepository: _userRepository,
            firebaseReclipRepository: _firebaseReclipRepository,
            youtubeRepository: _youtubeRepository,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
        ),
        BlocProvider<PlaybackBloc>(
          create: (context) => PlaybackBloc(),
        ),
        BlocProvider<DrawerBloc>(
          create: (context) => DrawerBloc(),
        ),
        BlocProvider<InfoBloc>(
          create: (context) => InfoBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          buttonColor: Colors.black,
          appBarTheme: AppBarTheme(
            color: Colors.black,
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          splashColor: Colors.black45,
          primaryColor: reclipBlack,
          primaryColorDark: reclipBlackDark,
          primaryColorLight: reclipBlackLight,
          accentColor: reclipIndigo,
          scaffoldBackgroundColor: reclipBlack,
        ),
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        home: SplashPage(),
      ),
    );
  }
}
//Note: ang pogi ni Samuel D. Garcia ng 12 Java
