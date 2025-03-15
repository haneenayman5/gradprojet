import 'package:untitled3/features/auth/domain/entities/user_token_entity.dart';
import 'package:untitled3/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  const SignInUseCase(this.authRepository);

  Future<UserTokenEntity> call(String username, String password) async {
    return authRepository.signIn(username, password);
  }
}