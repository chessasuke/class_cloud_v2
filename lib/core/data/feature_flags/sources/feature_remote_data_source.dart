import 'package:class_cloud/core/data/feature_flags/cubit/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final featuresRemoteDataSource = Provider((ref) => FeaturesRemoteDataSource());

/// A data source class that provides access to [Features] related operations.
///
/// This classwill use firebase remote config eventually, for now using
/// deafult values.
class FeaturesRemoteDataSource {
  /// Constructs a new instance of [FeaturesRemoteDataSource].
  FeaturesRemoteDataSource() {
    _features.add(getExperimentFlags());
  }

  /// Stream exposing the local live feature flags.
  late final features = _features.stream;
  final _features = BehaviorSubject<Map<String, Object>>();

  /// Fetches all the experiments.
  Map<String, Object> getExperimentFlags() {
    final Map<String, Object> flags = {};
    for (var flag in Feature.values) {
      flags[flag.key] = flag.defaultValue;
    }
    return flags;
  }
}
