import 'dart:async';
import 'dart:io';
import 'dart:math' as math;


import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/features/shake_detector/data/model/shake_detector.dart';
import 'package:class_cloud/features/shake_detector/data/repository/shake_detector_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

part 'shake_detector_state.dart';

class ShakeDetectorCubit extends Cubit<ShakeDetectorState> {
  ShakeDetectorCubit({
    required this.shakesTarget,
    required this.timeWindowInMiliseconds,
    required this.accelerometerRepository,
  }) : super(const IdleState(ShakeDetectorSensitivity.off));

  final AccelerometerRepository accelerometerRepository;

  StreamSubscription<AccelerometerEvent?>? _accelerometerSubscription;

  final int shakesTarget;
  final int timeWindowInMiliseconds;

  /// First waits for the app to be initialized and then starts listening to the /// accelerometer stream and emits [ShakingState] when the device is shaken /// [shakesTarget] times within a time window of [timeWindowInMiliseconds]. /// One shake is considered when the root mean square of the acceleration of /// an [AccelerometerEvent] reaches an acceleration target. The acceleration /// target is determined by the [ShakeDetectorSensitivity].

  Future<void> start() async {
    /// After app initialization, start listening to the accelerometer stream. /// iOS devices are less sensitive to shakes, so the initial sensitivity is /// set to low, while in android is set to medium. /// User can change the default value in the developer mode.

    emit(
      IdleState(
        Platform.isIOS
            ? ShakeDetectorSensitivity.low
            : ShakeDetectorSensitivity.medium,
      ),
    );
  }

  void _listenAccelerometerStream() async {
    /// Dont start the shake detector on the appstore environment.
    // if (Environments.appstore) {
    //   return;
    // }

    DateTime? lastProcessedTime;
    int shakeCount = 0;

    await _accelerometerSubscription?.cancel();
    _accelerometerSubscription =
        accelerometerRepository.getUserAccelerometerStream().listen(
      (AccelerometerEvent? event) {
        // If the shake detector is disabled or event is null, dont do anything.

        if (!state.isEnabled || event == null) return;

        // The root mean square of the acceleration of a UserAccelerometerEvent.

        final rms = math.sqrt(
          math.pow(event.x, 2) + math.pow(event.y, 2) + math.pow(event.z, 2),
        );

        // If the device is shaken [shakesTarget] times within a time window of // [timeWindowInMiliseconds] emit [ShakingState]. Next reset the shake // counter to 0, and emit [IdleState].

        final currentTime = DateTime.now();
        if (rms >= state.sensitivity.rmsAccelerationTarget) {
          Logger(LoggerConstants.shakeDetector).info('Device Shaken');
          shakeCount++;
          if (shakeCount >= shakesTarget &&
              (lastProcessedTime == null ||
                  currentTime.difference(lastProcessedTime!) >=
                      Duration(milliseconds: timeWindowInMiliseconds))) {
            lastProcessedTime = currentTime;
            shakeCount = 0;
            emit(ShakingState(state.sensitivity));
          }
        } else {
          shakeCount = 0;
        }
        emit(IdleState(state.sensitivity));
      },
    );
  }

  /// Changes the sensitivity of the shake detector. /// /// The sensitivity determines the root mean square (RMS) acceleration target /// that the device must reach to be considered as shaken.

  void setSensitivity(ShakeDetectorSensitivity sensitivity) {
    emit(IdleState(sensitivity));
  }

  @override
  void onChange(Change<ShakeDetectorState> change) {
    // If the shake detector is disabled, don't listen to events.

    if (change.currentState.isEnabled && !change.nextState.isEnabled) {
      _accelerometerSubscription?.cancel();
    } else if (!change.currentState.isEnabled && change.nextState.isEnabled) {
      _listenAccelerometerStream();
    }
    super.onChange(change);
  }

  @override
  Future<void> close() {
    _accelerometerSubscription?.cancel();
    return super.close();
  }
}
