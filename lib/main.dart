import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_content/add_content_bloc.dart';
import 'bloc/add_video/add_video_bloc.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/drawer/drawer_bloc.dart';
import 'bloc/illustration/illustrations_bloc.dart';
import 'bloc/info/info_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/navigation/navigation_bloc.dart';
import 'bloc/other_user/other_user_bloc.dart';
import 'bloc/reclip_user/reclipuser_bloc.dart';
import 'bloc/signup/signup_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'bloc/verification/verification_bloc.dart';
import 'bloc/video/video_bloc.dart';
import 'core/reclip_colors.dart';
import 'core/route_generator.dart';
import 'core/styling.dart';
import 'repository/firebase_reclip_repository.dart';
import 'repository/user_repository.dart';
import 'repository/video_repository.dart';
import 'ui/splash_page/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Routes.createRoutes();

  final UserRepository userRepository = UserRepository();
  final FirebaseReclipRepository firebaseReclipRepository =
      FirebaseReclipRepository();
  final VideoRepository videoRepository = VideoRepository();

  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: Reclip(
        firebaseReclipRepository: firebaseReclipRepository,
        userRepository: userRepository,
        videoRepository: videoRepository,
      ),
    ),
  );
}

class Reclip extends StatelessWidget {
  final FirebaseReclipRepository _firebaseReclipRepository;
  final UserRepository _userRepository;
  final VideoRepository _videoRepository;

  const Reclip(
      {Key key,
      @required UserRepository userRepository,
      @required FirebaseReclipRepository firebaseReclipRepository,
      @required VideoRepository videoRepository})
      : assert(userRepository != null),
        assert(firebaseReclipRepository != null),
        assert(videoRepository != null),
        _videoRepository = videoRepository,
        _firebaseReclipRepository = firebaseReclipRepository,
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: reclipBlackDark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddVideoBloc>(
          create: (context) => AddVideoBloc(),
        ),
        BlocProvider<AddContentBloc>(
          create: (context) => AddContentBloc(
            reclipRepository: _firebaseReclipRepository,
            videoRepository: _videoRepository,
            addVideoBloc: BlocProvider.of<AddVideoBloc>(context),
          ),
        ),
        BlocProvider<VideoBloc>(
          create: (context) => VideoBloc(
            videoRepository: _videoRepository,
            userRepository: _userRepository,
          ),
        ),
        BlocProvider<IllustrationsBloc>(
          create: (context) => IllustrationsBloc(
            reclipRepository: _firebaseReclipRepository,
          )..add(FetchIllustrations()),
        ),
        BlocProvider<UserBloc>(
          create: (context) =>
              UserBloc(reclipRepository: _firebaseReclipRepository),
        ),
        BlocProvider<OtherUserBloc>(
          create: (context) =>
              OtherUserBloc(reclipRepository: _firebaseReclipRepository),
        ),
        BlocProvider<ReclipUserBloc>(
          create: (context) => ReclipUserBloc(
            reclipRepository: _firebaseReclipRepository,
            videoRepository: _videoRepository,
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
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
        ),
        BlocProvider<VerificationBloc>(
          create: (context) => VerificationBloc(
            userRepository: _userRepository,
          ),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(
            userRepository: _userRepository,
            firebaseReclipRepository: _firebaseReclipRepository,
          ),
        ),
        BlocProvider<DrawerBloc>(
          create: (context) => DrawerBloc(),
        ),
        BlocProvider<InfoBloc>(
          create: (context) => InfoBloc(
            reclipRepository: _firebaseReclipRepository,
            userRepository: _userRepository,
            videoRepository: _videoRepository,
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.reclipTheme,
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        home: SplashPage(),
      ),
    );
  }
}
//Note: ang pogi ni Samuel D. Garcia ng 12 Java
