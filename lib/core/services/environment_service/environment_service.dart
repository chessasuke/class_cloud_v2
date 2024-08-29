import 'package:class_cloud/core/services/environment_service/environment_vars.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/firebase/dev/firebase_options.dart'
    as dev_firebase_options;
import 'package:class_cloud/firebase/prod/firebase_options.dart'
    as prod_firebase_options;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final environmentService = Provider<Environment>((ref) {
  return Environment();
});

enum EnvironmentType {
  dev,
  prod;

  static EnvironmentType get fromEnv {
    return switch (appFlavor) {
      'dev' => EnvironmentType.dev,
      'prod' => EnvironmentType.prod,
      _ => EnvironmentType.dev,
    };
  }

  static FirebaseOptions getFirebaseOptionsFromEnv() {
    final env = EnvironmentType.fromEnv;
    switch (env) {
      case dev:
        return dev_firebase_options.DefaultFirebaseOptions.currentPlatform;
      case prod:
        return prod_firebase_options.DefaultFirebaseOptions.currentPlatform;
    }
  }
}

class Environment {
  Environment() {
    environmentType = EnvironmentType.fromEnv;
    switch (environmentType) {
      case EnvironmentType.dev:
        _firebaseStoragePath = EnvironmentConstants.firebaseStoragePathDev;
        break;
      case EnvironmentType.prod:
        _firebaseStoragePath = EnvironmentConstants.firebaseStoragePathProd;
        break;
    }
    Logger(LoggerConstants.user)
        .log(Level.INFO, 'Setting environment - $appFlavor');
  }

  late final EnvironmentType environmentType;
  late final String _firebaseStoragePath;
  String get firebaseStoragePath => _firebaseStoragePath;
}
