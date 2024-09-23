import 'package:class_cloud/core/data/schools/models/school.dart';
import 'package:class_cloud/core/data/schools/repository/school_repository.dart';
import 'package:class_cloud/core/data/schools/sources/school_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schoolsRepository = Provider<SchoolRepository>(
  (ref) => SchoolsRepositoryImpl(
    schoolDataSource: ref.read(schoolDataSource),
  ),
);

class SchoolsRepositoryImpl implements SchoolRepository {
  SchoolsRepositoryImpl({
    required SchoolDataSource schoolDataSource,
  }) : _schoolDataSource = schoolDataSource;

  final SchoolDataSource _schoolDataSource;

  @override
  Future<List<School>?> fetchSchools() async {
    return _schoolDataSource.fetchSchools();
  }
}
