import 'package:untitled3/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<void> call(String username, String password, String firstName, String lastName, DateTime dateOfBirth, String email) async {
    return authRepository.signUp(username, password, firstName, lastName, dateOfBirth, email);
  }

}