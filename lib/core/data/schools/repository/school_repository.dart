
import 'package:class_cloud/core/data/schools/models/school.dart';

abstract class SchoolRepository {
  Future<List<School>?> fetchSchools();
}
