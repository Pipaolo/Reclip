import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/popular_video/popular_video_bloc.dart';

import '../bloc/add_content/add_content_bloc.dart';
import '../bloc/add_video/add_video_bloc.dart';
import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/bloc/connectivity_bloc.dart';
import '../bloc/drawer/drawer_bloc.dart';
import '../bloc/illustration/illustrations_bloc.dart';
import '../bloc/info/info_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/other_user/other_user_bloc.dart';
import '../bloc/reclip_user/reclipuser_bloc.dart';
import '../bloc/signup/signup_bloc.dart';
import '../bloc/user/user_bloc.dart';
import '../bloc/verification/verification_bloc.dart';
import '../bloc/video/video_bloc.dart';
import '../core/reclip_colors.dart';
import '../core/router/route_generator.gr.dart';
import '../core/styling.dart';
import '../repository/firebase_reclip_repository.dart';
import '../repository/illustration_repository.dart';
import '../repository/user_repository.dart';
import '../repository/video_repository.dart';
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
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context))
            ..add(
              AppStarted(),
            ),
        ),
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
        BlocProvider<PopularVideoBloc>(
          create: (context) => PopularVideoBloc(
              videoRepository: context.repository<VideoRepository>()),
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
            firebaseReclipRepository:
                RepositoryProvider.of<FirebaseReclipRepository>(context),
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
        builder: (context, widget) => MediaQuery(
          data: DevicePreview.mediaQuery(context),
          child: Theme(
            data: Theme.of(context).copyWith(
              platform: DevicePreview.platform(context),
            ),
            child: ExtendedNavigator<Router>(
              router: Router(),
              initialRoute: Routes.splashPageRoute,
            ),
          ),
        ),
      ),
    );
  }
}
