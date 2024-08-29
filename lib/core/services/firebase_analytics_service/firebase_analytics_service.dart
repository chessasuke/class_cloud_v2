
import 'package:class_cloud/core/services/firebase_analytics_service/analytics_manager.dart';
import 'package:class_cloud/core/services/firebase_analytics_service/models/event.dart';
import 'package:class_cloud/core/services/firebase_analytics_service/models/user_property.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  FirebaseAnalyticsService(this.analyticsManager) {
    _analytics = FirebaseAnalytics.instance;
    if (isInterestedInEvents()) {
      subscribeToEvents();
    }

    if (isInterestedInUserProperties()) {
      subscribeToUserProperties();
    }
  }

  late AnalyticsManager analyticsManager;
  static late final FirebaseAnalytics _analytics;

  bool isInterestedInEvents() => true;
  bool isInterestedInUserProperties() => true;

  void subscribeToEvents() {
    analyticsManager.eventPublisher
        .where((event) => acceptEvent(event))
        .map((event) => transformEvent(event))
        .listen((value) {
      reportEvent(value);
    });
  }

  void subscribeToUserProperties() {
    analyticsManager.propertyPublisher
        .where((property) => acceptUserProperty(property))
        .map((property) => transformProperty(property))
        .listen((value) {
      reportProperty(value);
    });
  }

  bool acceptEvent(Event event) => true;
  Event transformEvent(Event event) => event;

  bool acceptUserProperty(UserProperty property) => true;
  UserProperty transformProperty(UserProperty property) => property;

  void reportEvent(Event event) {
    _analytics.logEvent(
      name: event.name,
      parameters: event.params,
    );
  }

  void reportProperty(UserProperty property) {
    _analytics.setUserProperty(
      name: property.key,
      value: property.value,
    );
  }
}
