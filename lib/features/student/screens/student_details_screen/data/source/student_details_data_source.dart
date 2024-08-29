import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final studentDetailsDataSource = Provider(
  (ref) => StudentDetailsDataSource(firestoreClient: ref.read(firestoreClient)),
);

class StudentDetailsDataSource {
  StudentDetailsDataSource({required this.firestoreClient});

  final FirestoreClient firestoreClient;

  Future<Student?> fetchStudentById({required String studentId}) async {
    final studentsRef =
        firestoreClient.constructTypedCollectionReference<Student>(
      collectionPath: Collections.students,
      fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
      toFirestore: (student, _) => student.toJson(),
    );
    try {
      final student = await firestoreClient.fetchDocumentById<Student>(
        collectionRef: studentsRef,
        documentId: studentId,
      );
      if (student != null) {
        return student;
      } else {
        return null;
      }
    } catch (e) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error fetching Student: $e');
    }
    return null;
  }
}
