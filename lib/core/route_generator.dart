import 'package:reclip/ui/ui.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes(
      [
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
            return UserHomePage();
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
        SailorRoute(
          name: 'user_profile_page',
          builder: (context, args, params) {
            return UserProfilePage();
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
        SailorRoute(
          name: 'user_add_content_page',
          builder: (context, args, params) {
            return UserAddContentPage();
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
      ],
    );
  }
}
