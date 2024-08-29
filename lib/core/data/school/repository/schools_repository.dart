import 'package:class_cloud/core/data/school/models/school.dart';

abstract class SchoolsRepository {
  Future<List<School>?> fetchSchools();
}
