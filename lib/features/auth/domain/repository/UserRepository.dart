
import 'package:untitled3/core/resources/data_state.dart';
import 'package:untitled3/features/auth/domain/entities/UserEntity.dart';

abstract class UserRepository {
  Future<DataState<List<UserEntity>>> getUsers();
}