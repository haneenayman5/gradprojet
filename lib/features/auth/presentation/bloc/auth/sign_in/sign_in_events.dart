import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInRequested extends SignInEvent {
  final String username;
  final String password;

  SignInRequested({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
