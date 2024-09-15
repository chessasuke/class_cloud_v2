import 'package:class_cloud/core/data/school/models/school.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/data/repository/add_school_repository.dart';
import 'package:class_cloud/features/school/screens/add_school_screen/data/source/add_school_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addSchoolRepository = Provider(
  (ref) => AddSchoolRepositoryImpl(
    remoteDataSource: ref.read(addSchoolDataSource),
  ),
);

class AddSchoolRepositoryImpl extends AddSchoolRepository {
  AddSchoolRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  final AddSchoolDataSource remoteDataSource;

  @override
  String get generateSchoolId => remoteDataSource.generateSchoolId;

  @override
  Future<void> addSchool({required School school}) async {
    await remoteDataSource.addSchool(school: school);
  }
}
