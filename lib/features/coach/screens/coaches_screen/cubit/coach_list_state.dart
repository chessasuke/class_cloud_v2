import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:equatable/equatable.dart';

sealed class CoachListState extends Equatable {
  const CoachListState();

  @override
  List<Object> get props => [];
}

class CoachListInitial extends CoachListState {
  const CoachListInitial();
}

class CoachListLoading extends CoachListState {
  const CoachListLoading();
}

class CoachListLoaded extends CoachListState {
  const CoachListLoaded(this.coaches);

  final List<Coach> coaches;

  @override
  List<Object> get props => [coaches];
}

class CoachListError extends CoachListState {
  const CoachListError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
