import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coachesDataSource = Provider<CoachesDataSource>(
  (ref) => CoachesDataSource(
    firestore: ref.read(firestoreClient),
  ),
);

class CoachesDataSource {
  CoachesDataSource({
    required FirestoreClient firestore,
  }) : _firestore = firestore;

  final FirestoreClient _firestore;

  Future<List<Coach>?> fetchCoaches() async {
    final coachesRef = _firestore.constructTypedCollectionReference<Coach>(
      collectionPath: Collections.coaches,
      fromFirestore: (snapshot, _) => Coach.fromJson(snapshot.data()!),
      toFirestore: (coach, _) => coach.toJson(),
    );

    try {
      final coaches =
          await _firestore.fetchDocuments(collectionRef: coachesRef);
      if (coaches != null) {
        return coaches;
      } else {
        return null;
      }
    } catch (e) {
      print(' ---- fetchStudents error: ${e.toString()}');
      return null;
    }
  }
}
