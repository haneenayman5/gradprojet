import 'package:untitled3/features/auth/domain/entities/user_token_entity.dart';

abstract class AuthRepository {
  Future<UserTokenEntity> signIn(String username, String password);
  Future<void> signUp(String username, String password, String firstName, String lastName, DateTime dateOfBirth, String email);
}

