import 'package:equatable/equatable.dart';

/// A model class to wrap the sensor plus plugin user accelerometer event data.

class AccelerometerEvent extends Equatable {
  final double x;
  final double y;
  final double z;
  const AccelerometerEvent({
    required this.x,
    required this.y,
    required this.z,
  });
  @override
  List<Object> get props => [x, y, z];
}
