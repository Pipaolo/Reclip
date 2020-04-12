import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: DevicePreview(
        enabled: false,
        areSettingsEnabled: true,
        builder: (context) => ReclipApp(),
      ),
    ),
  );
}

//Note: ang pogi ni Samuel D. Garcia ng 12 Java
