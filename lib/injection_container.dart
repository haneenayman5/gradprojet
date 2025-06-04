import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/core/storage/storage.dart';
import 'package:untitled3/core/services/local_notification_ds.dart';
import 'package:untitled3/features/account/data/datasources/updateAccountService.dart';
import 'package:untitled3/features/account/domain/repositories/update_account_repository.dart';
import 'package:untitled3/features/account/domain/usecases/update_account.dart';
import 'package:untitled3/features/account/domain/usecases/update_avatar.dart';
import 'package:untitled3/features/alarm/data/%20services/alarm_callback_service.dart';
import 'package:untitled3/features/alarm/data/%20services/alarm_notification_ds.dart';
import 'package:untitled3/features/alarm/data/%20services/flash_service.dart';
import 'package:untitled3/features/alarm/data/%20services/vibration_service.dart';
import 'package:untitled3/features/alarm/data/repositories/alarm_repository_impl.dart';
import 'package:untitled3/features/alarm/domain/repositories/alarm_repository.dart';
import 'package:untitled3/features/auth/data/data_sources/remote/ApiService.dart';
import 'package:untitled3/features/auth/data/repository/auth_repository_impl.dart';
import 'package:untitled3/features/auth/data/repository/user_repository_impl.dart';
import 'package:untitled3/features/auth/domain/repository/UserRepository.dart';
import 'package:untitled3/features/auth/domain/repository/auth_repository.dart';
import 'package:untitled3/features/auth/domain/usecases/get_current_user.dart';
import 'package:untitled3/features/auth/domain/usecases/get_user.dart';
import 'package:untitled3/features/auth/domain/usecases/get_users.dart';
import 'package:untitled3/features/auth/domain/usecases/sign_in.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:untitled3/features/auth/presentation/bloc/remote_user/remote_user_bloc.dart';
import 'package:untitled3/features/chat/data/data_sources/chat_source.dart';
import 'package:untitled3/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:untitled3/features/chat/domain/repositories/chat_repository.dart';
import 'package:untitled3/features/chat/domain/usecases/chat_usecase.dart';
import 'package:untitled3/features/sound_detection/data/data_sources/sound_local_datasource.dart';
import 'package:untitled3/features/sound_detection/data/data_sources/sound_local_datasource_impl.dart';
import 'package:untitled3/features/sound_detection/data/models/sound_classifier_model.dart';
import 'package:untitled3/features/sound_detection/data/repositories/sound_repository_impl.dart';
import 'package:untitled3/features/sound_detection/domain/repositories/sound_repository.dart';
import 'package:untitled3/features/sound_detection/domain/usecases/start_sound_classification_use_case.dart';
import 'package:untitled3/features/sound_detection/presentation/bloc/sound_monitor_cubit.dart';
import 'package:untitled3/features/video_chat/data/others/asl_detector.dart';
import 'package:untitled3/features/video_chat/data/others/frame_observer.dart';
import 'package:untitled3/features/video_chat/domain/usecases/getPredictionStream.dart';
import 'package:untitled3/features/video_home/data/data_source/ConversationService.dart';
import 'package:untitled3/features/video_home/domain/repository/ChatHomeRepository.dart';
import 'package:untitled3/features/video_home/domain/usecase/GetConversationsUsecase.dart';
import 'package:untitled3/features/video_home/domain/usecase/GetSenderIdUsecase.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_bloc.dart';
import 'package:untitled3/features/video_chat/data/data_sources/AgoraService.dart';
import 'package:untitled3/features/video_chat/data/repository/AgoraVideoChatRepository.dart';
import 'package:untitled3/features/video_chat/domain/repository/VideoChatRepository.dart';
import 'package:untitled3/features/video_chat/domain/usecases/GetLocalUserStreamUsecase.dart';
import 'package:untitled3/features/video_chat/domain/usecases/GetRemoteUserStreamUsecase.dart';
import 'package:untitled3/features/video_chat/domain/usecases/connectToVideoChat.dart';
import 'package:untitled3/features/video_chat/domain/usecases/disconnectFromVideoChat.dart';
import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_bloc.dart';

import 'features/account/data/repositories/update_account_repository_impl.dart';
import 'features/account/presentation/blocs/account_cubit.dart';
import 'features/alarm/data/datasources/local_alarm_data_source.dart';
import 'features/alarm/presentation/bloc/alarm_form/alarm_form_cubit.dart';
import 'features/alarm/presentation/bloc/alarm_list/alarm_list_cubit.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import 'features/chat/presentation/blocs/chat_bloc.dart';
import 'features/sound_detection/domain/usecases/monitor_sound.dart';
import 'features/sound_detection/domain/usecases/stop_sound_classification_use_case.dart';
import 'features/video_chat/data/others/hands_service.dart';
import 'features/video_home/data/repository/ChatHomeRepositoryImpl.dart';

final sl = GetIt.instance;

// Top-level function to create Dio with token interceptor
Dio createDioWithToken(SecureStorage secureStorage) {
  final dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
}

Future<void> initializeDependancies() async {
  sl.registerSingleton<SecureStorage>(SecureStorage());

  sl.registerLazySingleton<Dio>(() => createDioWithToken(sl()));

  sl.registerLazySingleton<FlutterLocalNotificationsPlugin>(
        () => FlutterLocalNotificationsPlugin(),
  );

  sl.registerLazySingleton<LocalNotificationDataSource>(
        () => LocalNotificationDataSource(sl()),
  );

  await initializeAuth();

  sl.registerLazySingleton<ChatService>(
        () => ChatService(secureStorage: sl()),
  );

  sl.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<ChatUseCase>(
        () => ChatUseCase(sl()),
  );

  sl.registerFactory<ChatBloc>(
        () => ChatBloc(chatUseCase: sl()),
  );

  sl.registerLazySingleton<ConversationService>(
        () => ConversationService(sl()),
  );

  sl.registerLazySingleton<ChatHomeRepository>(
        () => ChatHomeRepositoryImpl(service: sl(), secureStorage: sl()),
  );

  sl.registerLazySingleton<GetConversationUsecase>(
        () => GetConversationUsecase(chatHomeRepository: sl()),
  );

  sl.registerLazySingleton<GetSenderIdUseCase>(
        () => GetSenderIdUseCase(chatHomeRepository: sl()),
  );

  sl.registerFactory<ChatHomeBloc>(
        () => ChatHomeBloc(
      getConversationUsecase: sl(),
      getSenderIdUseCase: sl(),
    ),
  );

  // Sound detection
  sl.registerLazySingleton<SoundLocalDataSource>(
        () => SoundLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<SoundClassifier>(
        () => SoundClassifier(),
  );

  sl.registerLazySingleton<SoundRepository>(
        () => SoundRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<MonitorSoundUsecase>(
        () => RealMonitorSound(repository: sl()),
  );

  sl.registerLazySingleton<StartSoundClassificationUseCase>(
        () => StartSoundClassificationUseCase(sl()),
  );

  sl.registerLazySingleton<StopSoundClassificationUseCase>(
        () => StopSoundClassificationUseCase(sl()),
  );

  sl.registerFactory<SoundMonitorCubit>(
        () => SoundMonitorCubit(
      startClassification: sl(),
      stopClassification: sl(),
      monitorNoise: sl(),
    ),
  );

  // Alarm feature
  sl.registerLazySingleton<LocalAlarmDataSource>(
        () => LocalAlarmDataSource(),
  );

  sl.registerLazySingleton<AlarmCallbackService>(
        () => AlarmCallbackService(),
  );

  final alarmNotificationService = AlarmNotificationService(sl());
  await alarmNotificationService.initialize(); // Await initialization if async
  sl.registerSingleton<AlarmNotificationService>(alarmNotificationService);

  sl.registerLazySingleton<AlarmRepository>(
        () => AlarmRepositoryImpl(
      notifications: sl(),
      localAlarmDataSource: sl(),
      alarmCallbackService: sl(),
    ),
  );

  sl.registerFactory(() => AlarmListCubit(repository: sl()));
  sl.registerFactory(() => AlarmFormCubit());

  await initializeVideoChatDependencies();

  sl.registerLazySingleton<UpdateAccountService>(
        () => UpdateAccountService(sl()),
  );

  sl.registerLazySingleton<UpdateAccountRepository>(
        () => UpdateAccountRepositoryImpl(updateAccountService: sl()),
  );

  sl.registerLazySingleton<UploadAvatarUsecase>(
        () => UploadAvatarUsecase(apiService: sl()),
  );

  sl.registerLazySingleton<UpdateAccountUseCase>(
        () => UpdateAccountUseCase(sl()),
  );

  sl.registerLazySingleton<GetCurrentUserUsecase>(
        () => GetCurrentUserUsecase(userRepository: sl()),
  );

  sl.registerFactory<AccountCubit>(
        () => AccountCubit(
      updateProfileImageUseCase: sl(),
      getUserUseCase: sl(),
      updateAccountUseCase: sl(),
      getCurrentUserUsecase: sl(),
    ),
  );
}

Future<void> initializeAuth() async {
  sl.registerLazySingleton<ApiService>(() => ApiService(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(sl()));

  sl.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(sl()));

  sl.registerFactory<RemoteUsersBloc>(() => RemoteUsersBloc(sl()));

  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl()));

  sl.registerFactory<SignInBloc>(() => SignInBloc(sl()));

  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(authRepository: sl()));

  sl.registerFactory<SignUpBloc>(() => SignUpBloc(sl()));
}

Future<void> initializeVideoChatDependencies() async {
  sl.registerSingleton<AgoraService>(AgoraService(sl()));

  sl.registerLazySingletonAsync<ASLDetector>(() async => await ASLDetector.initialize());
  sl.registerLazySingletonAsync<Hands>(() async => await Hands.initialize());

  await sl.isReady<ASLDetector>();
  await sl.isReady<Hands>();

  sl.registerSingleton<FrameObserver>(FrameObserver(aslDetector: sl(), hands: sl()));

  sl.registerSingleton<VideoChatRepository>(
    AgoraVideoChatRepository(agoraService: sl(), frameObserver: sl()),
  );

  sl.registerSingleton<ConnectToVideoChatUsecase>(
    ConnectToVideoChatUsecase(repository: sl()),
  );

  sl.registerSingleton<DisconnectFromVideoChatUsecase>(
    DisconnectFromVideoChatUsecase(videoChatRepository: sl()),
  );

  sl.registerSingleton<GetLocalUserStreamUsecase>(
    GetLocalUserStreamUsecase(repository: sl<VideoChatRepository>()),
  );

  sl.registerSingleton<GetRemoteUserStreamUsecase>(
    GetRemoteUserStreamUsecase(repository: sl()),
  );

  sl.registerSingleton<GetPredictionStreamUsecase>(
    GetPredictionStreamUsecase(videoChatRepository: sl()),
  );

  sl.registerFactory<VideoChatBloc>(() => VideoChatBloc(
    connectUsecase: sl(),
    disconnectUsecase: sl(),
    getLocalUserStreamUsecase: sl(),
    getRemoteUserStreamUsecase: sl(),
  ));
}