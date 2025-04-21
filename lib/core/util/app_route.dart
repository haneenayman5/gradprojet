import 'package:go_router/go_router.dart';
import 'package:untitled3/features/auth/presentation/pages/ForgotPasswordScreen.dart';
import 'package:untitled3/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:untitled3/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:untitled3/features/auth/presentation/pages/welcome_screen.dart';
import 'package:untitled3/features/chat/presentation/pages/chat_screen_testing.dart';
import 'package:untitled3/features/chat/presentation/views/chat_view.dart';
import 'package:untitled3/features/video_home/presentation/views/home_view.dart';
import 'package:untitled3/features/search/presentation/views/search_view.dart';
import 'package:untitled3/features/video_chat/presentation/pages/VideoChatTest.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/help_screen.dart'; // NEW

abstract class AppRoute {
  static String welcomePath = '/';
  static String homePath = '/video_home';
  static String kChatPath = '/ChatView';
  static String kSearchPath = '/SearchView';
  static String signInPath = '/signin';
  static String signUpPath = '/signup';
  static String forgetPasswordPath = '/forgot_password';
  static String chatTestPath = '/chat_test';
  static String videoChatTestPath = '/video_test';
  static String helpPath = '/help'; // NEW

  static final router = GoRouter(routes: [
    GoRoute(
      path: welcomePath,
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      path: homePath,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: kChatPath,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final senderId = extra['senderId'] as String;
        final receiverId = extra['receiverId'] as String;
        return ChatView(senderId: senderId, receiverId: receiverId);
      },
    ),
    GoRoute(
      path: kSearchPath,
      builder: (context, state) => const SearchView(),
    ),
    GoRoute(
      path: signInPath,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: signUpPath,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: forgetPasswordPath,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: chatTestPath,
      builder: (context, state) => const ChatTestScreen(),
    ),
    GoRoute(
      path: videoChatTestPath,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final username1 = extra['username1'] as String;
        final username2 = extra['username2'] as String;
        return VideoChatTestPage(username1: username1, username2: username2);
      },
    ),
    GoRoute(
      path: helpPath,
      builder: (context, state) => const HelpScreen(),
    ),
  ]);
}


