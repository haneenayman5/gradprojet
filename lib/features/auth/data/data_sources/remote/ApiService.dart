import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/features/auth/data/models/login_request.dart';
import 'package:untitled3/features/auth/data/models/user.dart';
import 'package:untitled3/features/auth/data/models/user_token.dart';

import '../../models/register_request.dart';

part 'ApiService.g.dart';

@RestApi(baseUrl: apiBaseURL)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/Users')//this is not yet implemented in the backend
  Future<HttpResponse<List<UserModel>>> getUsers();

  @POST('/Account/Login')
  Future<HttpResponse<UserTokenModel>> login(@Body() LoginRequest data);

  @POST('/Account/Register')
  Future<HttpResponse> signup(@Body() RegisterRequest data);
}