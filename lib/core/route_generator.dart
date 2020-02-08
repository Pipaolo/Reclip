import 'package:reclip/ui/signup_page/signup_category_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_first_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_second_page.dart';
import 'package:reclip/ui/signup_page/signup_credentials_page.dart';
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
          name: 'signup_page/category',
          builder: (context, args, params) {
            return SignupCategoryPage();
          },
        ),
        SailorRoute(
            name: 'signup_page/credentials',
            builder: (context, args, params) {
              return SignupCredentialsPage();
            }),
        SailorRoute(
            name: 'signup_page/content_creator/first_page',
            builder: (context, args, params) {
              return SignupContentCreatorFirstPage();
            }),
        SailorRoute(
            name: 'signup_page/content_creator/second_page',
            builder: (context, args, params) {
              return SignupContentCreatorSecondPage();
            }),
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
