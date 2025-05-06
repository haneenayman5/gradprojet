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
import 'package:untitled3/features/video_home/presentation/views/widgets/help_screen.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/account_page.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/TextMagnifierSpeakerScreen.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/alarm_page.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/set_alarm_page.dart';
class ChatViewParams {
  final String senderId;
  final String receiverId;

  ChatViewParams({required this.senderId, required this.receiverId});
}

class VideoChatParams {
  final String username1;
  final String username2;

  VideoChatParams({required this.username1, required this.username2});
}

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
  static String helpPath = '/help';
  static String accountPath = '/account';
  static String magnifierPath = '/magnifier';
  static String alarmPath = '/alarm';
  static String setAlarmPath = '/set_alarm';

  static final router = GoRouter(
    routes: [
      GoRoute(path: welcomePath, builder: (_, __) => WelcomeScreen()),
      GoRoute(path: homePath, builder: (_, __) => const HomeView()),
      GoRoute(
        path: kChatPath,
        builder: (context, state) {
          final params = state.extra as ChatViewParams;
          return ChatView(
            senderId: params.senderId,
            receiverId: params.receiverId,
          );
        },
      ),
      GoRoute(path: kSearchPath, builder: (_, __) => const SearchView()),
      GoRoute(path: signInPath, builder: (_, __) => const SignInScreen()),
      GoRoute(path: signUpPath, builder: (_, __) => const SignUpScreen()),
      GoRoute(path: forgetPasswordPath, builder: (_, __) => const ForgotPasswordScreen()),
      GoRoute(path: chatTestPath, builder: (_, __) => const ChatTestScreen()),
      GoRoute(
        path: videoChatTestPath,
        builder: (context, state) {
          final params = state.extra as VideoChatParams;
          return VideoChatTestPage(
            username1: params.username1,
            username2: params.username2,
          );
        },
      ),
      GoRoute(path: helpPath, builder: (_, __) => const HelpScreen()),
      GoRoute(path: accountPath, builder: (_, __) => const AccountPage()),
      GoRoute(path: magnifierPath, builder: (_, __) => const TextMagnifierSpeakerScreen()),
      GoRoute(path: alarmPath, builder: (_, __) => const AlarmPage()),
      GoRoute(path: setAlarmPath, builder: (_, __) => const SetAlarmPage()), // Added route
    ],
  );
}














