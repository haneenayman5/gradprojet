import 'dart:io';
import 'package:dio/dio.dart';
import 'package:untitled3/features/auth/data/data_sources/remote/ApiService.dart';
import 'package:untitled3/features/auth/data/models/login_request.dart';
import 'package:untitled3/features/auth/data/models/register_request.dart';
import 'package:untitled3/features/auth/domain/entities/user_token_entity.dart';
import 'package:untitled3/features/auth/domain/repository/auth_repository.dart';
import 'package:untitled3/core/storage/storage.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiService apiService;
  final SecureStorage secureStorage;

  AuthRepositoryImpl(this.apiService, this.secureStorage);

  @override
  Future<UserTokenEntity> signIn(String username, String password) async {
    try {
      final loginRequest = LoginRequest(
        username: username.trim(),
        password: password,
      );
      final response = await apiService.login(loginRequest);

      if (response.response.statusCode == 200 && response.data != null && response.data!.token.isNotEmpty) {
        // Save token and username securely
        await secureStorage.saveToken(response.data!.token);
        await secureStorage.saveUsername(username.trim());

        return response.data!;
      } else if (response.response.statusCode == 401) {
        throw Exception("Wrong username or password.");
      } else {
        throw Exception("Unexpected server response: ${response.response.statusCode}");
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.response?.data.toString() ?? e.message;

      if (statusCode == 401) {
        throw Exception("Wrong username or password.");
      } else {
        throw Exception("Network Error: $errorMessage");
      }
    } catch (e) {
      throw Exception("Unknown error during sign-in: ${e.toString()}");
    }
  }

  @override
  Future<Response<dynamic>> signUp(
      String username,
      String password,
      String firstName,
      String lastName,
      DateTime dateOfBirth,
      String email,
      ) async {
    try {
      final request = RegisterRequest(
        username: username.trim(),
        password: password,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        email: email.trim(),
      );

      final response = await apiService.signup(request);

      if (response.response.statusCode == 200) {
        return response.response;
      } else {
        throw Exception(response.response.statusMessage ?? "Sign-Up failed.");
      }
    } on DioException catch (e) {
      throw Exception("Sign-Up Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      throw Exception("Unknown error during sign-up: ${e.toString()}");
    }
  }
}
