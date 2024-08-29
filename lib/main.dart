import 'package:class_cloud/core/app/app.dart';
import 'package:class_cloud/core/app/app_firebase_initialization.dart';
import 'package:class_cloud/core/clients/shared_preferences_client/shared_preferences_client.dart';
import 'package:class_cloud/core/services/package_info_service/package_info_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appFirebaseInitialization(useEmulators: false & kDebugMode);

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ],
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final configuredApp = ProviderScope(
    overrides: [
      sharedPreferencesProvider
          .overrideWithValue(await SharedPreferences.getInstance()),
      packageInfoServiceProvider
          .overrideWithValue(await PackageInfo.fromPlatform()),
    ],
    child: const App(),
  );
  print(' ---- run app');
  runApp(configuredApp);
}
