import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclip/bloc/authentication/authentication_bloc.dart';

import '../../../core/reclip_colors.dart';
import '../../../data/model/illustration.dart';
import '../../../hooks/scroll_controller_for_anim.dart';
import 'bloc/illustration_overlay_bloc.dart';
import 'illustration_description.dart';
import 'illustration_header.dart';
import 'widgets/illustration_overlay.dart';

class IllustrationContentPage extends HookWidget implements AutoRouteWrapper {
  final Illustration illustration;

  @override
  Widget wrappedRoute(context) => BlocProvider<IllustrationOverlayBloc>(
        create: (context) => IllustrationOverlayBloc(),
        child: this,
      );

  const IllustrationContentPage({Key key, @required this.illustration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hideCloseButtonAnimController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final scrollController =
        useScrollControllerForAnimation(hideCloseButtonAnimController);

    return SafeArea(child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        String currentLoggedInUserEmail = '';
        if (state is AuthenticatedUser) {
          currentLoggedInUserEmail = state.user.email;
        } else if (state is AuthenticatedContentCreator) {
          currentLoggedInUserEmail = state.contentCreator.email;
        }
        return Scaffold(
          body: ListView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            controller: scrollController,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: GestureDetector(
                  onTap: () => context.bloc<IllustrationOverlayBloc>()
                    ..add(IllustrationPressed()),
                  onDoubleTap: () => print(currentLoggedInUserEmail),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: IllustrationHeader(
                          illustration: illustration,
                        ),
                      ),
                      IllustrationOverlay(
                        title: illustration.title,
                      ),
                      _buildCloseButton(context, hideCloseButtonAnimController),
                    ],
                  ),
                ),
              ),
              IllustrationDescription(
                illustration: illustration,
              ),
            ],
          ),
        );
      },
    ));
  }

  _buildCloseButton(
      BuildContext context, AnimationController hideCloseButtonAnimController) {
    return Positioned(
      top: 10.0,
      right: 10.0,
      child: BlocBuilder<IllustrationOverlayBloc, bool>(
        builder: (context, showOverlay) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: (showOverlay) ? 1 : 0,
            child: FadeTransition(
              opacity: hideCloseButtonAnimController,
              child: Material(
                color: reclipBlack.withOpacity(0.5),
                shape: CircleBorder(),
                child: Ink(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.close,
                        color: reclipIndigo,
                        size: ScreenUtil().setSp(20),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
