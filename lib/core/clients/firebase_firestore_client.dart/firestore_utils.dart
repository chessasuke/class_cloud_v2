import 'package:cloud_firestore/cloud_firestore.dart';

enum FirestoreFilterComparison {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
}

/// Build a Firestore [Query] from a filter [comparison]
Query<T> buildComparisonFilter<T>({
  required Query<T> query,
  required Object field,
  required Object value,
  required FirestoreFilterComparison comparison,
}) {
  switch (comparison) {
    case FirestoreFilterComparison.isEqualTo:
      return query.where(field, isEqualTo: value);
    case FirestoreFilterComparison.isNotEqualTo:
      return query.where(field, isNotEqualTo: value);
    case FirestoreFilterComparison.isLessThan:
      return query.where(field, isLessThan: value);
    case FirestoreFilterComparison.isLessThanOrEqualTo:
      return query.where(field, isLessThanOrEqualTo: value);
    case FirestoreFilterComparison.isGreaterThan:
      return query.where(field, isGreaterThan: value);
    case FirestoreFilterComparison.isGreaterThanOrEqualTo:
      return query.where(field, isGreaterThanOrEqualTo: value);
    case FirestoreFilterComparison.arrayContains:
      return query.where(field, arrayContains: value);
  }
}
