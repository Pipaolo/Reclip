import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/notification/notification_bloc.dart';
import 'repository/firebase_reclip_repository.dart';
import 'repository/illustration_repository.dart';
import 'repository/user_repository.dart';
import 'repository/video_repository.dart';
import 'ui/app_widget.dart';

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
        child: ReclipApp(),
      ),
    ),
  );
}

//Note: ang pogi ni Samuel D. Garcia ng 12 Java
