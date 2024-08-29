part of 'shake_detector_cubit.dart';

/// The sensitivity of the shake detector.
///
/// The sensitivity determines the root mean square (RMS) acceleration target
/// that the device must reach to be considered as shaken.
/// Higher sensitivity means the device must be shaken harder

enum ShakeDetectorSensitivity {
  off(0),
  veryLow(5),
  low(10),
  medium(20),
  high(30),
  veryHigh(35);

  final int rmsAccelerationTarget;
  const ShakeDetectorSensitivity(this.rmsAccelerationTarget);
  bool get isEnabled => this != ShakeDetectorSensitivity.off;
}

sealed class ShakeDetectorState extends Equatable {
  const ShakeDetectorState(this.sensitivity);
  final ShakeDetectorSensitivity sensitivity;
  @override
  List<Object?> get props => [sensitivity];
  bool get isEnabled => sensitivity != ShakeDetectorSensitivity.off;
}

class ShakingState extends ShakeDetectorState {
  const ShakingState(super.sensitivity);
}

class IdleState extends ShakeDetectorState {
  const IdleState(super.sensitivity);
}
