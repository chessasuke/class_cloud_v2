import 'package:class_cloud/core/data/feature_flags/cubit/feature.dart';
import 'package:rxdart/rxdart.dart';

/// Interface for a repository that provides access to a list of [Feature] related
/// operations.
abstract class FeaturesRepository {
  /// Stream exposing the current [Features].
  abstract final ValueStream<Features> currentFeatures;

  /// Current state of [currentFeatures].
  Features get state;

  /// Starts listening to the [Features] updates.
  ///
  /// The [initialRemoteFeatures] and [initialLocalFeatures] are used
  /// as seeded values for the [currentFeatures] stream. Otherwise there might be
  /// cases where the stream doesn't emit values.
  void listenFeatures({
    required Map<String, Object> initialRemoteFeature,
    required Map<String, Object> initialLocalFeature,
  });

  /// Overrides the values of experiments with the given [Features].
  ///
  /// Returns `true` if the overrides were successfully applied, `false`
  /// otherwise.
  Future<bool> overrideFeatures(Map<String, Object> features);

  /// Resets all [Features] overrides to their default values.
  ///
  /// Returns `true` if the overrides were successfully cleared, `false`
  /// otherwise.
  Future<bool> resetOverrides();

  /// Gets a stream that emits only the selected property of the [Features].
  ///
  /// The [selector] function should take an [Features] object and return
  /// the desired feature of that object.
  ///
  /// The stream only emits distinct values.
  Stream<T> only<T>(
    T Function(Features features) selector,
  ) {
    return currentFeatures.map(selector).distinct();
  }
}
