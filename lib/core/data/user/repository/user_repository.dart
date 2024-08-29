import 'package:class_cloud/core/clients/firebase_auth_client/firebase_auth_client.dart';
import 'package:class_cloud/core/clients/firebase_firestore_client.dart/firebase_firestore_client.dart';
import 'package:class_cloud/core/data/user/models/user.dart';
import 'package:class_cloud/core/data/user/sources/user_remote_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

part 'user_repository_impl.dart';

abstract class UserRepository {
  User? get currentUser;
  Stream<User?> get userStream;
}
