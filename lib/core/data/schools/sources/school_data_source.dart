import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/schools/models/school.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schoolDataSource = Provider<SchoolDataSource>(
  (ref) => SchoolDataSource(
    firestore: ref.read(firestoreClient),
  ),
);

class SchoolDataSource {
  SchoolDataSource({
    required FirestoreClient firestore,
  }) : _firestore = firestore;

  final FirestoreClient _firestore;

  Future<List<School>?> fetchSchools() async {
    final schoolsRef = _firestore.constructTypedCollectionReference<School>(
      collectionPath: Collections.schools,
      fromFirestore: (snapshot, _) => School.fromJson(snapshot.data()!),
      toFirestore: (school, _) => school.toJson(),
    );

    try {
      final schools =
          await _firestore.fetchDocuments(collectionRef: schoolsRef);
      if (schools != null) {
        return schools;
      } else {
        return null;
      }
    } catch (e) {
      print(' ---- fetchSchools error: ${e.toString()}');
      return null;
    }
  }
}
