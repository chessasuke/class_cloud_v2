part of 'user_repository.dart';

final userRepository = Provider<UserRepository>(
  (ref) {
    final userRepo = UserRepositoryImpl(
      dataSource: UserRemoteDataSource(
        firestoreClient: ref.read(firestoreClient),
        authClient: ref.read(authClient),
      ),
    ).._initialize();
    return userRepo;
  },
);

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.dataSource, User? seedValue})
      : _user = BehaviorSubject.seeded(seedValue);

  final UserRemoteDataSource dataSource;

  @override
  User? get currentUser => _user.stream.valueOrNull;
  final BehaviorSubject<User?> _user;
  @override
  Stream<User?> get userStream => _user.stream;

  void _initialize() {
    dataSource.userStream.listen((user) {
      _user.add(user);
    });
  }
}
