import 'package:class_cloud/core/services/environment_service/environment_service.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

const String androidHost = "10.0.2.2";
const String localHost = "localhost";

enum UseFirebaseEmulators {
  auth(
    isUsed: false,
    host: localHost,
    port: 9099,
  ),
  functions(
    isUsed: true,
    host: androidHost,
    port: 5001,
  ),
  firestore(
    isUsed: false,
    host: localHost,
    port: 8080,
  ),
  storage(
    isUsed: false,
    host: localHost,
    port: 9199,
  );

  final bool isUsed;
  final String host;
  final int port;

  const UseFirebaseEmulators({
    required this.isUsed,
    required this.host,
    required this.port,
  });
}

/// Toggle useEmulators to turn on/off the emulators and local development
Future<void> appFirebaseInitialization({
  bool useEmulators = false,
  bool useFirebaseAnalytics = true,
}) async {
  Logger(LoggerConstants.appInitialization).log(
    Level.INFO,
    '---- appFirebaseInitialization useEmulators: $useEmulators | kDebugMode: $kDebugMode',
  );

  await Firebase.initializeApp(
    options: EnvironmentType.getFirebaseOptionsFromEnv(),
  );

  Logger(LoggerConstants.appInitialization).log(
    Level.INFO,
    ' ---- useEmulators: $useEmulators | firestore: ${UseFirebaseEmulators.firestore.isUsed} | functions: ${UseFirebaseEmulators.functions.isUsed} | auth: ${UseFirebaseEmulators.auth.isUsed} | storage: ${UseFirebaseEmulators.storage.isUsed}',
  );

  if (useEmulators) {
    try {
      if (UseFirebaseEmulators.firestore.isUsed) {
        FirebaseFirestore.instance.useFirestoreEmulator(
          UseFirebaseEmulators.firestore.host,
          UseFirebaseEmulators.firestore.port,
        );
      }
      if (UseFirebaseEmulators.auth.isUsed) {
        await FirebaseAuth.instance.useAuthEmulator(
          UseFirebaseEmulators.auth.host,
          UseFirebaseEmulators.auth.port,
        );
      }
    } catch (e) {
      Logger(LoggerConstants.appInitialization).log(
        Level.SEVERE,
        'Error setting up Firebase Emulators: $e',
      );
    }
  }

  if (useFirebaseAnalytics) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack);
      return true;
    };
  }
}
