import 'package:class_cloud/core/clients/firebase_auth_client/firebase_auth_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_keys.dart';
import 'package:class_cloud/core/data/user/models/user.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:logging/logging.dart';

class UserRemoteDataSource {
  UserRemoteDataSource({
    required this.firestoreClient,
    required this.authClient,
    User? seedValue,
  });

  final FirestoreClient firestoreClient;
  final FirebaseAuthClient authClient;

  Stream<User?> get userStream {
    return authClient.authChanges.asyncMap((event) async {
      if (event == null) {
        return null;
      } else {
        final user = await _fetchUserInfo(event.uid);
        return user;
      }
    });
  }

  Future<User?> _fetchUserInfo(String uid) async {
    try {
      final userRef =
          firestoreClient.constructTypedCollectionReference<User>(
        collectionPath: Collections.users,
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (cairdioUser, _) => cairdioUser.toJson(),
      );
      return await firestoreClient.fetchDocumentById<User>(
        collectionRef: userRef,
        documentId: uid,
      );
    } catch (e) {
      Logger(LoggerConstants.user).log(Level.SHOUT, 'Error fetching user: $e');
    }
    return null;
  }
}
