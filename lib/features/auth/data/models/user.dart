
import 'package:untitled3/features/auth/domain/entities/UserEntity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String ? username,
    String ? firstName,
    String ? lastName,
    DateTime ? dateOfBirth,
    String ? email
  });

  factory UserModel.fromJson(Map<String, dynamic> map){
    return UserModel(
      username: map['username'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      dateOfBirth: map['dateOfBirth'] ?? DateTime.now(),
      email: map['email'] ?? "",
    );
  }
}