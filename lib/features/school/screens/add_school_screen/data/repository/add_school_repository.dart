import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/data/source/add_school_data_source.dart';

abstract class AddSchoolRepository {
  abstract final AddSchoolDataSource remoteDataSource;

  Future<void> addSchool({required School school});

  String get generateSchoolId;
}
