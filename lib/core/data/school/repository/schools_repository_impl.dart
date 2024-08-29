import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/core/data/school/repository/schools_repository.dart';
import 'package:class_cloud/core/data/school/sources/school_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schoolsRepository = Provider<SchoolsRepository>(
  (ref) => SchoolsRepositoryImpl(
    schoolDataSource: ref.read(schoolDataSource),
  ),
);

class SchoolsRepositoryImpl implements SchoolsRepository {
  SchoolsRepositoryImpl({
    required SchoolesDataSource schoolDataSource,
  }) : _schoolDataSource = schoolDataSource;

  final SchoolesDataSource _schoolDataSource;

  @override
  Future<List<School>?> fetchSchools() async {
    return await _schoolDataSource.fetchSchools();
  }
}
