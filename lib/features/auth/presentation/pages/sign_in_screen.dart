import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_bloc.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_events.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_in/sign_in_states.dart';
import 'package:untitled3/features/chat/presentation/pages/chat_screen_testing.dart';
import '../../../../providers/language_provider.dart';
import 'ForgotPasswordScreen.dart';
import '../../data/data_sources/remote/ApiService.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/core/storage/storage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({ super.key });

  @override createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
{
  double titleFontSize = 30.0;

  // Custom font size variable
  double descriptionFontSize = 18.0;
  double buttonFontSize = 18.0;
  double textFieldFontSize = 20.0;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showError(String error)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red)
    );
  }

  bool validateInput() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text;

    if(username.isEmpty) {
      _showError('Username cannot be empty.');
      return false;
    }

    if (password.isEmpty) {
      _showError('Password cannot be empty.');
      return false;
    }

    if (password.length < 3)
    {
      _showError('Password length cannot be less than 3');
      return false;
    }

    return true;
  }

  void _signIn(BuildContext context) {
    if(!validateInput())
    {
      return;
    }

    BlocProvider.of<SignInBloc>(context).add(
        SignInRequested(username: _usernameController.text.trim(), password: _passwordController.text.trim())
    );

  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: buildAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Extra space above "SignChat"
              const SizedBox(height: 130),

              // "SignChat" Text in the center
              Text(
                "SignChat",
                style: TextStyle(
                  fontSize: titleFontSize + 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              // Sign-In description
              Text(
                languageProvider.translate('signInDescription'),
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Username TextField
              TextField(
                controller: _usernameController,
                style: TextStyle(fontSize: textFieldFontSize),
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Username'),
                  labelStyle: TextStyle(fontSize: textFieldFontSize, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(fontSize: textFieldFontSize),
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Password'),
                  labelStyle: TextStyle(fontSize: textFieldFontSize, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // // Sign-In Button
              // _isLoading? CircularProgressIndicator(): ElevatedButton(
              //   onPressed: _signIn,
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              //     backgroundColor: Colors.blue,
              //   ),
              //   child: Text(
              //     languageProvider.translate('signIn'),
              //     style: TextStyle(
              //       fontSize: buttonFontSize,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 10),

              BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignInSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign-in successful")),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ChatTestScreen(),//---this should navigate to the chat test screen---
                    //   ),
                    // );
                    context.go(AppRoute.homePath);
                  }
                  else if (state is SignInFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message))
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SignInLoading) {
                    // If the state indicates a loading process, show a loading indicator.
                    return CircularProgressIndicator();
                  }
                  // Otherwise, show an ElevatedButton that triggers the sign-in process.
                  return ElevatedButton(
                    onPressed: () => _signIn(context),
                    child: Text("Sign In"),
                  );
                },
                ),

              // Forgot Password Button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  languageProvider.translate('forgotPassword'),
                  style: TextStyle(
                    fontSize: descriptionFontSize,
                    color: Colors.blue,
                  ),
                ),
              ),

              // Don't have an account? Sign Up
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');//make a routes file for all routes
                },
                child: Text(
                  languageProvider.translate('noAccount'),
                  style: TextStyle(
                    fontSize: descriptionFontSize,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildAppbar() {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return AppBar(
      title: Text(
        languageProvider.translate('signIn'),
        style: TextStyle(
          fontSize: titleFontSize,
          color: Colors.blue,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.language),
          onPressed: languageProvider.toggleLanguage,
        ),
      ],
    );
  }
}







