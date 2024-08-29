import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/students/models/student.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final addStudentDataSource = Provider(
  (ref) => AddStudentDataSource(firestoreClient: ref.read(firestoreClient)),
);

class AddStudentDataSource {
  AddStudentDataSource({
    required this.firestoreClient,
  });

  final FirestoreClient firestoreClient;

  String get generateStudentId {
    final ref = firestoreClient.constructCollectionReference(
      Collections.students,
    );
    return ref.doc().id;
  }

  Future<String?> addStudent({required Student student}) async {
    try {
      final studentsRef =
          firestoreClient.constructTypedCollectionReference<Student>(
        collectionPath: Collections.students,
        fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
        toFirestore: (student, _) => student.toJson(),
      );
      await firestoreClient.setDocument<Student>(
        documentRef: studentsRef.doc(student.id),
        data: student,
      );
      return student.id;
    } catch (e) {
      Logger(LoggerConstants.student)
          .log(Level.SHOUT, 'Error adding student: $e');
    }
    return null;
  }
}
