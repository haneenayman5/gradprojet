import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../services/ApiService.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signUp() async {

    if(!_validateInputs())
      {
        return;
      }

    setState(() {
      _isLoading = true;
    });

    final DateFormat inputFormat = DateFormat("M/D/yyyy");
    final DateTime parsedDate = inputFormat.parse(_dateOfBirthController.text);
    final String dateOfBirth = parsedDate.toIso8601String();
    Map<String, dynamic> requestData = {
      "username": _usernameController.text.trim(),
      "password": _passwordController.text.trim(),
      "first_name": _firstNameController.text.trim(),
      "last_name": _lastNameController.text.trim(),
      "dateOfBirth": dateOfBirth,
      "email": _emailController.text.trim()
    };


    try {
      final response = await ApiService.postRequest('/Account/Register', requestData);

      setState(() {
        _isLoading = false;
      });

      print('API response: $response');

      if (response != null && response['message'] == 'Register successful') {//change the second condition
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

  bool _validateInputs() {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String username = _usernameController.text.trim();
    String dateOfBirth = _dateOfBirthController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (firstName.isEmpty) {
      _showError('First name cannot be empty.');
      return false;
    }

    if (lastName.isEmpty) {
      _showError('Last name cannot be empty.');
      return false;
    }

    if (username.isEmpty) {
      _showError('Username cannot be empty.');
      return false;
    }

    if (dateOfBirth.isEmpty) {
      _showError('Date of birth cannot be empty.');
      return false;
    }

    if (email.isEmpty) {
      _showError('Email cannot be empty.');
      return false;
    } else if (!_isValidEmail(email)) {
      _showError('Please enter a valid email address.');
      return false;
    }

    if (password.isEmpty) {
      _showError('Password cannot be empty.');
      return false;
    }

    if (password.length < 6)
      {
        _showError('Password length cannot be less than 6');
        return false;
      }

    // All validations passed
    return true;
  }

  void _showError(String error)
  {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error), backgroundColor: Colors.red)
    );
  }

  bool _isValidEmail(String email) {
    // Simple regex for email validation
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegExp.hasMatch(email);
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
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Username'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('First Name'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Last Name'),
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
              TextField(
                controller: _dateOfBirthController,
                readOnly: true, // Prevents manual editing
                onTap: () => _selectDate(context),
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 10),
              /*TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('confirmPassword'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),*/
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      // Format the date as desired, e.g., MM/dd/yyyy
      String formattedDate = DateFormat.yMd().format(pickedDate);

      // Update the date controller with the formatted date
      _dateOfBirthController.text = formattedDate;
    }
  }
}



