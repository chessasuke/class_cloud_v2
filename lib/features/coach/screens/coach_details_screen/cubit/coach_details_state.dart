import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:equatable/equatable.dart';

sealed class CoachDetailsState extends Equatable {
  const CoachDetailsState();
}

class CoachDetailsInitial extends CoachDetailsState {
  const CoachDetailsInitial();

  @override
  List<Object?> get props => [];
}

class CoachDetailsLoading extends CoachDetailsState {
  const CoachDetailsLoading();

  @override
  List<Object?> get props => [];
}

class CoachDetailsLoaded extends CoachDetailsState {
  const CoachDetailsLoaded(this.coach);

  final Coach coach;

  @override
  List<Object?> get props => [coach];
}

class CoachDetailsError extends CoachDetailsState {
  const CoachDetailsError(this.error);
  final Object error;
  @override
  List<Object?> get props => [error];
}
