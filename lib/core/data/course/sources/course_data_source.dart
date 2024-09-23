import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/course/model/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final courseDataSource = Provider<CoursesDataSource>(
  (ref) => CoursesDataSource(
    firestore: ref.read(firestoreClient),
  ),
);

class CoursesDataSource {
  CoursesDataSource({
    required FirestoreClient firestore,
  }) : _firestore = firestore;

  final FirestoreClient _firestore;

  Future<List<Course>?> fetchCourses() async {
    final courseRef =
        _firestore.constructTypedCollectionReference<Course>(
      collectionPath: Collections.courses,
      fromFirestore: (snapshot, _) =>
          Course.fromJson(snapshot.data()!),
      toFirestore: (course, _) => course.toJson(),
    );
    try {
      final courses = await courseRef.get();
      return courses.docs.map((e) => e.data()).toList();
    } catch (e) {
      print(' ---- fetchStudents error: ${e.toString()}');
      return null;
    }
  }
}
