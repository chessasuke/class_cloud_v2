abstract class Fields {
  static const createdAt = 'createdAt';
  static const patientId = 'patientId';
  static const fcmToken = 'token';
}

abstract class Docuemnts {}

abstract class Collections {
  /// Collections
  static const users = 'users';
  static const fcmToken = 'fcm_tokens';
  static const coaches = 'coaches';
  static const students = 'students';
  static const schools = 'schools';
}

abstract class SubCollections {
  /// SubCollections
  static const courses = 'courses';
}
