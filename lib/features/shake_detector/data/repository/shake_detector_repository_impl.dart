import 'package:class_cloud/features/shake_detector/data/data_source.dart/accelerometer_data_source.dart';
import 'package:class_cloud/features/shake_detector/data/model/shake_detector.dart';
import 'package:class_cloud/features/shake_detector/data/repository/shake_detector_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accelerometerRepository = Provider(
  (ref) => AccelerometerRepositoryImpl(
    accelerometerDataSource: ref.read(accelerometerDataSource),
  ),
);

class AccelerometerRepositoryImpl extends AccelerometerRepository {
  AccelerometerRepositoryImpl({
    required AccelerometerDataSource accelerometerDataSource,
  }) : _accelerometerDataSource = accelerometerDataSource;
  final AccelerometerDataSource _accelerometerDataSource;
  @override
  Stream<AccelerometerEvent?> getUserAccelerometerStream() {
    return _accelerometerDataSource.getUserAccelerometerStream().map((event) {
      return AccelerometerEvent(
        x: event.x,
        y: event.y,
        z: event.z,
      );
    });
  }
}
