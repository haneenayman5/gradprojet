import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'ForgotPasswordScreen.dart';
import '../services/ApiService.dart';
import 'package:intl/intl.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
{
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    // Custom font size variable
    double titleFontSize = 30.0;
    double descriptionFontSize = 18.0;
    double buttonFontSize = 18.0;
    double textFieldFontSize = 20.0;

    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    bool _isLoading = false;

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

    Future<void> _signIn() async {
      if(!validateInput())
        {
          return;
        }

      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> requestData = {
        "username": _usernameController.text.trim(),
        "password": _passwordController.text
      };

      try {
        final response = await ApiService.postRequest('/Account/Login', requestData);

        setState(() {
          _isLoading = false;
        });

        print('API response: $response');

        if (response != null && !response['token'].toString().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Token: " + response['token'])),
          );
          // Redirect to Home page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response?['message'] ?? "Sign-In Failed")),
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      }
    }


    return Scaffold(
      appBar: AppBar(
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
      ),
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

              // Sign-In Button
              _isLoading? CircularProgressIndicator(): ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  languageProvider.translate('signIn'),
                  style: TextStyle(
                    fontSize: buttonFontSize,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),

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
                  Navigator.pushNamed(context, '/signup');
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
}







