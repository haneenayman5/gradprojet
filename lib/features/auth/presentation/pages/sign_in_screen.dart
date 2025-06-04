import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_events.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_states.dart';
import '../../../../providers/language_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _showError(String error) {
    setState(() => _errorMessage = error);
  }

  bool _validateInput(LanguageProvider lang) {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty) return _showAndReturn(lang.translate('usernameEmpty'));
    if (password.isEmpty) return _showAndReturn(lang.translate('passwordEmpty'));
    if (password.length < 3) return _showAndReturn(lang.translate('passwordTooShort'));

    return true;
  }

  bool _showAndReturn(String msg) {
    _showError(msg);
    return false;
  }

  void _signIn(BuildContext context, LanguageProvider lang) {
    if (!_validateInput(lang)) return;

    setState(() => _errorMessage = null);

    context.read<SignInBloc>().add(SignInRequested(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final t = lang.translate;

    return Scaffold(
      appBar: AppBar(
        title: Text(t('signIn'), style: const TextStyle(color: Colors.blue)),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: lang.toggleLanguage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 130),
              const Text("SignChat", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 20),
              Text(t('signInDescription'), style: TextStyle(fontSize: 18, color: Colors.grey[600]), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              _buildInputField(_usernameController, t('Username')),
              const SizedBox(height: 10),
              _buildInputField(_passwordController, t('Password'), obscure: true),
              const SizedBox(height: 10),
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
              BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignInSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t('signInSuccess'))));
                    context.go(AppRoute.homePath);
                  } else if (state is SignInFailure) {
                    _showError(t('Wrong Username or Password'));
                  }
                },
                builder: (context, state) {
                  if (state is SignInLoading) return const CircularProgressIndicator();
                  return _buildSignInButton(lang);
                },
              ),
              const SizedBox(height: 10),
              _buildTextButton(() => context.push(AppRoute.forgetPasswordPath), t('forgotPassword')),
              _buildTextButton(() => context.go(AppRoute.signUpPath), t('noAccount')),
              _buildTextButton(() => context.go(AppRoute.handTracking), 'Hand detection'), // For testing
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }

  Widget _buildSignInButton(LanguageProvider lang) {
    return ElevatedButton(
      onPressed: () => _signIn(context, lang),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        backgroundColor: Colors.blue,
      ),
      child: Text(lang.translate('signIn'), style: const TextStyle(color: Colors.white, fontSize: 18)),
    );
  }

  Widget _buildTextButton(VoidCallback onPressed, String text) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: Colors.blue)),
    );
  }
}







