import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum Role {
  @JsonValue('admin')
  admin,
  @JsonValue('coach')
  coach,
}

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
  });
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final Role? role;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        uid,
        email,
        role,
      ];

  /// Connect the generated [_$UserFromJson] function to the `fromJson`
  /// factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$CairdioUserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
