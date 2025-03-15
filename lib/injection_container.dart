import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled3/core/storage/storage.dart';
import 'package:untitled3/features/auth/data/data_sources/remote/ApiService.dart';
import 'package:untitled3/features/auth/data/repository/auth_repository_impl.dart';
import 'package:untitled3/features/auth/data/repository/user_repository_impl.dart';
import 'package:untitled3/features/auth/domain/repository/UserRepository.dart';
import 'package:untitled3/features/auth/domain/repository/auth_repository.dart';
import 'package:untitled3/features/auth/domain/usecases/get_users.dart';
import 'package:untitled3/features/auth/domain/usecases/sign_in.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:untitled3/features/auth/presentation/bloc/remote_user/remote_user_bloc.dart';
import 'package:untitled3/features/chat/data/data_sources/chat_source.dart';
import 'package:untitled3/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:untitled3/features/chat/domain/repositories/chat_repository.dart';
import 'package:untitled3/features/chat/domain/usecases/chat_usecase.dart';

import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import 'features/chat/presentation/blocs/chat_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependancies() async {

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<SecureStorage>(
      SecureStorage()
  );

  await initializeAuth();

  sl.registerSingleton<ChatService>(ChatService(secureStorage: sl()));

  sl.registerSingleton<ChatRepository>(ChatRepositoryImpl(sl()));

  sl.registerSingleton<ChatUseCase>(ChatUseCase(sl()));

  sl.registerFactory<ChatBloc>(
          () => ChatBloc(chatUseCase: sl())
  );

}

Future<void> initializeAuth() async {
  sl.registerSingleton<ApiService>(ApiService(sl()));

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(sl(), sl())
  );

  sl.registerSingleton<UserRepository>(
      UserRepositoryImpl(sl())
  );

  sl.registerSingleton<GetUsersUseCase>(
      GetUsersUseCase(sl())
  );

  sl.registerFactory<RemoteUsersBloc>(
          () => RemoteUsersBloc(sl())
  );

  sl.registerSingleton<SignInUseCase>(
      SignInUseCase(sl())
  );

  sl.registerFactory<SignInBloc>(
          () => SignInBloc(sl())
  );

  sl.registerSingleton<SignUpUseCase>(
      SignUpUseCase(authRepository: sl())
  );

  sl.registerFactory<SignUpBloc>(
          () => SignUpBloc(sl())
  );
}

Future<void> initializeChat() async {

}