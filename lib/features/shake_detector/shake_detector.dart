
import 'package:class_cloud/features/shake_detector/cubit/shake_detector_cubit.dart';
import 'package:class_cloud/features/shake_detector/data/repository/shake_detector_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart' show UserAccelerometerEvent;

/// A widget that detects device shakes. /// /// This widget is used to detect device shakes and call the [onShake] callback /// when the device is shaken [shakesTarget] times within a time window of /// [timeWindowInMiliseconds]. /// If the user doesnt shake the device [shakesTarget] times within the /// [timeWindowInMiliseconds] the shake counter is reset to 0. /// A shake is considered when the root mean square /// of the acceleration of a [UserAccelerometerEvent] reaches the /// acceleration target. /// This is a common way to measure object vibrations.

class ShakeDetector extends ConsumerWidget {
  const ShakeDetector({
    required this.child,
    required this.onShake,
    this.shakesTarget = 4,
    this.timeWindowInMiliseconds = 1000,
    super.key,
  });
  final Widget child;
  final VoidCallback onShake;
  final int shakesTarget;
  final int timeWindowInMiliseconds;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider<ShakeDetectorCubit>(
      create: (context) => ShakeDetectorCubit(
        shakesTarget: shakesTarget,
        timeWindowInMiliseconds: timeWindowInMiliseconds,
        accelerometerRepository: ref.read(accelerometerRepository),
      )..start(),
      child: BlocListener<ShakeDetectorCubit, ShakeDetectorState>(
        listenWhen: (previous, current) =>
            previous is IdleState && current is ShakingState,
        listener: (context, state) {
          if (state is ShakingState) {
            onShake.call();
          }
        },
        child: child,
      ),
    );
  }
}
