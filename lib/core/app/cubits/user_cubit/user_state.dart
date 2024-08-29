import 'package:class_cloud/core/data/user/models/user.dart';
import 'package:equatable/equatable.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserAuthenticated extends UserState {
  const UserAuthenticated({
    required this.user,
  });

  final User user;

  @override
  List<Object> get props => [user];
}

class UserUnauthenticated extends UserState {
  const UserUnauthenticated();
}
