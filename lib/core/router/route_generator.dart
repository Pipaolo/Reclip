import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:reclip/ui/custom_wigets/illustration_content_page/illustration_content_page.dart';

import '../../bottom_nav_controller.dart';
import '../../ui/content_creator_page/add_content/add_content_image/add_content_image_page.dart';
import '../../ui/content_creator_page/add_content/add_content_video/add_content_video_page.dart';
import '../../ui/content_creator_page/add_content/content_creator_add_content_page.dart';
import '../../ui/content_creator_page/profile_page/content_creator_profile_page.dart';
import '../../ui/content_creator_page/profile_page/edit_profile_page/content_creator_edit_profile_page.dart';
import '../../ui/custom_wigets/other_profile_page/other_profile_page.dart';
import '../../ui/custom_wigets/video_content_page/video_content_page.dart';
import '../../ui/home_page/home_page.dart';
import '../../ui/login_page/login_page.dart';
import '../../ui/signup_page/signup_category_page.dart';
import '../../ui/signup_page/signup_content_creator/signup_content_creator_fifth_page.dart';
import '../../ui/signup_page/signup_content_creator/signup_content_creator_first_page.dart';
import '../../ui/signup_page/signup_content_creator/signup_content_creator_fourth_page.dart';
import '../../ui/signup_page/signup_content_creator/signup_content_creator_second_page.dart';
import '../../ui/signup_page/signup_content_creator/signup_content_creator_third_page.dart';
import '../../ui/signup_page/signup_user/signup_user.dart';
import '../../ui/splash_page/splash_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashPage splashPageRoute;

  //Login Page
  LoginPage loginPageRoute;

  //Home Page
  HomePage homePageRoute;

  //Sign up page Routes
  SignupCategoryPage signupCategoryPageRoute;
  SignupUserPage signupUserPageRoute;

  SignupContentCreatorFirstPage signupContentCreatorFirstPageRoute;
  SignupContentCreatorSecondPage signupContentCreatorSecondPageRoute;
  SignupContentCreatorThirdPage signupContentCreatorThirdPageRoute;
  SignupContentCreatorFourthPage signupContentCreatorFourthPageRoute;
  SignupContentCreatorFifthPage signupContentCreatorFifthPageRoute;

  //ContentCreator Routes
  ContentCreatorAddContentPage contentCreatorAddContentPageRoute;
  ContentCreatorProfilePage contentCreatorProfilePageRoute;
  ContentCreatorEditProfilePage contentCreatorEditProfilePageRoute;

  //Add Content Routes
  AddContentImagePage addContentImagePageRoute;
  AddContentVideoPage addContentVideoPageRoute;

  //Bottom Nav Screen
  BottomNavBarController bottomNavBarControllerScreenRoute;

  //Content Pages
  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideBottom,
      durationInMilliseconds: 400)
  VideoContentPage videoContentPageRoute;
  @CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideBottom,
      durationInMilliseconds: 200)
  IllustrationContentPage illustrationContentPageRoute;

  //Misc
  OtherProfilePage otherProfilePageRoute;
}
