
import 'package:class_cloud/core/data/school/models/school.dart';

abstract class SchoolDetailsRepository {
  Future<School?> fetchSchoolById({required String schoolId});
}
