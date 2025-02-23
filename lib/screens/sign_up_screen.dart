import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../services/ApiService.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signUp() async {
    print("hello");
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "username": "string",
      "password": "string",
      "first_name": "string",
      "last_name": "string",
      "dateOfBirth": "2005-02-23T17:44:46.020Z",
      "phone_number": "string"
    };


    try {
      final response = await ApiService.postRequest('/Account/Register', requestData);

      setState(() {
        _isLoading = false;
      });

      if (response != null && response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign-Up Successful!")),
        );
        Navigator.pushNamed(context, '/signin'); // Redirect to Sign-In page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response?['message'] ?? "Sign-Up Failed")),
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

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageProvider.translate('signUp'),
          style: TextStyle(fontSize: 30.0, color: Colors.blue),
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
            children: [
              const SizedBox(height: 80),
              Text(
                "SignChat",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Name'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Email'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Password'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('confirmPassword'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  languageProvider.translate('signUp'),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: Text(
                  languageProvider.translate('haveAccount'),
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



