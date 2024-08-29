import 'dart:convert';

import 'package:class_cloud/core/clients/shared_preferences_client/shared_preferences_client.dart';
import 'package:class_cloud/core/data/preferences/sources/preferences_local_data_source.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

final featuresLocalDataSource = Provider(
  (ref) => FeaturesLocalDataSource(
    sharedPreferencesClient: ref.watch(sharedPreferencesClient),
  ),
);

/// A data source class that provides access to [Features] related operations
/// via the [SharedPreferencesClient].
class FeaturesLocalDataSource {
  final SharedPreferencesClient _sharedPreferencesClient;

  /// Stream exposing the local live feature flags.
  late final features = _features.stream;
  final _features = BehaviorSubject<Map<String, Object>>();

  /// Constructs a new instance of [FeaturesLocalDataSource].
  FeaturesLocalDataSource({
    required SharedPreferencesClient sharedPreferencesClient,
  }) : _sharedPreferencesClient = sharedPreferencesClient {
    _features.add(getPreferencesSavedFeatures());
  }

  /// Fetches the features from the shared preferences.
  Map<String, Object> getPreferencesSavedFeatures() {
    final featuresEncoded =
        _sharedPreferencesClient.getString(encodedUserModifiedFeaturesKey) ??
            '';
    if (featuresEncoded.isEmpty) {
      return {};
    }

    try {
      final result = json.decode(featuresEncoded);
      return Map<String, Object>.from(result);
    } catch (e) {
      Logger(LoggerConstants.sharedPreferences).shout(
        'Failed reading Map value, key: $encodedUserModifiedFeaturesKey',
      );
      _sharedPreferencesClient.setString(encodedUserModifiedFeaturesKey, '');
      return {};
    }
  }

  /// Updates the features saved in the shared preferences.
  Future<bool> updateFeatures(Map<String, Object> features) async {
    final currentMap = getPreferencesSavedFeatures()..addAll(features);
    _features.add(currentMap);
    return _sharedPreferencesClient.setString(
      encodedUserModifiedFeaturesKey,
      json.encode(currentMap),
    );
  }

  /// Removes the features from the shared preferences.
  ///
  /// Returns `true` if the features were successfully deleted, `false`
  /// otherwise.
  Future<bool> resetFeatures() async {
    _features.add({});
    return _sharedPreferencesClient.setString(
      encodedUserModifiedFeaturesKey,
      '',
    );
  }
}
