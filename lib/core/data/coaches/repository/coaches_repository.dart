import 'package:class_cloud/core/data/coaches/models/coach.dart';

abstract class CoachesRepository {
  Future<List<Coach>?> fetchCoaches();
}
