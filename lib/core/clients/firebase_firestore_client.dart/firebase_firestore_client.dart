import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_failures.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firestore_utils.dart';
import 'package:class_cloud/core/services/logger_service.dart/logger_constants.dart';
import 'package:class_cloud/core/services/reporter/reporter_mixin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

typedef FromFirestore<T> = T Function(
  DocumentSnapshot<Map<String, dynamic>>,
  SnapshotOptions?,
);
typedef ToFirestore<T> = Map<String, dynamic> Function(T, SetOptions?);

final firestoreClient = Provider((ref) => FirestoreClient());

class FirestoreClient with ReporterMixin {
  CollectionReference<T> constructTypedCollectionReference<T>({
    required String collectionPath,
    required FromFirestore<T> fromFirestore,
    required ToFirestore toFirestore,
  }) {
    return FirebaseFirestore.instance.collection(collectionPath).withConverter(
          fromFirestore: fromFirestore,
          toFirestore: toFirestore,
        );
  }

  CollectionReference constructCollectionReference(String collectionPath) {
    return FirebaseFirestore.instance.collection(collectionPath);
  }

  /// Updates data on the document. Data will be merged with any existing document data.
  /// If no document exists yet, the update will fail.
  Future<bool> updateDocument({
    required DocumentReference documentRef,
    required Map<Object, Object?> data,
  }) async {
    try {
      documentRef.update(data);
      return true;
    } catch (e, st) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error updating document: $e');
      reportFailure(
        FirebaseFirestoreFailure(
          title: 'updateDocument',
          error: e,
        ),
        st,
      );
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error updating document: $e');
      return false;
    }
  }

  /// Sets data on the document, overwriting any existing data.
  /// If the document does not yet exist, it will be created.
  Future<void> setDocument<T>({
    required DocumentReference<T> documentRef,
    required T data,
    bool shouldMerge = true,
  }) async {
    try {
      documentRef.set(data, SetOptions(merge: shouldMerge));
    } catch (e, st) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error setting document: $e');
      reportFailure(
        FirebaseFirestoreFailure(
          title: 'setDocument',
          error: e,
        ),
        st,
      );
    }
  }

  Future<T?>? fetchDocumentById<T>({
    required CollectionReference<T> collectionRef,
    required String documentId,
  }) async {
    try {
      final snapshot = await collectionRef.doc(documentId).get();
      final data = snapshot.data();
      if (!snapshot.exists || data == null) return null;
      return data;
    } catch (e, st) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error fetching document by ID: $e');
      reportFailure(
        FirebaseFirestoreFailure(
          title: 'fetchDocumentById',
          error: e,
        ),
        st,
      );
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error fetching document: $e');
      return null;
    }
  }

  Future<List<T>?> fetchDocuments<T>({
    required CollectionReference<T> collectionRef,
    String? field,
    int? limit,
    bool? descending,
  }) async {
    Query<T> query = collectionRef;
    if (descending != null && field != null) {
      query = query.orderBy(field, descending: descending);
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    try {
      final snapshot = await query.get();
      return snapshot.docs.map((document) {
        return document.data();
      }).toList();
    } catch (e, st) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error fetching documents: $e');
      reportFailure(
        FirebaseFirestoreFailure(
          title: 'fetchDocuments',
          error: e,
        ),
        st,
      );
      return null;
    }
  }

  /// Queries a collection by comparing its documents' [field] value with [value].
  /// When [orderBy] is set, it will sort by the field based on the [descending] value.
  /// When limit is set, it will limit the number of items returned to [limit].
  Future<List<T>?> queryByValueComparison<T>({
    required CollectionReference<T> collection,
    required String field,
    required Object value,
    required FirestoreFilterComparison comparison,
    int? limit,
    bool descending = false,
    String? orderBy,
    bool filterArchivedDocuments = false,
  }) async {
    Query<T> query = collection;
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    query = buildComparisonFilter(
      query: query,
      comparison: comparison,
      field: field,
      value: value,
    );
    if (limit != null) {
      query = query.limit(limit);
    }

    try {
      final snapshots = await query.get();
      if (snapshots.docs.isEmpty) return [];
      return snapshots.docs.map((doc) => doc.data()).toList();
    } catch (e, st) {
      Logger(LoggerConstants.firebaseFirestore)
          .log(Level.SHOUT, 'Error querying by value comparison: $e');
      reportFailure(
        FirebaseFirestoreFailure(
          title: 'queryByValueComparison',
          error: e,
        ),
        st,
      );
      return null;
    }
  }

  WriteBatch get batch {
    return FirebaseFirestore.instance.batch();
  }
}
