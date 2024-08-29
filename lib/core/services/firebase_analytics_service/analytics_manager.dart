import 'package:class_cloud/core/services/firebase_analytics_service/models/event.dart';
import 'package:class_cloud/core/services/firebase_analytics_service/models/user_property.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final analyticsManagerProvider = Provider((ref) => AnalyticsManager());

class AnalyticsManager {
  final PublishSubject<Event> _eventPublisher = PublishSubject<Event>();
  final PublishSubject<UserProperty> _propertyPublisher =
      PublishSubject<UserProperty>();

  void trackEvent(Event event) => _eventPublisher.add(event);
  void setUserProperty(UserProperty property) =>
      _propertyPublisher.add(property);

  PublishSubject<Event> get eventPublisher => _eventPublisher;
  PublishSubject<UserProperty> get propertyPublisher => _propertyPublisher;
}
