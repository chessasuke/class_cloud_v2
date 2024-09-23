import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final addCourseDataSource = Provider(
  (ref) => AddCourseDataSource(firestoreClient: ref.read(firestoreClient)),
);

class AddCourseDataSource {
  AddCourseDataSource({
    required this.firestoreClient,
  });

  final FirestoreClient firestoreClient;

  String get generateCourseId {
    final ref = firestoreClient.constructCollectionReference(
      Collections.courses,
    );
    return ref.doc().id;
  }

  Future<void> addCourse({required Course course}) async {
    try {
      final coursesRef =
          firestoreClient.constructTypedCollectionReference<Course>(
        collectionPath: Collections.courses,
        fromFirestore: (snapshot, _) => Course.fromJson(snapshot.data()!),
        toFirestore: (course, _) => course.toJson(),
      );
      await coursesRef.doc(course.id).set(course);
    } catch (e) {
      Logger(LoggerConstants.course)
          .log(Level.SHOUT, 'Error adding Course: $e');
    }
  }
}
