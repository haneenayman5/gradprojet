import 'package:equatable/equatable.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends SignUpEvent {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;

  SignUpRequested({required this.firstName, required this.lastName, required this.dateOfBirth, required this.email, required this.username, required this.password});

  @override
  List<Object?> get props => [username, password, firstName, lastName, dateOfBirth, email];
}