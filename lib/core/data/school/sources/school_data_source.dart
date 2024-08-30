import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/school/models/course.dart';
import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schoolDataSource = Provider<SchoolesDataSource>(
  (ref) => SchoolesDataSource(
    firestore: ref.read(firestoreClient),
  ),
);

class SchoolesDataSource {
  SchoolesDataSource({
    required FirestoreClient firestore,
  }) : _firestore = firestore;

  final FirestoreClient _firestore;

  Future<List<School>?> fetchSchools() async {
    final schools = <School>[];

    final schoolsRef =
        _firestore.constructTypedCollectionReference<SchoolWithoutCourses>(
      collectionPath: Collections.schools,
      fromFirestore: (snapshot, _) =>
          SchoolWithoutCourses.fromJson(snapshot.data()!),
      toFirestore: (school, _) => school.toJson(),
    );

    try {
      final schoolsWithoutCourses =
          await _firestore.fetchDocuments(collectionRef: schoolsRef);
      if (schoolsWithoutCourses == null) return null;

      for (var school in schoolsWithoutCourses) {
        if (school.id == null || school.name == null) continue;

        final coursePath =
            schoolsRef.doc(school.id).collection(SubCollections.courses).path;

        final coursesRef = _firestore.constructTypedCollectionReference<Course>(
          collectionPath: coursePath,
          fromFirestore: (snapshot, _) => Course.fromJson(snapshot.data()!),
          toFirestore: (course, _) => course.toJson(),
        );

        final courses =
            await _firestore.fetchDocuments(collectionRef: coursesRef);
        if (courses == null) continue;

        for (var course in courses) {
          if (course.id == null ||
              course.courseColor == null ||
              course.dayOfWeek == null ||
              course.timeOfDay == null) continue;
        }

        schools.add(School(
          id: school.id,
          name: school.name,
          courses: courses,
        ));
      }
      return schools;
    } catch (e) {
      print(' ---- fetchStudents error: ${e.toString()}');
      return null;
    }
  }
}
