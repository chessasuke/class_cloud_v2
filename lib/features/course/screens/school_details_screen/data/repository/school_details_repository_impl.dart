import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/data/repository/school_details_repository.dart';
import 'package:class_cloud/features/school/screens/school_details_screen/data/source/school_details_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schoolDetailsRepository = Provider(
  (ref) => SchoolDetailsRepositoryImpl(
    schoolDataSource: ref.read(schoolDetailsDataSource),
  ),
);

class SchoolDetailsRepositoryImpl implements SchoolDetailsRepository {
  SchoolDetailsRepositoryImpl({required this.schoolDataSource});

  final SchoolDetailsDataSource schoolDataSource;

  @override
  Future<School?> fetchSchoolById({required String schoolId}) async {
    return await schoolDataSource.fetchSchoolById(schoolId: schoolId);
  }
}
