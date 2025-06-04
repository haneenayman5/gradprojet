// import 'dart:isolate';
// import 'dart:ui';
//
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:untitled3/features/alarm/presentation/bloc/alarm_form/alarm_form_cubit.dart';
// import 'package:untitled3/features/alarm/presentation/bloc/alarm_list/alarm_list_cubit.dart';
// import 'package:untitled3/features/sound_detection/presentation/bloc/sound_monitor_cubit.dart';
// import 'package:untitled3/features/video_home/presentation/bloc/chat_home_bloc.dart';
// import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_bloc.dart';
// import 'package:untitled3/injection_container.dart';
// import 'core/storage/storage.dart';
// import 'core/widgets/all_parent_widget.dart';
// import 'features/alarm/data/ services/alarm_callback_service.dart';
// import 'features/alarm/data/ services/alarm_notification_ds.dart';
// import 'features/alarm/data/datasources/local_alarm_data_source.dart';
// import 'features/alarm/data/repositories/alarm_repository_impl.dart';
// import 'features/alarm/domain/repositories/alarm_repository.dart';
// import 'features/auth/presentation/bloc/auth/sign_in/sign_in_bloc.dart';
// import 'features/auth/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
// import 'features/chat/presentation/blocs/chat_bloc.dart';
// import 'features/sound_detection/data/data_sources/sound_local_datasource.dart';
// import 'features/sound_detection/data/data_sources/sound_local_datasource_impl.dart';
// import 'features/sound_detection/data/models/sound_classifier_model.dart';
// import 'features/sound_detection/data/repositories/sound_repository_impl.dart';
// import 'features/sound_detection/domain/repositories/sound_repository.dart';
// import 'features/sound_detection/domain/usecases/monitor_sound.dart';
// import 'features/sound_detection/domain/usecases/start_sound_classification_use_case.dart';
// import 'features/sound_detection/domain/usecases/stop_sound_classification_use_case.dart';
// import 'providers/language_provider.dart';
// import 'package:get_it/get_it.dart';
// import 'package:untitled3/core/util/app_route.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;


import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:untitled3/injection_container.dart';
import 'package:untitled3/core/widgets/all_parent_widget.dart';
import 'package:untitled3/features/alarm/presentation/bloc/alarm_form/alarm_form_cubit.dart';
import 'package:untitled3/features/alarm/presentation/bloc/alarm_list/alarm_list_cubit.dart';
import 'package:untitled3/features/sound_detection/presentation/bloc/sound_monitor_cubit.dart';
import 'package:untitled3/features/video_home/presentation/bloc/chat_home_bloc.dart';
import 'package:untitled3/features/video_chat/presentation/bloc/video_chat_bloc.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:untitled3/features/chat/presentation/blocs/chat_bloc.dart';
import 'package:untitled3/providers/language_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled3/core/util/app_route.dart';

// Create and register a port for alarm triggers
final ReceivePort alarmTriggeredPort = ReceivePort();
final Stream<dynamic> alarmTriggeredBroadcast = alarmTriggeredPort.asBroadcastStream();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  // Register the port so background isolates can communicate
  IsolateNameServer.registerPortWithName(
    alarmTriggeredPort.sendPort,
    'alarm_ui_port',
  );

  // Initialize dependency injection
  await initializeDependancies();

  // Initialize timezone database and set local timezone
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

  final GetIt locator = GetIt.instance;

  runApp(
    MultiProvider(
      providers: [
        BlocProvider<SignInBloc>(create: (_) => locator<SignInBloc>()),
        BlocProvider<SignUpBloc>(create: (_) => locator<SignUpBloc>()),
        BlocProvider<ChatBloc>(create: (_) => locator<ChatBloc>()),
        BlocProvider<ChatHomeBloc>(create: (_) => locator<ChatHomeBloc>()),
        BlocProvider<VideoChatBloc>(create: (_) => locator<VideoChatBloc>()),
        BlocProvider<AlarmFormCubit>(create: (_) => locator<AlarmFormCubit>()),
        BlocProvider<AlarmListCubit>(create: (_) => locator<AlarmListCubit>()),
        BlocProvider<SoundMonitorCubit>(create: (_) => locator<SoundMonitorCubit>()),
        ChangeNotifierProvider<LanguageProvider>(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlarmDialogListener(   // Wrap the app to listen for alarm dialogs
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'SignChat',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: AppRoute.router,
      ),
    );
  }
}
