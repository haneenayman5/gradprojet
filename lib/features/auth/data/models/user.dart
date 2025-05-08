import 'package:untitled3/features/auth/domain/entities/UserEntity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? username,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? email,
    String? imageUrl,
  }) : super(
    username: username,
    firstName: firstName,
    lastName: lastName,
    dateOfBirth: dateOfBirth,
    email: email,
    imageUrl: imageUrl
  );

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.tryParse(map['dateOfBirth']) ?? DateTime.now()
          : DateTime.now(),
      email: map['email'] ?? "",
      imageUrl: map['pfpUrl']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'email': email,
      'pfpUrl': imageUrl
    };
  }
}

