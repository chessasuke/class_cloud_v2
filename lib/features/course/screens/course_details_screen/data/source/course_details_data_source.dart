import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final courseDetailsDataSource = Provider(
  (ref) => CourseDetailsDataSource(firestoreClient: ref.read(firestoreClient)),
);

class CourseDetailsDataSource {
  CourseDetailsDataSource({required this.firestoreClient});

  final FirestoreClient firestoreClient;

  Future<Course?> fetchCourseById({required String courseId}) async {
    final coursesRef =
        firestoreClient.constructTypedCollectionReference<Course>(
      collectionPath: Collections.courses,
      fromFirestore: (snapshot, _) => Course.fromJson(snapshot.data()!),
      toFirestore: (course, _) => course.toJson(),
    );
    try {
      final course = await firestoreClient.fetchDocumentById<Course>(
        collectionRef: coursesRef,
        documentId: courseId,
      );
      if (course != null) {
        return course;
      } else {
        return null;
      }
    } catch (e) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error fetching Course: $e');
    }
    return null;
  }
}
