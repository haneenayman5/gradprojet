import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_up/sign_up_events.dart';
import 'package:untitled3/features/auth/presentation/bloc/auth/sign_up/sign_up_states.dart';
import '../../../../providers/language_provider.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

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

  String? _errorMessage;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    setState(() {
      _errorMessage = null;
    });

    if (!_validateInputs()) {
      return;
    }

    final DateFormat inputFormat = DateFormat("M/d/yyyy");
    final DateTime parsedDate = inputFormat.parse(_dateOfBirthController.text);

    BlocProvider.of<SignUpBloc>(context).add(
      SignUpRequested(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        email: _emailController.text,
        dateOfBirth: parsedDate,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      ),
    );
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
    if (password.length < 3) {
      _showError('Password length cannot be less than 3.');
      return false;
    }
    return true;
  }

  void _showError(String error) {
    setState(() {
      _errorMessage = error;
    });
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegExp.hasMatch(email);
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
      String formattedDate = DateFormat.yMd().format(pickedDate);
      _dateOfBirthController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageProvider.translate('signUp'),
          style: const TextStyle(fontSize: 30.0, color: Colors.blue),
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
              const Text(
                "SignChat",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Username'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('First Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Last Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Email'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: languageProvider.translate('Password'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _dateOfBirthController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 20),

              if (_errorMessage != null) ...[
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 10),
              ],

              BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign-up successful")),
                    );
                    context.go('/signin');
                  } else if (state is SignUpFailure) {
                    setState(() {
                      _errorMessage = state.message;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is SignUpLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      languageProvider.translate('signUp'),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.go('/signin');
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





