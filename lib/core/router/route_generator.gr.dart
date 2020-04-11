// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:reclip/ui/splash_page/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reclip/ui/login_page/login_page.dart';
import 'package:reclip/ui/home_page/home_page.dart';
import 'package:reclip/ui/signup_page/signup_category_page.dart';
import 'package:reclip/ui/signup_page/signup_user/signup_user.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_first_page.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_second_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_third_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_fourth_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_fifth_page.dart';
import 'package:reclip/ui/content_creator_page/add_content/content_creator_add_content_page.dart';
import 'package:reclip/ui/content_creator_page/profile_page/content_creator_profile_page.dart';
import 'package:reclip/ui/content_creator_page/profile_page/edit_profile_page/content_creator_edit_profile_page.dart';
import 'package:reclip/ui/content_creator_page/add_content/add_content_image/add_content_image_page.dart';
import 'package:reclip/ui/content_creator_page/add_content/add_content_video/add_content_video_page.dart';
import 'package:reclip/ui/bottom_navigation_controller/bottom_nav_controller.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/custom_widgets/video_content_page/video_content_page.dart';
import 'package:reclip/data/model/video.dart';
import 'package:reclip/ui/custom_widgets/illustration_content_page/illustration_content_page.dart';
import 'package:reclip/data/model/illustration.dart';
import 'package:reclip/ui/custom_widgets/other_profile_page/other_profile_page.dart';

abstract class Routes {
  static const splashPageRoute = '/';
  static const loginPageRoute = '/login-page-route';
  static const homePageRoute = '/home-page-route';
  static const signupCategoryPageRoute = '/signup-category-page-route';
  static const signupUserPageRoute = '/signup-user-page-route';
  static const signupContentCreatorFirstPageRoute =
      '/signup-content-creator-first-page-route';
  static const signupContentCreatorSecondPageRoute =
      '/signup-content-creator-second-page-route';
  static const signupContentCreatorThirdPageRoute =
      '/signup-content-creator-third-page-route';
  static const signupContentCreatorFourthPageRoute =
      '/signup-content-creator-fourth-page-route';
  static const signupContentCreatorFifthPageRoute =
      '/signup-content-creator-fifth-page-route';
  static const contentCreatorAddContentPageRoute =
      '/content-creator-add-content-page-route';
  static const contentCreatorProfilePageRoute =
      '/content-creator-profile-page-route';
  static const contentCreatorEditProfilePageRoute =
      '/content-creator-edit-profile-page-route';
  static const addContentImagePageRoute = '/add-content-image-page-route';
  static const addContentVideoPageRoute = '/add-content-video-page-route';
  static const bottomNavBarControllerScreenRoute =
      '/bottom-nav-bar-controller-screen-route';
  static const videoContentPageRoute = '/video-content-page-route';
  static const illustrationContentPageRoute =
      '/illustration-content-page-route';
  static const otherProfilePageRoute = '/other-profile-page-route';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashPageRoute:
        if (hasInvalidArgs<SplashPageArguments>(args)) {
          return misTypedArgsRoute<SplashPageArguments>(args);
        }
        final typedArgs = args as SplashPageArguments ?? SplashPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SplashPage(key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.loginPageRoute:
        if (hasInvalidArgs<LoginPageArguments>(args)) {
          return misTypedArgsRoute<LoginPageArguments>(args);
        }
        final typedArgs = args as LoginPageArguments ?? LoginPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.homePageRoute:
        if (hasInvalidArgs<HomePageArguments>(args)) {
          return misTypedArgsRoute<HomePageArguments>(args);
        }
        final typedArgs = args as HomePageArguments ?? HomePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.signupCategoryPageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignupCategoryPage(),
          settings: settings,
        );
      case Routes.signupUserPageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignupUserPage(),
          settings: settings,
        );
      case Routes.signupContentCreatorFirstPageRoute:
        if (hasInvalidArgs<SignupContentCreatorFirstPageArguments>(args)) {
          return misTypedArgsRoute<SignupContentCreatorFirstPageArguments>(
              args);
        }
        final typedArgs = args as SignupContentCreatorFirstPageArguments ??
            SignupContentCreatorFirstPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignupContentCreatorFirstPage(
              key: typedArgs.key, contentCreator: typedArgs.contentCreator),
          settings: settings,
        );
      case Routes.signupContentCreatorSecondPageRoute:
        if (hasInvalidArgs<SignupContentCreatorSecondPageArguments>(args)) {
          return misTypedArgsRoute<SignupContentCreatorSecondPageArguments>(
              args);
        }
        final typedArgs = args as SignupContentCreatorSecondPageArguments ??
            SignupContentCreatorSecondPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignupContentCreatorSecondPage(
              key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.signupContentCreatorThirdPageRoute:
        if (hasInvalidArgs<SignupContentCreatorThirdPageArguments>(args)) {
          return misTypedArgsRoute<SignupContentCreatorThirdPageArguments>(
              args);
        }
        final typedArgs = args as SignupContentCreatorThirdPageArguments ??
            SignupContentCreatorThirdPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignupContentCreatorThirdPage(
              key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.signupContentCreatorFourthPageRoute:
        if (hasInvalidArgs<SignupContentCreatorFourthPageArguments>(args)) {
          return misTypedArgsRoute<SignupContentCreatorFourthPageArguments>(
              args);
        }
        final typedArgs = args as SignupContentCreatorFourthPageArguments ??
            SignupContentCreatorFourthPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignupContentCreatorFourthPage(
              key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.signupContentCreatorFifthPageRoute:
        if (hasInvalidArgs<SignupContentCreatorFifthPageArguments>(args)) {
          return misTypedArgsRoute<SignupContentCreatorFifthPageArguments>(
              args);
        }
        final typedArgs = args as SignupContentCreatorFifthPageArguments ??
            SignupContentCreatorFifthPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignupContentCreatorFifthPage(
              key: typedArgs.key,
              user: typedArgs.user,
              profileImage: typedArgs.profileImage),
          settings: settings,
        );
      case Routes.contentCreatorAddContentPageRoute:
        if (hasInvalidArgs<ContentCreatorAddContentPageArguments>(args)) {
          return misTypedArgsRoute<ContentCreatorAddContentPageArguments>(args);
        }
        final typedArgs = args as ContentCreatorAddContentPageArguments ??
            ContentCreatorAddContentPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ContentCreatorAddContentPage(
              key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.contentCreatorProfilePageRoute:
        if (hasInvalidArgs<ContentCreatorProfilePageArguments>(args)) {
          return misTypedArgsRoute<ContentCreatorProfilePageArguments>(args);
        }
        final typedArgs = args as ContentCreatorProfilePageArguments ??
            ContentCreatorProfilePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ContentCreatorProfilePage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.contentCreatorEditProfilePageRoute:
        if (hasInvalidArgs<ContentCreatorEditProfilePageArguments>(args)) {
          return misTypedArgsRoute<ContentCreatorEditProfilePageArguments>(
              args);
        }
        final typedArgs = args as ContentCreatorEditProfilePageArguments ??
            ContentCreatorEditProfilePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => ContentCreatorEditProfilePage(
              key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.addContentImagePageRoute:
        if (hasInvalidArgs<AddContentImagePageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<AddContentImagePageArguments>(args);
        }
        final typedArgs = args as AddContentImagePageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => AddContentImagePage(
              key: typedArgs.key, image: typedArgs.image, user: typedArgs.user),
          settings: settings,
        );
      case Routes.addContentVideoPageRoute:
        if (hasInvalidArgs<AddContentVideoPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<AddContentVideoPageArguments>(args);
        }
        final typedArgs = args as AddContentVideoPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => AddContentVideoPage(
              key: typedArgs.key,
              video: typedArgs.video,
              contentCreator: typedArgs.contentCreator),
          settings: settings,
        );
      case Routes.bottomNavBarControllerScreenRoute:
        if (hasInvalidArgs<BottomNavBarControllerArguments>(args)) {
          return misTypedArgsRoute<BottomNavBarControllerArguments>(args);
        }
        final typedArgs = args as BottomNavBarControllerArguments ??
            BottomNavBarControllerArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => BottomNavBarController(
                  key: typedArgs.key,
                  contentCreator: typedArgs.contentCreator,
                  user: typedArgs.user)
              .wrappedRoute,
          settings: settings,
        );
      case Routes.videoContentPageRoute:
        if (hasInvalidArgs<VideoContentPageArguments>(args)) {
          return misTypedArgsRoute<VideoContentPageArguments>(args);
        }
        final typedArgs =
            args as VideoContentPageArguments ?? VideoContentPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) => VideoContentPage(
              video: typedArgs.video,
              email: typedArgs.email,
              contentCreator: typedArgs.contentCreator),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideBottom,
          transitionDuration: const Duration(milliseconds: 200),
        );
      case Routes.illustrationContentPageRoute:
        if (hasInvalidArgs<IllustrationContentPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<IllustrationContentPageArguments>(args);
        }
        final typedArgs = args as IllustrationContentPageArguments;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              IllustrationContentPage(
                  key: typedArgs.key, illustration: typedArgs.illustration),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideBottom,
          transitionDuration: const Duration(milliseconds: 200),
        );
      case Routes.otherProfilePageRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => OtherProfilePage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//SplashPage arguments holder class
class SplashPageArguments {
  final Key key;
  final FirebaseUser user;
  SplashPageArguments({this.key, this.user});
}

//LoginPage arguments holder class
class LoginPageArguments {
  final Key key;
  LoginPageArguments({this.key});
}

//HomePage arguments holder class
class HomePageArguments {
  final Key key;
  HomePageArguments({this.key});
}

//SignupContentCreatorFirstPage arguments holder class
class SignupContentCreatorFirstPageArguments {
  final Key key;
  final ReclipContentCreator contentCreator;
  SignupContentCreatorFirstPageArguments({this.key, this.contentCreator});
}

//SignupContentCreatorSecondPage arguments holder class
class SignupContentCreatorSecondPageArguments {
  final Key key;
  final ReclipContentCreator user;
  SignupContentCreatorSecondPageArguments({this.key, this.user});
}

//SignupContentCreatorThirdPage arguments holder class
class SignupContentCreatorThirdPageArguments {
  final Key key;
  final ReclipContentCreator user;
  SignupContentCreatorThirdPageArguments({this.key, this.user});
}

//SignupContentCreatorFourthPage arguments holder class
class SignupContentCreatorFourthPageArguments {
  final Key key;
  final ReclipContentCreator user;
  SignupContentCreatorFourthPageArguments({this.key, this.user});
}

//SignupContentCreatorFifthPage arguments holder class
class SignupContentCreatorFifthPageArguments {
  final Key key;
  final ReclipContentCreator user;
  final File profileImage;
  SignupContentCreatorFifthPageArguments(
      {this.key, this.user, this.profileImage});
}

//ContentCreatorAddContentPage arguments holder class
class ContentCreatorAddContentPageArguments {
  final Key key;
  final ReclipContentCreator user;
  ContentCreatorAddContentPageArguments({this.key, this.user});
}

//ContentCreatorProfilePage arguments holder class
class ContentCreatorProfilePageArguments {
  final Key key;
  ContentCreatorProfilePageArguments({this.key});
}

//ContentCreatorEditProfilePage arguments holder class
class ContentCreatorEditProfilePageArguments {
  final Key key;
  final ReclipContentCreator user;
  ContentCreatorEditProfilePageArguments({this.key, this.user});
}

//AddContentImagePage arguments holder class
class AddContentImagePageArguments {
  final Key key;
  final File image;
  final ReclipContentCreator user;
  AddContentImagePageArguments({this.key, @required this.image, this.user});
}

//AddContentVideoPage arguments holder class
class AddContentVideoPageArguments {
  final Key key;
  final File video;
  final ReclipContentCreator contentCreator;
  AddContentVideoPageArguments(
      {this.key, @required this.video, @required this.contentCreator});
}

//BottomNavBarController arguments holder class
class BottomNavBarControllerArguments {
  final Key key;
  final ReclipContentCreator contentCreator;
  final ReclipUser user;
  BottomNavBarControllerArguments({this.key, this.contentCreator, this.user});
}

//VideoContentPage arguments holder class
class VideoContentPageArguments {
  final Video video;
  final String email;
  final ReclipContentCreator contentCreator;
  VideoContentPageArguments({this.video, this.email, this.contentCreator});
}

//IllustrationContentPage arguments holder class
class IllustrationContentPageArguments {
  final Key key;
  final Illustration illustration;
  IllustrationContentPageArguments({this.key, @required this.illustration});
}
