import 'dart:async';
import 'dart:convert';

import 'package:class_cloud/core/clients/shared_preferences_client/shared_preferences_failures.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/core/services/reporter/reporter_mixin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

final sharedPreferencesClient = Provider<SharedPreferencesClient>((ref) {
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  return SharedPreferencesClient(sharedPreferences: sharedPreferences);
});

class SharedPreferencesClient with ReporterMixin {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesClient({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  bool? getBool(String key) {
    try {
      final value = _sharedPreferences.getBool(key);
      return value;
    } catch (ex, st) {
      // If we get an error that is related to variable casting,
      // we remove this key to clean the storage from inconsistent values
      // added in the past.
      if (ex is TypeError) _sharedPreferences.remove(key);

      Logger(
        LoggerConstants.sharedPreferences,
      ).shout('Failed reading Bool value, key: $key');

      final failure = SharedPreferencesFailure(title: key, error: ex);
      reportFailure(
        failure,
        st,
        message: 'Failed reading Bool value, key: $key',
      );
      return null;
    }
  }

  Map<String, dynamic>? getMap(String key) {
    try {
      final value = _sharedPreferences.getString(key);
      return value == null ? null : Map.from(jsonDecode(value));
    } catch (ex, st) {
      // If we get an error that is related to variable casting,
      // we remove this key to clean the storage from inconsistent values
      // added in the past.
      if (ex is TypeError) _sharedPreferences.remove(key);
      Logger(LoggerConstants.sharedPreferences)
          .shout('Failed reading Map value, key: $key');
      final failure = SharedPreferencesFailure(title: key, error: ex);
      reportFailure(
        failure,
        st,
        message: 'Failed reading Map value, key: $key',
      );
      return null;
    }
  }

  String? getString(String key) {
    try {
      final value = _sharedPreferences.getString(key);
      return value;
    } catch (ex, st) {
      // If we get an error that is related to variable casting,
      // we remove this key to clean the storage from inconsistent values
      // added in the past.
      if (ex is TypeError) _sharedPreferences.remove(key);

      Logger(LoggerConstants.sharedPreferences)
          .shout('Failed reading String value, key: $key');

      final failure = SharedPreferencesFailure(title: key, error: ex);
      reportFailure(
        failure,
        st,
        message: 'Failed reading String value, key: $key',
      );
      return null;
    }
  }

  List<String>? getStringList(String key) {
    try {
      final value = _sharedPreferences.getStringList(key);
      return value;
    } catch (ex, st) {
      // If we get an error that is related to variable casting,
      // we remove this key to clean the storage from inconsistent values
      // added in the past.
      if (ex is TypeError) _sharedPreferences.remove(key);

      Logger(LoggerConstants.sharedPreferences)
          .shout('Failed reading String List value, key: $key');

      final failure = SharedPreferencesFailure(title: key, error: ex);
      reportFailure(
        failure,
        st,
        message: 'Failed reading String List value, key: $key',
      );
      return null;
    }
  }

  int? getInt(String key) {
    try {
      final value = _sharedPreferences.getInt(key);
      return value;
    } catch (ex, st) {
      // If we get an error that is related to variable casting,
      // we remove this key to clean the storage from inconsistent values
      // added in the past.
      if (ex is TypeError) _sharedPreferences.remove(key);

      Logger(LoggerConstants.sharedPreferences)
          .shout('Failed reading int value, key: $key');

      final failure = SharedPreferencesFailure(title: key, error: ex);
      reportFailure(
        failure,
        st,
        message: 'Failed reading int value, key: $key',
      );
      return null;
    }
  }

  Future<bool> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  Future<bool> setMap(String key, Map<String, dynamic> value) {
    return _sharedPreferences.setString(key, jsonEncode(value));
  }

  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  Future<bool> setInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }
}
