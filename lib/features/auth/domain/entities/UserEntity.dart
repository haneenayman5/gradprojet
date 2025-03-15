import 'package:equatable/equatable.dart';

class UserEntity {
  final String ? username;
  final String ? firstName;
  final String ? lastName;
  final DateTime ? dateOfBirth;
  final String ? email;

  const UserEntity({
    this.username,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.email
  });

}