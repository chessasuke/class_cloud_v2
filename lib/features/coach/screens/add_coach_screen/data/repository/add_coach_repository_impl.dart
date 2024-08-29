import 'package:class_cloud/core/data/coaches/models/coach.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/data/repository/add_coach_repository.dart';
import 'package:class_cloud/features/coach/screens/add_coach_screen/data/source/add_coach_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addCoachRepository = Provider(
  (ref) => AddCoachRepositoryImpl(
    remoteDataSource: ref.read(addCoachDataSource),
  ),
);

class AddCoachRepositoryImpl extends AddCoachRepository {
  AddCoachRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  final AddCoachDataSource remoteDataSource;

  @override
  String get generateCoachId => remoteDataSource.generateCoachId;

  @override
  Future<void> addCoach({required Coach coach}) async {
    await remoteDataSource.addCoach(coach: coach);
  }
}
