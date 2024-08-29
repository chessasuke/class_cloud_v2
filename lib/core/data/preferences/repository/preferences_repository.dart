import 'package:class_cloud/core/data/preferences/models/preferences.dart';
import 'package:rxdart/rxdart.dart';

/// Interface for a repository that provides access to [Preferences] related
/// operations.
abstract class PreferencesRepository {
  /// Stream exposing the current [Preferences] in vigor.
  abstract final ValueStream<Preferences> preferences;

  /// Current state of [preferences].
  Preferences get state;

  /// Gets a stream that emits only the selected property of the [Experiments].
  ///
  /// The [selector] function should take an [Experiments] object and return
  /// the desired property of that object.
  ///
  /// The stream only emits distinct values.
  Stream<T> only<T>(
    T Function(Preferences preferences) selector,
  ) {
    return preferences.map(selector).distinct();
  }

  /// Returns the FCM token.
  String get fcmToken;

  /// Sets the FCM token.
  set fcmToken(String value);

  /// Returns the encoded feature flags.
  String get encodedUserModifiedFeatures;

  /// Returns the encoded feature flags.
  set encodedUserModifiedFeatures(String value);

  /// Returns the encoded feature flags.
  bool get shouldShowNotificationsMessage;

  /// Returns the encoded feature flags.
  set shouldShowNotificationsMessage(bool value);

  /// Returns the encoded feature flags.
  bool get isNotificationsRegistered;

  /// Returns the encoded feature flags.
  set isNotificationsRegistered(bool value);
}
