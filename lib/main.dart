import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/features/chat/presentation/pages/chat_screen_testing.dart';
import 'package:untitled3/injection_container.dart';
import 'features/auth/presentation/bloc/auth/sign_in/sign_in_bloc.dart';
import 'features/auth/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import 'features/chat/presentation/blocs/chat_bloc.dart';
import 'providers/language_provider.dart';
import 'features/auth/presentation/pages/sign_in_screen.dart';
import 'features/auth/presentation/pages/sign_up_screen.dart';
import 'features/auth/presentation/pages/welcome_screen.dart';
import 'features/auth/presentation/pages/ForgotPasswordScreen.dart'; // Add Forgot Password screen import
import 'features/auth/data/data_sources/remote/ApiService.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  await initializeDependancies();
  final GetIt locator = GetIt.instance;
  runApp(
      MultiProvider(
        providers: [
          BlocProvider<SignInBloc>(
            create: (_) => locator<SignInBloc>(),
          ),
          BlocProvider<SignUpBloc>(
            create: (_) => locator<SignUpBloc>()
          ),
          BlocProvider<ChatBloc>(
            create: (_) => locator<ChatBloc>()
          ),
          // Add other BlocProviders here if needed.
          ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider(),
          ),
          // Add other ChangeNotifierProviders if needed.
        ],
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SignChat',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(), // Add route for Forgot Password
        '/chat_test': (context) => const ChatTestScreen(),
      },
    );
  }
}