import 'package:equatable/equatable.dart';

class Features extends Equatable {
  const Features(this.featureMap);

  final Map<String, Object?> featureMap;

  @override
  List<Object?> get props => [featureMap];
}

enum Feature {
  mockWavFile(
    'mock_file',
    false,
  );

  const Feature(this.key, this.defaultValue);

  final String key;
  final Object defaultValue;
}
