import 'package:flutter/foundation.dart';

class Preferences {
  final String savedFcmToken;
  final String encodedUserModifiedFeaures;
  final bool shouldShowNotificationsMessage;
  final bool isNotificationsRegistered;

  Preferences({
    required this.savedFcmToken,
    required this.encodedUserModifiedFeaures,
    required this.shouldShowNotificationsMessage,
    required this.isNotificationsRegistered,
  });

  Preferences copyWith({
    String? savedFcmToken,
    String? encodedFeatureFlags,
    bool? shouldShowNotificationsMessage,
    bool? isNotificationsRegistered,
  }) {
    return Preferences(
      savedFcmToken: savedFcmToken ?? this.savedFcmToken,
      encodedUserModifiedFeaures:
          encodedFeatureFlags ?? encodedUserModifiedFeaures,
      shouldShowNotificationsMessage:
          shouldShowNotificationsMessage ?? this.shouldShowNotificationsMessage,
      isNotificationsRegistered:
          isNotificationsRegistered ?? this.isNotificationsRegistered,
    );
  }

  @visibleForTesting
  factory Preferences.test({
    String? savedFcmToken,
    String? encodedFeatureFlags,
    bool? shouldShowNotificationsMessage,
    bool? isNotificationsRegistered,
  }) {
    return Preferences(
      savedFcmToken: savedFcmToken ?? '',
      encodedUserModifiedFeaures: encodedFeatureFlags ?? '',
      shouldShowNotificationsMessage: shouldShowNotificationsMessage ?? false,
      isNotificationsRegistered: isNotificationsRegistered ?? false,
    );
  }
}
