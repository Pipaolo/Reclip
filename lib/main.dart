import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/notification/notification_bloc.dart';
import 'package:reclip/core/router/route_generator.gr.dart';
import 'package:reclip/repository/illustration_repository.dart';

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
import 'core/styling.dart';
import 'repository/firebase_reclip_repository.dart';
import 'repository/user_repository.dart';
import 'repository/video_repository.dart';
import 'ui/splash_page/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<FirebaseReclipRepository>(
          create: (context) => FirebaseReclipRepository(),
        ),
        RepositoryProvider<VideoRepository>(
          create: (context) => VideoRepository(),
        ),
        RepositoryProvider<IllustrationRepository>(
          create: (context) => IllustrationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context))
              ..add(
                AppStarted(),
              ),
          ),
          BlocProvider<NotificationBloc>(
            create: (context) =>
                NotificationBloc()..add(NotificationConfigured()),
          ),
        ],
        child: Reclip(),
      ),
    ),
  );
}

class Reclip extends StatelessWidget {
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
            illustrationRepository:
                RepositoryProvider.of<IllustrationRepository>(context),
            videoRepository: RepositoryProvider.of<VideoRepository>(context),
            addVideoBloc: BlocProvider.of<AddVideoBloc>(context),
          ),
        ),
        BlocProvider<VideoBloc>(
          create: (context) => VideoBloc(
            videoRepository: RepositoryProvider.of<VideoRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider<IllustrationsBloc>(
          create: (context) => IllustrationsBloc(
            illustrationRepository:
                RepositoryProvider.of<IllustrationRepository>(context),
          ),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
              reclipRepository:
                  RepositoryProvider.of<FirebaseReclipRepository>(context)),
        ),
        BlocProvider<OtherUserBloc>(
          create: (context) => OtherUserBloc(
              reclipRepository:
                  RepositoryProvider.of<FirebaseReclipRepository>(context)),
        ),
        BlocProvider<ReclipUserBloc>(
          create: (context) => ReclipUserBloc(
            reclipRepository:
                RepositoryProvider.of<FirebaseReclipRepository>(context),
            videoRepository: RepositoryProvider.of<VideoRepository>(context),
          ),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(
            navigatorKey: Router.navigator.key,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            firebaseReclipRepository:
                RepositoryProvider.of<FirebaseReclipRepository>(context),
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
        ),
        BlocProvider<VerificationBloc>(
          create: (context) => VerificationBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            firebaseReclipRepository:
                RepositoryProvider.of<FirebaseReclipRepository>(context),
          ),
        ),
        BlocProvider<DrawerBloc>(
          create: (context) => DrawerBloc(),
        ),
        BlocProvider<InfoBloc>(
          create: (context) => InfoBloc(
            reclipRepository:
                RepositoryProvider.of<FirebaseReclipRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            videoRepository: RepositoryProvider.of<VideoRepository>(context),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.reclipTheme,
        onGenerateRoute: Router.onGenerateRoute,
        navigatorKey: Router.navigator.key,
        initialRoute: Router.splashPageRoute,
        home: SplashPage(),
      ),
    );
  }
}
//Note: ang pogi ni Samuel D. Garcia ng 12 Java
