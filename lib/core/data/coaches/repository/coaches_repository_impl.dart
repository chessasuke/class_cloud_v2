import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/core/data/coaches/repository/coaches_repository.dart';
import 'package:class_cloud/core/data/coaches/sources/coach_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coachesRepository = Provider<CoachesRepository>(
  (ref) => CoachesRepositoryImpl(
    coachDataSource: ref.read(coachesDataSource),
  ),
);

class CoachesRepositoryImpl implements CoachesRepository {
  CoachesRepositoryImpl({
    required CoachesDataSource coachDataSource,
  }) : _coachDataSource = coachDataSource;

  final CoachesDataSource _coachDataSource;

  @override
  Future<List<Coach>?> fetchCoaches() async {
    return await _coachDataSource.fetchCoaches();
  }
}
