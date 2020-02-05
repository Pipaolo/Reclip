import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/drawer/drawer_bloc.dart';

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
  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: Reclip(
        userRepository: userRepository,
      ),
    ),
  );
}

class Reclip extends StatelessWidget {
  final UserRepository _userRepository;
  const Reclip({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<YoutubeBloc>(
          create: (context) => YoutubeBloc(
            youtubeRepository: YoutubeRepository(
              firebaseReclipRepository: FirebaseReclipRepository(),
            ),
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            firebaseReclipRepository: FirebaseReclipRepository(),
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
            firebaseReclipRepository: FirebaseReclipRepository(),
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
          fontFamily: 'KarlaTamilUpright',
          splashColor: Colors.black45,
          canvasColor: Colors.black,
          errorColor: tomato,
        ),
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        home: SplashPage(),
      ),
    );
  }
}
//Note: ang pogi ni Samuel D. Garcia ng 12 Java
