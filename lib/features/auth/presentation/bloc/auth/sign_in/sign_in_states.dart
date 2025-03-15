import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInLoading extends SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  final String token;
  SignInSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

class SignInFailure extends SignInState {
  final String message;
  SignInFailure(this.message);

  @override
  List<Object?> get props => [message];
}