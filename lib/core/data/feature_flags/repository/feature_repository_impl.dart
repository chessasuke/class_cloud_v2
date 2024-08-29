import 'package:class_cloud/core/data/feature_flags/cubit/feature.dart';
import 'package:class_cloud/core/data/feature_flags/repository/feature_repository.dart';
import 'package:class_cloud/core/data/feature_flags/sources/feature_local_data_source.dart';
import 'package:class_cloud/core/data/feature_flags/sources/feature_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final featuresRepository = Provider((ref) {
  final featuresLocalSource = ref.watch(featuresLocalDataSource);
  final featuresRemoteSource = ref.watch(featuresRemoteDataSource);

  final localFeatures = featuresLocalSource.getPreferencesSavedFeatures();
  final remoteFeatures = featuresRemoteSource.features.valueOrNull ?? {};
  return FeaturesRepositoryImpl(
    initialValue: Features(remoteFeatures..addAll(localFeatures)),
    featureLocalDataSource: featuresLocalSource,
    featureRemoteDataSource: featuresRemoteSource,
  )..listenFeatures(
      initialLocalFeature: localFeatures,
      initialRemoteFeature: remoteFeatures,
    );
});

/// Implementation of [FeaturesRepository] that uses a
/// [FeaturesLocalDataSource] and an [FeaturesRemoteDataSource]
/// to manage the Features.
class FeaturesRepositoryImpl extends FeaturesRepository {
  /// Constructs a new instance of [FeaturesRepositoryImpl].
  FeaturesRepositoryImpl({
    required Features initialValue,
    required FeaturesLocalDataSource featureLocalDataSource,
    required FeaturesRemoteDataSource featureRemoteDataSource,
  })  : _featureLocalDataSource = featureLocalDataSource,
        _featureRemoteDataSource = featureRemoteDataSource,
        _features = BehaviorSubject.seeded(initialValue);

  final FeaturesLocalDataSource _featureLocalDataSource;
  final FeaturesRemoteDataSource _featureRemoteDataSource;

  final BehaviorSubject<Features> _features;
  @override
  late final currentFeatures = _features.stream;
  @override
  Features get state => _features.stream.value;

  @override
  void listenFeatures({
    required Map<String, Object> initialLocalFeature,
    required Map<String, Object> initialRemoteFeature,
  }) {
    Rx.combineLatest2<Map<String, Object>, Map<String, Object>, Features>(
        _featureLocalDataSource.features.startWith(initialLocalFeature),
        _featureRemoteDataSource.features.startWith(initialRemoteFeature),
        (local, remote) {
      return Features({...Map.from(remote), ...local});
    }).listen(_features.add);
  }

  @override
  Future<bool> overrideFeatures(Map<String, Object> features) {
    return _featureLocalDataSource.updateFeatures(features);
  }

  @override
  Future<bool> resetOverrides() {
    return _featureLocalDataSource.resetFeatures();
  }
}
