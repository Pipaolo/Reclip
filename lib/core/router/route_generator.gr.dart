// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:reclip/ui/splash_page/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reclip/ui/login_page/login_page.dart';
import 'package:reclip/ui/home_page/home_page.dart';
import 'package:reclip/ui/signup_page/signup_category_page.dart';
import 'package:reclip/ui/signup_page/signup_user/signup_user.dart';
import 'package:reclip/data/model/reclip_user.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_first_page.dart';
import 'package:reclip/data/model/reclip_content_creator.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_second_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_third_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_fourth_page.dart';
import 'package:reclip/ui/signup_page/signup_content_creator/signup_content_creator_fifth_page.dart';
import 'dart:io';
import 'package:reclip/ui/content_creator_page/add_content/content_creator_add_content_page.dart';
import 'package:reclip/ui/content_creator_page/profile_page/content_creator_profile_page.dart';
import 'package:reclip/ui/content_creator_page/profile_page/edit_profile_page/content_creator_edit_profile_page.dart';
import 'package:reclip/ui/content_creator_page/add_content/add_content_image/add_content_image_page.dart';
import 'package:reclip/ui/content_creator_page/add_content/add_content_video/add_content_video_page.dart';
import 'package:reclip/ui/bottom_navigation_controller/bottom_nav_controller.dart';
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
  static const all = [
    splashPageRoute,
    loginPageRoute,
    homePageRoute,
    signupCategoryPageRoute,
    signupUserPageRoute,
    signupContentCreatorFirstPageRoute,
    signupContentCreatorSecondPageRoute,
    signupContentCreatorThirdPageRoute,
    signupContentCreatorFourthPageRoute,
    signupContentCreatorFifthPageRoute,
    contentCreatorAddContentPageRoute,
    contentCreatorProfilePageRoute,
    contentCreatorEditProfilePageRoute,
    addContentImagePageRoute,
    addContentVideoPageRoute,
    bottomNavBarControllerScreenRoute,
    videoContentPageRoute,
    illustrationContentPageRoute,
    otherProfilePageRoute,
  ];
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
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) =>
              SplashPage(key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.loginPageRoute:
        if (hasInvalidArgs<LoginPageArguments>(args)) {
          return misTypedArgsRoute<LoginPageArguments>(args);
        }
        final typedArgs = args as LoginPageArguments ?? LoginPageArguments();
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => LoginPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.homePageRoute:
        if (hasInvalidArgs<HomePageArguments>(args)) {
          return misTypedArgsRoute<HomePageArguments>(args);
        }
        final typedArgs = args as HomePageArguments ?? HomePageArguments();
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => HomePage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.signupCategoryPageRoute:
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => SignupCategoryPage(),
          settings: settings,
        );
      case Routes.signupUserPageRoute:
        if (hasInvalidArgs<SignupUserPageArguments>(args)) {
          return misTypedArgsRoute<SignupUserPageArguments>(args);
        }
        final typedArgs =
            args as SignupUserPageArguments ?? SignupUserPageArguments();
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => SignupUserPage(
              key: typedArgs.key, unregisteredUser: typedArgs.unregisteredUser),
          settings: settings,
        );
      case Routes.signupContentCreatorFirstPageRoute:
        if (hasInvalidArgs<SignupContentCreatorFirstPageArguments>(args)) {
          return misTypedArgsRoute<SignupContentCreatorFirstPageArguments>(
              args);
        }
        final typedArgs = args as SignupContentCreatorFirstPageArguments ??
            SignupContentCreatorFirstPageArguments();
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => SignupContentCreatorFirstPage(
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
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => SignupContentCreatorSecondPage(
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
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => SignupContentCreatorThirdPage(
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
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => SignupContentCreatorFourthPage(
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
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => SignupContentCreatorFifthPage(
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
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => ContentCreatorAddContentPage(
              key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.contentCreatorProfilePageRoute:
        if (hasInvalidArgs<ContentCreatorProfilePageArguments>(args)) {
          return misTypedArgsRoute<ContentCreatorProfilePageArguments>(args);
        }
        final typedArgs = args as ContentCreatorProfilePageArguments ??
            ContentCreatorProfilePageArguments();
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => ContentCreatorProfilePage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.contentCreatorEditProfilePageRoute:
        if (hasInvalidArgs<ContentCreatorEditProfilePageArguments>(args)) {
          return misTypedArgsRoute<ContentCreatorEditProfilePageArguments>(
              args);
        }
        final typedArgs = args as ContentCreatorEditProfilePageArguments ??
            ContentCreatorEditProfilePageArguments();
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => ContentCreatorEditProfilePage(
              key: typedArgs.key, user: typedArgs.user),
          settings: settings,
        );
      case Routes.addContentImagePageRoute:
        if (hasInvalidArgs<AddContentImagePageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<AddContentImagePageArguments>(args);
        }
        final typedArgs = args as AddContentImagePageArguments;
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => AddContentImagePage(
              key: typedArgs.key, image: typedArgs.image, user: typedArgs.user),
          settings: settings,
        );
      case Routes.addContentVideoPageRoute:
        if (hasInvalidArgs<AddContentVideoPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<AddContentVideoPageArguments>(args);
        }
        final typedArgs = args as AddContentVideoPageArguments;
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => AddContentVideoPage(
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
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => BottomNavBarController(
                  key: typedArgs.key,
                  contentCreator: typedArgs.contentCreator,
                  user: typedArgs.user)
              .wrappedRoute(context),
          settings: settings,
        );
      case Routes.videoContentPageRoute:
        if (hasInvalidArgs<VideoContentPageArguments>(args)) {
          return misTypedArgsRoute<VideoContentPageArguments>(args);
        }
        final typedArgs =
            args as VideoContentPageArguments ?? VideoContentPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              VideoContentPage(
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
          pageBuilder: (context, animation, secondaryAnimation) =>
              IllustrationContentPage(
                      key: typedArgs.key, illustration: typedArgs.illustration)
                  .wrappedRoute(context),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.slideBottom,
          transitionDuration: const Duration(milliseconds: 200),
        );
      case Routes.otherProfilePageRoute:
        return buildAdaptivePageRoute<dynamic>(
          builder: (context) => OtherProfilePage(),
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

//SignupUserPage arguments holder class
class SignupUserPageArguments {
  final Key key;
  final ReclipUser unregisteredUser;
  SignupUserPageArguments({this.key, this.unregisteredUser});
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

//**************************************************************************
// Navigation helper methods extension
//***************************************************************************

extension RouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushSplashPageRoute({
    Key key,
    FirebaseUser user,
  }) =>
      pushNamed(Routes.splashPageRoute,
          arguments: SplashPageArguments(key: key, user: user));
  Future pushLoginPageRoute({
    Key key,
  }) =>
      pushNamed(Routes.loginPageRoute, arguments: LoginPageArguments(key: key));
  Future pushHomePageRoute({
    Key key,
  }) =>
      pushNamed(Routes.homePageRoute, arguments: HomePageArguments(key: key));
  Future pushSignupCategoryPageRoute() =>
      pushNamed(Routes.signupCategoryPageRoute);
  Future pushSignupUserPageRoute({
    Key key,
    ReclipUser unregisteredUser,
  }) =>
      pushNamed(Routes.signupUserPageRoute,
          arguments: SignupUserPageArguments(
              key: key, unregisteredUser: unregisteredUser));
  Future pushSignupContentCreatorFirstPageRoute({
    Key key,
    ReclipContentCreator contentCreator,
  }) =>
      pushNamed(Routes.signupContentCreatorFirstPageRoute,
          arguments: SignupContentCreatorFirstPageArguments(
              key: key, contentCreator: contentCreator));
  Future pushSignupContentCreatorSecondPageRoute({
    Key key,
    ReclipContentCreator user,
  }) =>
      pushNamed(Routes.signupContentCreatorSecondPageRoute,
          arguments:
              SignupContentCreatorSecondPageArguments(key: key, user: user));
  Future pushSignupContentCreatorThirdPageRoute({
    Key key,
    ReclipContentCreator user,
  }) =>
      pushNamed(Routes.signupContentCreatorThirdPageRoute,
          arguments:
              SignupContentCreatorThirdPageArguments(key: key, user: user));
  Future pushSignupContentCreatorFourthPageRoute({
    Key key,
    ReclipContentCreator user,
  }) =>
      pushNamed(Routes.signupContentCreatorFourthPageRoute,
          arguments:
              SignupContentCreatorFourthPageArguments(key: key, user: user));
  Future pushSignupContentCreatorFifthPageRoute({
    Key key,
    ReclipContentCreator user,
    File profileImage,
  }) =>
      pushNamed(Routes.signupContentCreatorFifthPageRoute,
          arguments: SignupContentCreatorFifthPageArguments(
              key: key, user: user, profileImage: profileImage));
  Future pushContentCreatorAddContentPageRoute({
    Key key,
    ReclipContentCreator user,
  }) =>
      pushNamed(Routes.contentCreatorAddContentPageRoute,
          arguments:
              ContentCreatorAddContentPageArguments(key: key, user: user));
  Future pushContentCreatorProfilePageRoute({
    Key key,
  }) =>
      pushNamed(Routes.contentCreatorProfilePageRoute,
          arguments: ContentCreatorProfilePageArguments(key: key));
  Future pushContentCreatorEditProfilePageRoute({
    Key key,
    ReclipContentCreator user,
  }) =>
      pushNamed(Routes.contentCreatorEditProfilePageRoute,
          arguments:
              ContentCreatorEditProfilePageArguments(key: key, user: user));
  Future pushAddContentImagePageRoute({
    Key key,
    @required File image,
    ReclipContentCreator user,
  }) =>
      pushNamed(Routes.addContentImagePageRoute,
          arguments:
              AddContentImagePageArguments(key: key, image: image, user: user));
  Future pushAddContentVideoPageRoute({
    Key key,
    @required File video,
    @required ReclipContentCreator contentCreator,
  }) =>
      pushNamed(Routes.addContentVideoPageRoute,
          arguments: AddContentVideoPageArguments(
              key: key, video: video, contentCreator: contentCreator));
  Future pushBottomNavBarControllerScreenRoute({
    Key key,
    ReclipContentCreator contentCreator,
    ReclipUser user,
  }) =>
      pushNamed(Routes.bottomNavBarControllerScreenRoute,
          arguments: BottomNavBarControllerArguments(
              key: key, contentCreator: contentCreator, user: user));
  Future pushVideoContentPageRoute({
    Video video,
    String email,
    ReclipContentCreator contentCreator,
  }) =>
      pushNamed(Routes.videoContentPageRoute,
          arguments: VideoContentPageArguments(
              video: video, email: email, contentCreator: contentCreator));
  Future pushIllustrationContentPageRoute({
    Key key,
    @required Illustration illustration,
  }) =>
      pushNamed(Routes.illustrationContentPageRoute,
          arguments: IllustrationContentPageArguments(
              key: key, illustration: illustration));
  Future pushOtherProfilePageRoute() => pushNamed(Routes.otherProfilePageRoute);
}
