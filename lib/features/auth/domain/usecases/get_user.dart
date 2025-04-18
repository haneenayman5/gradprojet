import 'package:dio/dio.dart';
import 'package:untitled3/core/resources/data_state.dart';
import 'package:untitled3/core/usecases/usecase.dart';
import 'package:untitled3/features/auth/domain/entities/UserEntity.dart';
import 'package:untitled3/features/auth/domain/repository/UserRepository.dart';

class GetUserUseCase implements UseCase<DataState<UserEntity>,String> {

  final UserRepository userRepository;

  GetUserUseCase(this.userRepository);

  @override
  Future<DataState<UserEntity>> call({required String params}) async {
    try {
      // Assuming userRepository.getUser returns a Future<DataState<UserEntity>>
      final result = await userRepository.getUser(params);
      return result;
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}