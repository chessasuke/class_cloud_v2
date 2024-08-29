import 'dart:async';

import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class ConsecutiveTapsDetector extends StatefulWidget {
  const ConsecutiveTapsDetector({
    required this.child,
    required this.onTarget,
    this.taget = 5,
    this.timeout = const Duration(seconds: 1),
    super.key,
  });

  final Widget child;
  final VoidCallback onTarget;
  final int taget;
  final Duration timeout;

  @override
  State<ConsecutiveTapsDetector> createState() =>
      _ConsecutiveTapsDetectorState();
}

class _ConsecutiveTapsDetectorState extends State<ConsecutiveTapsDetector> {
  Timer? _timer;
  late int _taps;
  late final int _target;

  @override
  void initState() {
    _taps = 0;
    _target = widget.taget;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _taps++;
        _startTimer();

        if (_taps >= _target) {
          _timer?.cancel();
          _taps = 0;
          widget.onTarget.call();
          Logger(LoggerConstants.developerOptions).info(
            'ConsecutiveTapsDetector: Target reached. Navigating to feature switcher.',
          );
        }
      },
      // onLongPress: () {
      //   if (_taps >= _target) {
      //     _timer?.cancel();
      //     _taps = 0;
      //     widget.onTarget.call();
      //   }
      // },
      child: widget.child,
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 1),
      () => _taps = 0,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
