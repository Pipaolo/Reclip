import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/repository/user_repository.dart';
import 'package:reclip/repository/youtube_repository.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/youtube/youtube_bloc.dart';
import 'core/keys.dart';
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
              ytApi: YoutubeApi(
                clientViaApiKey(Keys.youtubeApiKey),
              ),
            ),
          )..add(
              FetchYoutubeVideo(),
            ),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(
            navigatorKey: Routes.sailor.navigatorKey,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: yellowOrange,
          buttonColor: yellowOrange,
          fontFamily: 'KarlaTamilUpright',
          canvasColor: royalBlue,
        ),
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        home: SplashPage(),
      ),
    );
  }
}
