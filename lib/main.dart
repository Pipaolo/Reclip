import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reclip/bloc/bloc/navigation_bloc.dart';
import 'package:reclip/core/reclip_colors.dart';
import 'package:reclip/core/route_generator.dart';
import 'package:reclip/ui/login_page/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Routes.createRoutes();
  runApp(Reclip());
}

class Reclip extends StatelessWidget {
  const Reclip({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
      create: (context) =>
          NavigationBloc(navigatorKey: Routes.sailor.navigatorKey),
      child: MaterialApp(
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
