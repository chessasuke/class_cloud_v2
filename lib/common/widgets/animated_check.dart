import 'package:flutter/material.dart';

class AnimatedCheck extends StatefulWidget {
  const AnimatedCheck({
    this.iconSize = 15,
    this.circleSize = 20,
    super.key,
  });

  final double iconSize;
  final double circleSize;

  @override
  AnimatedCheckState createState() => AnimatedCheckState();
}

class AnimatedCheckState extends State<AnimatedCheck>
    with TickerProviderStateMixin {
  late AnimationController scaleController = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {
    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Container(
        height: widget.circleSize,
        width: widget.circleSize,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: SizeTransition(
          sizeFactor: checkAnimation,
          axis: Axis.horizontal,
          axisAlignment: -1,
          child: Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: widget.iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
