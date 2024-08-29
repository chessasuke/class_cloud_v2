import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AppRiveAnimation extends StatefulWidget {
  const AppRiveAnimation({
    required this.assetPath,
    required this.animation,
    this.height,
    this.width = double.infinity,
    super.key,
  });

  final double? height;
  final double? width;
  final String assetPath;
  final String animation;

  @override
  State<AppRiveAnimation> createState() => _AppRiveAnimationState();
}

class _AppRiveAnimationState extends State<AppRiveAnimation> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation(widget.animation);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: RiveAnimation.asset(
        widget.assetPath,
        animations: [widget.animation],
        controllers: [_controller],
      ),
    );
  }
}
