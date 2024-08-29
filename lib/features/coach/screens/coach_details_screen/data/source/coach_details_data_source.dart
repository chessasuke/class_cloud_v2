import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final coachDetailsDataSource = Provider(
  (ref) => CoachDetailsDataSource(firestoreClient: ref.read(firestoreClient)),
);

class CoachDetailsDataSource {
  CoachDetailsDataSource({required this.firestoreClient});

  final FirestoreClient firestoreClient;

  Future<Coach?> fetchCoachById({required String coachId}) async {
    final coachsRef = firestoreClient.constructTypedCollectionReference<Coach>(
      collectionPath: Collections.coaches,
      fromFirestore: (snapshot, _) => Coach.fromJson(snapshot.data()!),
      toFirestore: (coach, _) => coach.toJson(),
    );
    try {
      final coach = await firestoreClient.fetchDocumentById<Coach>(
        collectionRef: coachsRef,
        documentId: coachId,
      );
      if (coach != null) {
        return coach;
      } else {
        return null;
      }
    } catch (e) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error fetching Coach: $e');
    }
    return null;
  }
}
