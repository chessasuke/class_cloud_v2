import 'package:class_cloud/common/extensions/extensions.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final schoolDetailsDataSource = Provider(
  (ref) => SchoolDetailsDataSource(firestoreClient: ref.read(firestoreClient)),
);

class SchoolDetailsDataSource {
  SchoolDetailsDataSource({required this.firestoreClient});

  final FirestoreClient firestoreClient;

  Future<School?> fetchSchoolById({required String schoolId}) async {
    final schoolsRef =
        firestoreClient.constructTypedCollectionReference<SchoolWithoutCourses>(
      collectionPath: Collections.schools,
      fromFirestore: (snapshot, _) => SchoolWithoutCourses.fromJson(snapshot.data()!),
      toFirestore: (school, _) => school.toJson(),
    );
    try {
      final schoolWithoutCourses = await firestoreClient.fetchDocumentById<SchoolWithoutCourses>(
        collectionRef: schoolsRef,
        documentId: schoolId,
      );

      final coursePath =
          schoolsRef.doc(schoolId).collection(SubCollections.courses).path;

      final coursesRef =
          firestoreClient.constructTypedCollectionReference<Course>(
        collectionPath: coursePath,
        fromFirestore: (snapshot, _) => Course.fromJson(snapshot.data()!),
        toFirestore: (course, _) => course.toJson(),
      );

      final courses = await firestoreClient.fetchDocuments<Course>(
        collectionRef: coursesRef,
      );

      if (schoolWithoutCourses != null && !courses.isNullOrEmpty) {
        return School(
          id: schoolId,
          name: schoolWithoutCourses.name,
          courses: courses!,
        );
      } else {
        return null;
      }
    } catch (e) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error fetching School: $e');
    }
    return null;
  }
}
