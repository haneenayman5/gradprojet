import 'package:untitled3/features/auth/domain/entities/user_token_entity.dart';

class UserTokenModel extends UserTokenEntity {
  const UserTokenModel({
  required super.token
});

  factory UserTokenModel.fromJson(Map<String, dynamic> json) {
    return UserTokenModel(token: json['token'] as String);
  }
}