import 'package:class_cloud/core/clients/shared_preferences_client/shared_preferences_client.dart';
import 'package:class_cloud/core/data/preferences/models/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const encodedUserModifiedFeaturesKey = 'encoded_user_modified_feaures';
const fcmTokenKey = 'saved_fcm_token';
const shouldShowNotificationsMessageKey = 'should_show_notifications_message';
const isNotificationsRegisteredKey = 'is_notifications_registered';

final preferencesLocalDataSourceProvider = Provider(
  (ref) => PreferencesLocalDataSource(
    sharedPreferencesClient: ref.watch(sharedPreferencesClient),
  ),
);

/// A data source class that provides access to Preference related operations
/// via the [SharedPreferencesClient].
class PreferencesLocalDataSource {
  final SharedPreferencesClient _sharedPreferencesClient;

  /// Constructs a new instance of [PreferencesLocalDataSource].
  PreferencesLocalDataSource({
    required SharedPreferencesClient sharedPreferencesClient,
  }) : _sharedPreferencesClient = sharedPreferencesClient;

  /// Loads the preferences from the shared preferences.
  Preferences loadPreferences() {
    return Preferences(
      savedFcmToken: fcmToken,
      encodedUserModifiedFeaures: encodedUserModifiedFeaures,
      shouldShowNotificationsMessage: shouldShowNotificationsMessage,
      isNotificationsRegistered: isNotificationsRegistered,
    );
  }

  String get fcmToken {
    final value = _sharedPreferencesClient.getString(fcmTokenKey);
    if (value == null) {
      const defaultValue = '';
      _sharedPreferencesClient.setString(fcmTokenKey, defaultValue);
      return defaultValue;
    }
    return value;
  }

  set fcmToken(String value) {
    _sharedPreferencesClient.setString(fcmTokenKey, value);
  }

  String get encodedUserModifiedFeaures {
    final value =
        _sharedPreferencesClient.getString(encodedUserModifiedFeaturesKey);
    if (value == null) {
      const defaultValue = '';
      _sharedPreferencesClient.setString(
        encodedUserModifiedFeaturesKey,
        defaultValue,
      );
      return defaultValue;
    }
    return value;
  }

  set encodedUserModifiedFeaures(String value) {
    _sharedPreferencesClient.setString(encodedUserModifiedFeaturesKey, value);
  }

  bool get shouldShowNotificationsMessage {
    final value =
        _sharedPreferencesClient.getBool(shouldShowNotificationsMessageKey);
    if (value == null) {
      const defaultValue = false;
      _sharedPreferencesClient.setBool(
        shouldShowNotificationsMessageKey,
        defaultValue,
      );
      return defaultValue;
    }
    return value;
  }

  set shouldShowNotificationsMessage(bool value) {
    _sharedPreferencesClient.setBool(
      shouldShowNotificationsMessageKey,
      value,
    );
  }

  bool get isNotificationsRegistered {
    final value =
        _sharedPreferencesClient.getBool(isNotificationsRegisteredKey);
    if (value == null) {
      const defaultValue = false;
      _sharedPreferencesClient.setBool(
        isNotificationsRegisteredKey,
        defaultValue,
      );
      return defaultValue;
    }
    return value;
  }

  set isNotificationsRegistered(bool value) {
    _sharedPreferencesClient.setBool(
      isNotificationsRegisteredKey,
      value,
    );
  }
}
