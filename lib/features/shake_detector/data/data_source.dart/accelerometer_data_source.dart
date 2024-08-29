import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

final accelerometerDataSource = Provider((ref) => AccelerometerDataSource());

class AccelerometerDataSource  {
  Stream<UserAccelerometerEvent> getUserAccelerometerStream() {
    return userAccelerometerEventStream();
  }
}