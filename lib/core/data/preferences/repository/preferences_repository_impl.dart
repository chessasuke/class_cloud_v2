import 'package:class_cloud/core/data/preferences/models/preferences.dart';
import 'package:class_cloud/core/data/preferences/repository/preferences_repository.dart';
import 'package:class_cloud/core/data/preferences/sources/preferences_local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final preferencesRepository = Provider(
  (ref) => PreferencesRepositoryImpl(
    initialValue:
        ref.watch(preferencesLocalDataSourceProvider).loadPreferences(),
    preferencesLocalDataSource: ref.watch(preferencesLocalDataSourceProvider),
  ),
);

/// Implementation of [PreferencesRepository] that uses a
/// [PreferencesLocalDataSource] to manage the preferences.
class PreferencesRepositoryImpl extends PreferencesRepository {
  final PreferencesLocalDataSource _preferencesLocalDataSource;
  final BehaviorSubject<Preferences> _preferences;

  @override
  late final preferences = _preferences.stream;

  @override
  Preferences get state => _preferences.value;

  /// Constructs a new instance of [PreferencesRepositoryImpl].
  PreferencesRepositoryImpl({
    required Preferences initialValue,
    required PreferencesLocalDataSource preferencesLocalDataSource,
  })  : _preferencesLocalDataSource = preferencesLocalDataSource,
        _preferences = BehaviorSubject.seeded(initialValue);

  /// FCM Token
  @override
  String get fcmToken => _preferencesLocalDataSource.fcmToken;

  @override
  set fcmToken(String value) {
    _preferencesLocalDataSource.fcmToken = value;
    _preferences.add(_preferences.value.copyWith(savedFcmToken: value));
  }

  /// Feature Flags
  @override
  String get encodedUserModifiedFeatures =>
      _preferencesLocalDataSource.encodedUserModifiedFeaures;

  @override
  set encodedUserModifiedFeatures(String value) {
    _preferencesLocalDataSource.encodedUserModifiedFeaures = value;
    _preferences.add(_preferences.value.copyWith(encodedFeatureFlags: value));
  }

  /// Notifications
  @override
  bool get shouldShowNotificationsMessage =>
      _preferencesLocalDataSource.shouldShowNotificationsMessage;

  @override
  set shouldShowNotificationsMessage(bool value) {
    _preferencesLocalDataSource.shouldShowNotificationsMessage = value;
    _preferences.add(
      _preferences.value.copyWith(shouldShowNotificationsMessage: value),
    );
  }

  @override
  bool get isNotificationsRegistered =>
      _preferencesLocalDataSource.isNotificationsRegistered;

  @override
  set isNotificationsRegistered(bool value) {
    _preferencesLocalDataSource.isNotificationsRegistered = value;
    _preferences
        .add(_preferences.value.copyWith(isNotificationsRegistered: value));
  }
}
