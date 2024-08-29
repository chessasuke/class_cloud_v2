import 'dart:io';

import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

part 'device_info_service_impl.dart';

abstract class DeviceInfoService {
  Future<Map<String, Object?>?> fetchDeviceInfo();

  Future<String?> get deviceId;
}
