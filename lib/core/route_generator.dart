import 'package:reclip/ui/splash_page/splash_page.dart';
import 'package:reclip/ui/ui.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes(
      [
        SailorRoute(
          name: 'splash_page',
          builder: (context, args, params) {
            return SplashPage(
              args: args,
            );
          },
          defaultTransitions: [SailorTransition.slide_from_bottom],
        ),
        SailorRoute(
          name: 'signup_page',
          builder: (context, args, params) {
            return SignupPage();
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
        SailorRoute(
          name: 'login_page',
          builder: (context, args, params) {
            return LoginPage();
          },
          defaultTransitions: [SailorTransition.slide_from_bottom],
        ),
        SailorRoute(
          name: 'user_home_page',
          builder: (context, args, params) {
            return UserHomePage(
              args: args,
            );
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
        SailorRoute(
          name: 'user_profile_page',
          builder: (context, args, params) {
            return UserProfilePage(
              args: args,
            );
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
        SailorRoute(
          name: 'user_add_content_page',
          builder: (context, args, params) {
            return UserAddContentPage(
              args: args,
            );
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
      ],
    );
  }
}
