import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:reclip/bloc/navigation/navigation_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/repository/youtube_repository.dart';
import 'package:reclip/ui/login_page/login_page.dart';
import 'package:sailor/sailor.dart';

import 'bloc/youtube/youtube_bloc.dart';
import 'core/keys.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Routes.createRoutes();
  runApp(Reclip());
}

class Reclip extends StatelessWidget {
  const Reclip({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) =>
              NavigationBloc(navigatorKey: Routes.sailor.navigatorKey),
        ),
        BlocProvider<YoutubeBloc>(
          create: (context) => YoutubeBloc(
            youtubeRepository: YoutubeRepository(
              ytApi: YoutubeApi(
                clientViaApiKey(Keys.youtubeApiKey),
              ),
            ),
          )..add(FetchYoutubeVideo()),
        )
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
        home: LoginPage(),
      ),
    );
  }
}
