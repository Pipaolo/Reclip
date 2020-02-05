import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

ScrollController useScrollControllerForAnimation(
  AnimationController animationController,
) {
  ScrollController scrollController = ScrollController();
  scrollController.addListener(() {
    switch (scrollController.position.userScrollDirection) {
      case ScrollDirection.forward:
        animationController.forward();
        break;
      case ScrollDirection.reverse:
        animationController.reverse();
        break;
      case ScrollDirection.idle:
        break;
    }
  });
  return scrollController;
}
