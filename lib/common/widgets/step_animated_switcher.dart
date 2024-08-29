import 'package:flutter/material.dart';

class StepAnimatedSwitcher extends StatelessWidget {
  const StepAnimatedSwitcher({
    required this.isReverseAnimation,
    required this.child,
    super.key,
  });

  final Widget child;
  final bool isReverseAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (Widget child, Animation<double> animation) {
        if (animation.status == AnimationStatus.completed) {
          if (isReverseAnimation) {
            return getSlideTransition(true, child, animation);
          } else {
            return getSlideTransition(false, child, animation);
          }
        } else {
          if (isReverseAnimation) {
            return getSlideTransition(false, child, animation);
          } else {
            return getSlideTransition(true, child, animation);
          }
        }
      },
      switchInCurve: const Interval(
        0.3,
        1,
        curve: Curves.easeOutQuart,
      ),
      switchOutCurve: const Interval(
        0.7,
        1,
      ),
      child: child,
    );
  }

  SlideTransition getSlideTransition(
      bool isEnter, Widget child, Animation<double> animation,) {
    if (isEnter) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    } else {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    }
  }
}
