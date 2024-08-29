import 'package:class_cloud/features/shake_detector/data/model/shake_detector.dart';

abstract class AccelerometerRepository {
  Stream<AccelerometerEvent?> getUserAccelerometerStream();
}