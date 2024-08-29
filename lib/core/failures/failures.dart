import 'package:equatable/equatable.dart';

/// Failure base class
///
/// Use the [failureTitle] to specify the type of error and append data
///  on [failureData]
abstract class Failure extends Equatable {
  const Failure({
    required this.failureTitle,
    this.failureData,
  });

  final String failureTitle;
  final Map<String, dynamic>? failureData;

  @override
  List<Object?> get props => [failureTitle, failureData];
}
