import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'ForgotPasswordScreen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    // Custom font size variable
    double titleFontSize = 30.0;
    double descriptionFontSize = 18.0;
    double buttonFontSize = 18.0;
    double textFieldFontSize = 20.0;

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

              // Email TextField
              TextField(
                style: TextStyle(fontSize: textFieldFontSize),
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Email'),
                  labelStyle: TextStyle(fontSize: textFieldFontSize, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Password TextField
              TextField(
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
              ElevatedButton(
                onPressed: () {
                  // Add Sign-In logic
                },
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







