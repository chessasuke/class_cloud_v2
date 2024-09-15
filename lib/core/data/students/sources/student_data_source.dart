import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_utils.dart';
import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentDataSource = Provider<StudentDataSource>(
  (ref) => StudentDataSource(
    firestore: ref.read(firestoreClient),
  ),
);

class StudentDataSource {
  StudentDataSource({
    required FirestoreClient firestore,
  }) : _firestore = firestore;

  final FirestoreClient _firestore;

  Future<List<Student>?> fetchStudents() async {
    final studentsRef = _firestore.constructTypedCollectionReference<Student>(
      collectionPath: Collections.students,
      fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
      toFirestore: (student, _) => student.toJson(),
    );

    try {
      final students =
          await _firestore.fetchDocuments(collectionRef: studentsRef);
      if (students != null) {
        return students;
      } else {
        return null;
      }
    } catch (e) {
      print(' ---- fetchStudents error: ${e.toString()}');
      return null;
    }
  }

  Future<List<Student>?> queryStudents(
    String school,
  ) async {
    final studentsRef = _firestore.constructTypedCollectionReference<Student>(
      collectionPath: Collections.students,
      fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
      toFirestore: (student, _) => student.toJson(),
    );

    try {
      final students = await _firestore.queryByValueComparison(
        collection: studentsRef,
        field: 'school',
        value: school,
        comparison: FirestoreFilterComparison.isEqualTo,
      );
      if (students != null) {
        return students;
      } else {
        return null;
      }
    } catch (e) {
      print(' ---- queryStudents error: ${e.toString()}');
      return null;
    }
  }
}
