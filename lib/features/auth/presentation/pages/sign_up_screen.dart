import 'dart:async';
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
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _errorNotifier.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    _errorNotifier.value = null;

    if (!_validateInputs()) return;

    final DateFormat inputFormat = DateFormat("M/d/yyyy");
    final DateTime parsedDate =
    await Future.microtask(() => inputFormat.parse(_dateOfBirthController.text));

    context.read<SignUpBloc>().add(
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
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final username = _usernameController.text.trim();
    final dob = _dateOfBirthController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (firstName.isEmpty) return _showError('First name cannot be empty.');
    if (lastName.isEmpty) return _showError('Last name cannot be empty.');
    if (username.isEmpty) return _showError('Username cannot be empty.');
    if (dob.isEmpty) return _showError('Date of birth cannot be empty.');
    if (email.isEmpty) return _showError('Email cannot be empty.');
    if (!_isValidEmail(email)) return _showError('Please enter a valid email address.');
    if (password.isEmpty) return _showError('Password cannot be empty.');
    if (password.length < 3) return _showError('Password length cannot be less than 3.');

    return true;
  }

  bool _showError(String message) {
    _errorNotifier.value = message;
    return false;
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dateOfBirthController.text = DateFormat.yMd().format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<LanguageProvider>(
          builder: (context, lang, _) => Text(
            lang.translate('signUp'),
            style: const TextStyle(fontSize: 30.0, color: Colors.blue),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => context.read<LanguageProvider>().toggleLanguage(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "SignChat",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ..._buildFormFields(context),
              const SizedBox(height: 20),
              ValueListenableBuilder<String?>(
                valueListenable: _errorNotifier,
                builder: (_, error, __) {
                  if (error == null) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 16)),
                  );
                },
              ),
              BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign-up successful")),
                    );
                    context.go('/signin');
                  } else if (state is SignUpFailure) {
                    _errorNotifier.value = state.message;
                  }
                },
                builder: (context, state) {
                  if (state is SignUpLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Consumer<LanguageProvider>(
                    builder: (context, lang, _) => ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        lang.translate('signUp'),
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => context.go('/signin'),
                child: Consumer<LanguageProvider>(
                  builder: (context, lang, _) => Text(
                    lang.translate('haveAccount'),
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields(BuildContext context) {
    return [
      _LabeledInput(controller: _usernameController, labelKey: 'Username'),
      _LabeledInput(controller: _firstNameController, labelKey: 'First Name'),
      _LabeledInput(controller: _lastNameController, labelKey: 'Last Name'),
      _LabeledInput(controller: _emailController, labelKey: 'Email'),
      _LabeledInput(controller: _passwordController, labelKey: 'Password', obscure: true),
      GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextField(
            controller: _dateOfBirthController,
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              suffixIcon: const Icon(Icons.calendar_today),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ),
    ];
  }
}

class _LabeledInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelKey;
  final bool obscure;

  const _LabeledInput({
    Key? key,
    required this.controller,
    required this.labelKey,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Consumer<LanguageProvider>(
        builder: (context, lang, _) => TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            labelText: lang.translate(labelKey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
      ),
    );
  }
}
