import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/util/app_route.dart';
import '../../../../providers/language_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final t = lang.translate;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.8, end: 1),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, scale, child) {
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: const Image(
                    image: AssetImage('assets/paper.png'),
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  t('welcome'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 20),
                Text(
                  t('tagline'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, color: Colors.grey[600]),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    t('description'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      label: t('signUp'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () => _handleNavigation(context, AppRoute.signUpPath, t),
                    ),
                    const SizedBox(width: 20),
                    _buildButton(
                      label: t('signIn'),
                      color: Colors.white,
                      textColor: Colors.blue,
                      isOutlined: true,
                      onPressed: () => context.go(AppRoute.signInPath),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    lang.setLanguage(lang.language == 'en' ? 'ar' : 'en');
                  },
                  child: Text(
                    lang.language == 'en' ? t('switchToArabic') : t('switchToEnglish'),
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    bool isOutlined = false,
  }) {
    return isOutlined
        ? OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        side: BorderSide(color: textColor),
        minimumSize: const Size(150, 60),
      ),
      child: Text(label, style: TextStyle(fontSize: 20, color: textColor)),
    )
        : ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        backgroundColor: color,
        minimumSize: const Size(150, 60),
      ),
      child: Text(label, style: TextStyle(fontSize: 20, color: textColor)),
    );
  }

  void _handleNavigation(BuildContext context, String path, String Function(String) t) {
    final toastMessage = path == AppRoute.signUpPath ? t('creatingAccount') : t('accessingAccount');
    Fluttertoast.showToast(
      msg: toastMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    context.push(path);
  }
}
