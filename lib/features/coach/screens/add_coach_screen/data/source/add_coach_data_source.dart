import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final addCoachDataSource = Provider(
  (ref) => AddCoachDataSource(firestoreClient: ref.read(firestoreClient)),
);

class AddCoachDataSource {
  AddCoachDataSource({
    required this.firestoreClient,
  });

  final FirestoreClient firestoreClient;

  String get generateCoachId {
    final ref = firestoreClient.constructCollectionReference(
      Collections.coaches,
    );
    return ref.doc().id;
  }

  Future<String?> addCoach({required Coach coach}) async {
    try {
      final coachsRef =
          firestoreClient.constructTypedCollectionReference<Coach>(
        collectionPath: Collections.coaches,
        fromFirestore: (snapshot, _) => Coach.fromJson(snapshot.data()!),
        toFirestore: (coach, _) => coach.toJson(),
      );
      await firestoreClient.setDocument<Coach>(
        documentRef: coachsRef.doc(coach.id),
        data: coach,
      );
      return coach.id;
    } catch (e) {
      Logger(LoggerConstants.coach)
          .log(Level.SHOUT, 'Error adding Coach: $e');
    }
    return null;
  }
}
