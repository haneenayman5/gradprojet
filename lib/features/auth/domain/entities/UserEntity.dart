import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? username;
  final String? firstName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? email;

  const UserEntity({
    this.username,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.email,
  });

  @override
  List<Object?> get props => [username, firstName, lastName, dateOfBirth, email];
}

