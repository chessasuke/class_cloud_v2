import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final addSchoolDataSource = Provider(
  (ref) => AddSchoolDataSource(firestoreClient: ref.read(firestoreClient)),
);

class AddSchoolDataSource {
  AddSchoolDataSource({
    required this.firestoreClient,
  });

  final FirestoreClient firestoreClient;

  String get generateSchoolId {
    final ref = firestoreClient.constructCollectionReference(
      Collections.schools,
    );
    return ref.doc().id;
  }

  Future<String?> addSchool({required School school}) async {
    try {
      final schoolsRef = firestoreClient
          .constructTypedCollectionReference<SchoolWithoutCourses>(
        collectionPath: Collections.schools,
        fromFirestore: (snapshot, _) =>
            SchoolWithoutCourses.fromJson(snapshot.data()!),
        toFirestore: (school, _) => school.toJson(),
      );

      final coursePath =
          schoolsRef.doc(school.id).collection(SubCollections.courses).path;

      final coursesRef =
          firestoreClient.constructTypedCollectionReference<Course>(
        collectionPath: coursePath,
        fromFirestore: (snapshot, _) => Course.fromJson(snapshot.data()!),
        toFirestore: (course, _) => course.toJson(),
      );

      final batch = firestoreClient.batch;

      batch.set<SchoolWithoutCourses>(
        schoolsRef.doc(school.id),
        school.toSchoolWithoutCourses(),
      );

      final courses = school.courses;
      if(courses == null) return null;

      for (var course in courses) {
        batch.set<Course>(
          coursesRef.doc(course.id),
          course,
        );
      }
      await batch.commit();
    } catch (e) {
      Logger(LoggerConstants.school)
          .log(Level.SHOUT, 'Error adding school: $e');
    }
    return null;
  }
}
