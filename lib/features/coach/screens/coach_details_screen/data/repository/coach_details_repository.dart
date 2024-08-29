
import 'package:class_cloud/core/data/coaches/models/coach.dart';

abstract class CoachDetailsRepository {
  Future<Coach?> fetchCoachById({required String coachId});
}
