import 'package:class_cloud/core/data/feature_flags/cubit/feature.dart';
import 'package:class_cloud/core/data/feature_flags/repository/feature_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeatureFlagCubit extends Cubit<Features> {
  FeatureFlagCubit({
    required this.featureRepository,
    Features? initialFeatures,
  }) : super(initialFeatures ?? const Features({}));

  FeaturesRepository featureRepository;

  void init() {
    featureRepository.currentFeatures.listen(emit);
  }

  Object? selectFeatureValue(String key) {
    return state.featureMap[key];
  }

  bool get shouldMockFile {
    return state.featureMap['mock_file'] == true;
  }

  // bool get shouldMockResult {
  //   return state.featureMap['upload_to_recording_mock'] == true;
  // }

  void udpateFeature({required MapEntry<String, Object> features}) {
    featureRepository.overrideFeatures(Map.fromEntries([features]));
  }

  void resetFeatures() {
    featureRepository.resetOverrides();
  }
}
