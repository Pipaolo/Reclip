import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/add_content/add_content_bloc.dart';
import 'package:reclip/bloc/add_video/add_video_bloc.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';
import 'package:reclip/bloc/bloc/connectivity_bloc.dart';
import 'package:reclip/bloc/drawer/drawer_bloc.dart';
import 'package:reclip/bloc/illustration/illustrations_bloc.dart';
import 'package:reclip/bloc/info/info_bloc.dart';
import 'package:reclip/bloc/login/login_bloc.dart';
import 'package:reclip/bloc/other_user/other_user_bloc.dart';
import 'package:reclip/bloc/reclip_user/reclipuser_bloc.dart';
import 'package:reclip/bloc/signup/signup_bloc.dart';
import 'package:reclip/bloc/user/user_bloc.dart';
import 'package:reclip/bloc/verification/verification_bloc.dart';
import 'package:reclip/bloc/video/video_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/router/route_generator.gr.dart';
import 'package:reclip/core/styling.dart';
import 'package:reclip/repository/firebase_reclip_repository.dart';
import 'package:reclip/repository/illustration_repository.dart';
import 'package:reclip/repository/user_repository.dart';
import 'package:reclip/repository/video_repository.dart';

import 'bloc/navigation_bloc.dart';

class ReclipApp extends StatelessWidget {
  const ReclipApp({Key key}) : super(key: key);

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
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc()
            ..add(
              ConnectivityConfigured(),
            ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.reclipTheme,
        builder: ExtendedNavigator<Router>(
          router: Router(),
          initialRoute: Routes.splashPageRoute,
        ),
      ),
    );
  }
}
