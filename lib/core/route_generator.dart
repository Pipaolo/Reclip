import 'package:reclip/ui/bottom_nav_controller.dart';
import 'package:reclip/ui/signup_page/signup_category_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_first_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_fourth_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_second_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_third_page.dart';
import 'package:reclip/ui/signup_page/signup_credentials_page.dart';
import 'package:reclip/ui/splash_page/splash_page.dart';
import 'package:reclip/ui/ui.dart';
import 'package:reclip/ui/user_page/add_content/add_content_image/add_content_image_page.dart';
import 'package:reclip/ui/user_page/profile_page/edit_profile_page/edit_profile_page.dart';
import 'package:reclip/ui/user_page/profile_page/other_profile_page/other_profile_page.dart';
import 'package:sailor/sailor.dart';

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
          return SignupCategoryPage(
            args: args,
          );
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
        SailorRoute(
            name: 'other_user_profile_page',
            builder: (context, args, params) {
              return OtherProfilePage(
                args: args,
              );
            }),
        SailorRoute(
          name: 'user_edit_profile_page',
          builder: (context, args, params) {
            return UserEditProfilePage(args: args);
          },
          defaultTransitions: [SailorTransition.slide_from_right],
        )
      ],
    );
  }
}
