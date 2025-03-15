import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/language_provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    double titleFontSize = 30.0;
    double descriptionFontSize = 18.0;
    double buttonFontSize = 18.0;
    double textFieldFontSize = 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageProvider.translate('forgotPassword'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SignChat",
              style: TextStyle(
                fontSize: titleFontSize + 10,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              languageProvider.translate('forgotPasswordDescription'),
              style: TextStyle(
                fontSize: descriptionFontSize,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              style: TextStyle(fontSize: textFieldFontSize),
              decoration: InputDecoration(
                labelText: languageProvider.translate('Email'),
                labelStyle: TextStyle(fontSize: textFieldFontSize, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add reset link logic here
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                languageProvider.translate('sendResetLink'),
                style: TextStyle(
                  fontSize: buttonFontSize,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to Sign In
              },
              child: Text(
                languageProvider.translate('rememberPassword'),
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


