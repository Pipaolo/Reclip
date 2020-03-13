import 'package:reclip/ui/content_creator_page/add_content/add_content_image/add_content_image_page.dart';
import 'package:reclip/ui/content_creator_page/add_content/content_creator_add_content_page.dart';
import 'package:reclip/ui/content_creator_page/profile_page/content_creator_profile_page.dart';
import 'package:reclip/ui/content_creator_page/profile_page/edit_profile_page/content_creator_edit_profile_page.dart';
import 'package:reclip/ui/custom_wigets/other_profile_page/other_profile_page.dart';
import 'package:reclip/ui/home_page/home_page.dart';
import 'package:reclip/ui/login_page/login_page.dart';
import 'package:reclip/ui/signup_page/signup_page.dart';
import 'package:sailor/sailor.dart';

import '../bottom_nav_controller.dart';
import '../ui/signup_page/signup_category_page.dart';
import '../ui/signup_page/signup_content_creator/signup_content_creator_fifth_page.dart';
import '../ui/signup_page/signup_content_creator/signup_content_creator_first_page.dart';
import '../ui/signup_page/signup_content_creator/signup_content_creator_fourth_page.dart';
import '../ui/signup_page/signup_content_creator/signup_content_creator_second_page.dart';
import '../ui/signup_page/signup_content_creator/signup_content_creator_sixth_page.dart';
import '../ui/signup_page/signup_content_creator/signup_content_creator_third_page.dart';
import '../ui/signup_page/signup_user/signup_user.dart';
import '../ui/splash_page/splash_page.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes([
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
          name: 'signup_page/user',
          builder: (context, args, params) {
            return SignupUserPage();
          }),
      SailorRoute(
          name: 'signup_page/content_creator/first_page',
          builder: (context, args, params) {
            return SignupContentCreatorFirstPage(
              args: args,
            );
          }),
      SailorRoute(
          name: 'signup_page/content_creator/second_page',
          builder: (context, args, params) {
            return SignupContentCreatorSecondPage(args: args);
          }),
      SailorRoute(
          name: 'signup_page/content_creator/third_page',
          builder: (context, args, params) {
            return SignupContentCreatorThirdPage(args: args);
          }),
      SailorRoute(
          name: 'signup_page/content_creator/fourth_page',
          builder: (context, args, params) {
            return SignupContentCreatorFourthPage(args: args);
          }),
      SailorRoute(
          name: 'signup_page/content_creator/fifth_page',
          builder: (context, args, params) {
            return SignupContentCreatorFifthPage(args: args);
          }),
      SailorRoute(
          name: 'signup_page/content_creator/sixth_page',
          builder: (context, args, params) {
            return SignupContentCreatorSixthPage(args: args);
          })
    ]);

    sailor.addRoutes([
      SailorRoute(
          name: 'add_content_image_page',
          builder: (context, args, params) {
            return AddContentImagePage(
              args: args,
            );
          }),
    ]);

    sailor.addRoute(SailorRoute(
        name: 'bottom_nav_bar_controller',
        builder: (context, args, params) {
          return BottomNavBarController(
            args: args,
          );
        }));

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
          name: 'login_page',
          builder: (context, args, params) {
            return LoginPage();
          },
          defaultTransitions: [SailorTransition.slide_from_bottom],
        ),
        SailorRoute(
          name: 'user_home_page',
          builder: (context, args, params) {
            return HomePage();
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
        SailorRoute(
          name: 'user_profile_page',
          builder: (context, args, params) {
            return ContentCreatorProfilePage();
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
        SailorRoute(
          name: 'user_add_content_page',
          builder: (context, args, params) {
            return ContentCreatorAddContentPage(
              args: args,
            );
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        ),
        SailorRoute(
            name: 'other_user_profile_page',
            builder: (context, args, params) {
              return OtherProfilePage();
            }),
        SailorRoute(
          name: 'user_edit_profile_page',
          builder: (context, args, params) {
            return ContentCreatorEditProfilePage(args: args);
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        )
      ],
    );
  }
}
