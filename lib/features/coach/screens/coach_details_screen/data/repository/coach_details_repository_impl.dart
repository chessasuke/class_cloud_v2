import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/data/repository/coach_details_repository.dart';
import 'package:class_cloud/features/coach/screens/coach_details_screen/data/source/coach_details_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coachDetailsRepository = Provider(
  (ref) => CoachDetailsRepositoryImpl(
    coachDataSource: ref.read(coachDetailsDataSource),
  ),
);

class CoachDetailsRepositoryImpl implements CoachDetailsRepository {
  CoachDetailsRepositoryImpl({required this.coachDataSource});

  final CoachDetailsDataSource coachDataSource;

  @override
  Future<Coach?> fetchCoachById({required String coachId}) async {
    return await coachDataSource.fetchCoachById(coachId: coachId);
  }
}
