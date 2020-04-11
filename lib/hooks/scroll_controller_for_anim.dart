import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reclip/core/router/route_generator.gr.dart';

ScrollController useScrollControllerForAnimation(
  AnimationController animationController,
) {
  return Hook.use(_ScrollControllerForAnimationHook(
      animationController: animationController));
}

class _ScrollControllerForAnimationHook extends Hook<ScrollController> {
  final AnimationController animationController;

  const _ScrollControllerForAnimationHook({
    @required this.animationController,
  });
  @override
  _ScrollControllerForAnimationHookState createState() =>
      _ScrollControllerForAnimationHookState();
}

class _ScrollControllerForAnimationHookState
    extends HookState<ScrollController, _ScrollControllerForAnimationHook> {
  ScrollController _scrollController;

  @override
  void initHook() {
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      double visibleValue = 1.0;

      if (_scrollController.offset < 0) {
        final percentageScrolled = ((_scrollController.offset.abs() /
                    _scrollController.position.viewportDimension) *
                100)
            .floor();
        visibleValue -= 1;
        if (percentageScrolled == 0) {
          visibleValue = 1;
        }
        hook.animationController.animateTo(visibleValue);

        if (_scrollController.offset.abs() >
            _scrollController.position.viewportDimension / 4) {
          Router.navigator.pop();
          _scrollController.dispose();
        }
      }
    });
  }

  @override
  ScrollController build(BuildContext context) => _scrollController;
}
