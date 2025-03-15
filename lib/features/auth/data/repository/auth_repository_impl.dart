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

  AuthRepositoryImpl( this.apiService, this.secureStorage);

  @override
  Future<UserTokenEntity> signIn(String username, String password) async {
    LoginRequest data = LoginRequest(username: username.trim(), password: password);
    final response = await apiService.login(data);

    if(response.data.token.isNotEmpty)
    {
       await secureStorage.saveToken(response.data.token);
       await secureStorage.saveUsername(username);
       return response.data;
    }
    else
      {
        throw Exception(response.response.statusMessage ?? "Sign-In Failed");
      }
  }

  @override
  Future<Response<dynamic>> signUp(String username, String password, String firstName, String lastName, DateTime dateOfBirth, String email) async {
    RegisterRequest data = RegisterRequest(username: username, password: password, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, email: email);

    final response = await apiService.signup(data);

    if(response.response.statusCode == 200)
    {
      return response.response;
    }
    else
    {
      throw Exception(response.response.statusMessage ?? "Sign-Up Failed");
    }
  }

}